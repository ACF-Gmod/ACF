AddCSLuaFile( "ACF/Shared/Rounds/RoundHEAT.lua" )

local DefTable = {}
	DefTable.type = "Ammo"										--Tells the spawn menu what entity to spawn
	DefTable.name = "High Explosive Anti-Tank (HEAT)"					--Human readable name
	DefTable.model = "models/munitions/round_100mm_shot.mdl"	--Shell flight model
	DefTable.desc = "A shaped charge explosive shell, detonating on impact and sending a stream of molten metal do penetrate armour along with normal, if reduced, explosive effects"
	DefTable.netid = 4											--Unique ammotype ID for network transmission
		
	DefTable.create = function( Gun, BulletData ) ACF_HEATCreate( Gun, BulletData ) end
	DefTable.convert = function( Crate, Table ) local Result = ACF_HEATConvert( Crate, Table ) return Result end
	DefTable.network = function( Crate, BulletData ) ACF_HEATNetworkData( Crate, BulletData ) end
	DefTable.cratetxt = function( Crate ) local Result =  ACF_HEATCrateDisplay( Crate ) return Result end		
	
	DefTable.propimpact = function( Bullet, Index, Target, HitNormal, HitPos , Bone ) local Result = ACF_HEATPropImpact( Bullet, Index, Target, HitNormal, HitPos , Bone ) return Result end
	DefTable.worldimpact = function( Bullet, Index, HitPos, HitNormal ) local Result = ACF_HEATWorldImpact( Bullet, Index, HitPos, HitNormal ) return Result end
	DefTable.endflight = function( Bullet, Index, HitPos, HitNormal ) ACF_HEATEndFlight( Bullet, Index, HitPos, HitNormal ) end
	
	DefTable.endeffect = function( Effect, Bullet ) ACF_HEATEndEffect( Effect, Bullet ) end
	DefTable.pierceeffect = function( Effect, Bullet ) ACF_HEATPierceEffect( Effect, Bullet ) end
	DefTable.ricocheteffect = function( Effect, Bullet ) ACF_HEATRicochetEffect( Effect, Bullet ) end
	
	DefTable.guicreate = function( Panel, Table ) ACF_HEATGUICreate( Panel, Table ) end	--References the function to use to draw that round menu
	DefTable.guiupdate = function( Panel, Table ) ACF_HEATGUIUpdate( Panel, Table ) end	--References the function to use to update that round menu

list.Set( "ACFRoundTypes", "HEAT", DefTable )  --Set the round properties
list.Set( "ACFIdRounds", DefTable.netid , "HEAT" ) --Index must equal the ID entry in the table above, Data must equal the index of the table above

ACF.AmmoBlacklist["HEAT"] = { "MG", "HMG", "RAC", "AC" }

function ACF_HEATConvert( Crate, PlayerData )		--Function to convert the player's slider data into the complete round data
	
	local Data = {}
	local ServerData = {}
	local GUIData = {}
	
	if not PlayerData["PropLength"] then PlayerData["PropLength"] = 0 end
	if not PlayerData["ProjLength"] then PlayerData["ProjLength"] = 0 end
	if not PlayerData["Data5"] then PlayerData["Data5"] = 0 end
	if not PlayerData["Data6"] then PlayerData["Data6"] = 0 end
	if not PlayerData["Data7"] then PlayerData["Data7"] = 0 end
	if not PlayerData["Data10"] then PlayerData["Data10"] = 0 end
	
	PlayerData, Data, ServerData, GUIData = ACF_RoundBaseGunpowder( PlayerData, Data, ServerData, GUIData )

	local ConeThick = Data["Caliber"]/50
	local ConeLength = 0
	local ConeAera = 0
	local AirVol = 0
	ConeLength, ConeAera, AirVol = ACF_HEATConeCalc( PlayerData["Data6"], Data["Caliber"]/2, PlayerData["ProjLength"] )
	Data["ProjMass"] = math.max(GUIData["ProjVolume"]-PlayerData["Data5"],0)*7.9/1000 + math.min(PlayerData["Data5"],GUIData["ProjVolume"])*ACF.HEDensity/1000 + ConeAera*ConeThick*7.9/1000 --Volume of the projectile as a cylinder - Volume of the filler - Volume of the crush cone * density of steel + Volume of the filler * density of TNT + Aera of the cone * thickness * density of steel
	Data["MuzzleVel"] = ACF_MuzzleVelocity( Data["PropMass"], Data["ProjMass"], Data["Caliber"] )
	local Energy = ACF_Kinetic( Data["MuzzleVel"]*39.37 , Data["ProjMass"], Data["LimitVel"] )
	
	local MaxVol = 0
	local MaxLength = 0
	local MaxRadius = 0
	MaxVol, MaxLength, MaxRadius = ACF_RoundShellCapacity( Energy.Momentum, Data["FrAera"], Data["Caliber"], Data["ProjLength"] )
		
	GUIData["MinConeAng"] = 0
	GUIData["MaxConeAng"] = math.deg( math.atan((Data["ProjLength"] - ConeThick )/(Data["Caliber"]/2)) )
	GUIData["ConeAng"] = math.Clamp(PlayerData["Data6"]*1, GUIData["MinConeAng"], GUIData["MaxConeAng"])
	ConeLength, ConeAera, AirVol = ACF_HEATConeCalc( GUIData["ConeAng"], Data["Caliber"]/2, Data["ProjLength"] )
	local ConeVol = ConeAera * ConeThick
		
	GUIData["MinFillerVol"] = 0
	GUIData["MaxFillerVol"] = math.max(MaxVol -  AirVol - ConeVol,GUIData["MinFillerVol"])
	GUIData["FillerVol"] = math.Clamp(PlayerData["Data5"]*1,GUIData["MinFillerVol"],GUIData["MaxFillerVol"])
	
	Data["FillerMass"] = GUIData["FillerVol"] * ACF.HEDensity/1000
	Data["ProjMass"] = math.max(GUIData["ProjVolume"]-GUIData["FillerVol"]- AirVol-ConeVol,0)*7.9/1000 + Data["FillerMass"] + ConeVol*7.9/1000
	Data["MuzzleVel"] = ACF_MuzzleVelocity( Data["PropMass"], Data["ProjMass"], Data["Caliber"] )
	local Energy = ACF_Kinetic( Data["MuzzleVel"]*39.37 , Data["ProjMass"], Data["LimitVel"] )
	
	--Let's calculate the actual HEAT slug
	Data["SlugMass"] = ConeVol*7.9/1000
	local Rad = math.rad(GUIData["ConeAng"]/2)
	Data["SlugCaliber"] =  Data["Caliber"] - Data["Caliber"] * (math.sin(Rad)*0.5+math.cos(Rad)*1.5)/2
	Data["SlugMV"] = ( Data["FillerMass"]/2 * ACF.HEPower * math.sin(math.rad(10+GUIData["ConeAng"])/2) /Data["SlugMass"])^ACF.HEATMVScale
	
	local SlugFrAera = 3.1416 * (Data["SlugCaliber"]/2)^2
	Data["SlugPenAera"] = SlugFrAera^ACF.PenAreaMod
	Data["SlugDragCoef"] = ((SlugFrAera/10000)/Data["SlugMass"])
	Data["SlugRicochet"] = 	500									--Base ricochet angle (The HEAT slug shouldn't ricochet at all)
	
	Data["CasingMass"] = Data["ProjMass"] - Data["FillerMass"] - ConeVol*7.9/1000

	--Random bullshit left
	Data["ShovePower"] = 0.1
	Data["PenAera"] = Data["FrAera"]^ACF.PenAreaMod
	Data["DragCoef"] = ((Data["FrAera"]/10000)/Data["ProjMass"])
	Data["LimitVel"] = 100										--Most efficient penetration speed in m/s
	Data["KETransfert"] = 0.1									--Kinetic energy transfert to the target for movement purposes
	Data["Ricochet"] = 60										--Base ricochet angle
	
	Data["Detonated"] = false
	Data["BoomPower"] = Data["PropMass"] + Data["FillerMass"]

	if SERVER then --Only the crates need this part
		ServerData["Id"] = PlayerData["Id"]
		ServerData["Type"] = PlayerData["Type"]
		return table.Merge(Data,ServerData)
	end
	
	if CLIENT then --Only the GUI needs this part	
		local SlugEnergy = ACF_Kinetic( Data["SlugMV"]*39.37 , Data["SlugMass"], 9999999 )
		GUIData["MaxPen"] = (SlugEnergy.Penetration/Data["SlugPenAera"])*ACF.KEtoRHA
		GUIData["BlastRadius"] = (Data["FillerMass"]/2)^0.33*5*10
		GUIData["Fragments"] = math.max(math.floor((Data["FillerMass"]/Data["CasingMass"])*ACF.HEFrag),2)
		GUIData["FragMass"] = Data["CasingMass"]/GUIData["Fragments"]
		GUIData["FragVel"] = (Data["FillerMass"]*ACF.HEPower*1000/Data["CasingMass"]/GUIData["Fragments"])^0.5
		return table.Merge(Data,GUIData)
	end
	
end

function ACF_HEATConeCalc( ConeAngle, Radius, Length )

	local ConeLength = math.tan(math.rad(ConeAngle))*Radius
	local ConeAera = 3.1416 * Radius * (Radius^2 + ConeLength^2)^0.5
	local ConeVol = (3.1416 * Radius^2 * ConeLength)/3

	return ConeLength, ConeAera, ConeVol
end

function ACF_HEATCreate( Gun, BulletData )
	
	ACF_CreateBullet( BulletData )
	
end

function ACF_HEATPropImpact( Index, Bullet, Target, HitNormal, HitPos , Bone ) 	--Can be called from other round types

	if ACF_Check( Target ) then
			
		if Bullet["Detonated"] then
			
			local Speed = Bullet["Flight"]:Length() / ACF.VelScale
			local Energy = ACF_Kinetic( Speed , Bullet["ProjMass"], 999999 )
			local HitRes = ACF_RoundImpact( Bullet, Speed, Energy, Target, HitPos, HitNormal , Bone )
			
			if HitRes.Overkill > 0 then
				table.insert( Bullet["Filter"] , Target )					--"Penetrate" (Ingoring the prop for the retry trace)
				ACF_Spall( HitPos , Bullet["Flight"] , Bullet["Filter"] , Energy.Kinetic*HitRes.Loss , Bullet["Caliber"] , Target.ACF.Armour , Bullet["Owner"] ) --Do some spalling
				Bullet["Flight"] = Bullet["Flight"]:GetNormalized() * (Energy.Kinetic*(1-HitRes.Loss)*2000/Bullet["ProjMass"])^0.5 * 39.37
				return "Penetrated"
			else
				return false
			end
	
		else
			
			local Speed = Bullet["Flight"]:Length() / ACF.VelScale
			local Energy = ACF_Kinetic( Speed , Bullet["ProjMass"] - Bullet["FillerMass"], Bullet["LimitVel"] )
			local HitRes = ACF_RoundImpact( Bullet, Speed, Energy, Target, HitPos, HitNormal , Bone )
			
			if HitRes.Ricochet then
				return "Ricochet"
			else
				ACF_HEATDetonate( Index, Bullet, HitPos, HitNormal )
				return "Penetrated"
			end
			
		end
	else
		table.insert( Bullet["Filter"] , Target )
		return "Penetrated"
	end
	
	return false

end

function ACF_HEATWorldImpact( Index, Bullet, HitPos, HitNormal )

	if not Bullet["Detonated"] then	
		ACF_HEATDetonate( Index, Bullet, HitPos, HitNormal )
		return "Penetrated"
	end
	
	local Energy = ACF_Kinetic( Bullet["Flight"]:Length() / ACF.VelScale, Bullet["ProjMass"], 999999 )
	if ACF_PenetrateGround( Bullet, Energy, HitPos ) then
		return "Penetrated"
	else
		return false
	end
	
end

function ACF_HEATEndFlight( Index, Bullet, HitPos, HitNormal )
	
	ACF_RemoveBullet( Index )
	
end

function ACF_HEATDetonate( Index, Bullet, HitPos, HitNormal )

	ACF_HE( HitPos - Bullet["Flight"] * 0.015 , HitNormal , Bullet["FillerMass"]/2 , Bullet["CasingMass"] , Bullet["Owner"] )

	Bullet["Detonated"] = true
	Bullet["Pos"] = HitPos
	Bullet["Flight"] = Bullet["Flight"] + Bullet["Flight"]:GetNormalized() * Bullet["SlugMV"] * 39.37
	Bullet["DragCoef"] = Bullet["SlugDragCoef"]
	
	Bullet["ProjMass"] = Bullet["SlugMass"]
	Bullet["Caliber"] = Bullet["SlugCaliber"]
	Bullet["PenAera"] = Bullet["SlugPenAera"]
	Bullet["Ricochet"] = Bullet["SlugRicochet"]
	
	local DeltaTime = SysTime() - Bullet["LastThink"]
	Bullet["StartTrace"] = Bullet["Pos"] - Bullet["Flight"]:GetNormalized()*math.min(ACF.PhysMaxVel*DeltaTime,Bullet["FlightTime"]*Bullet["Flight"]:Length())
	Bullet["NextPos"] = Bullet["Pos"] + (Bullet["Flight"] * ACF.VelScale * DeltaTime)		--Calculates the next shell position
	
end

--Ammocrate stuff
function ACF_HEATNetworkData( Crate, BulletData )

	Crate:SetNetworkedString("AmmoType","HEAT")
	Crate:SetNetworkedString("AmmoID",BulletData["Id"])
	
	Crate:SetNetworkedInt("Caliber",BulletData["Caliber"])	
	Crate:SetNetworkedInt("ProjMass",BulletData["ProjMass"])
	Crate:SetNetworkedInt("FillerMass",BulletData["FillerMass"])
	Crate:SetNetworkedInt("PropMass",BulletData["PropMass"])
	Crate:SetNetworkedInt("DragCoef",BulletData["DragCoef"])
	
	Crate:SetNetworkedInt("SlugMass",BulletData["SlugMass"])
	Crate:SetNetworkedInt("SlugCaliber",BulletData["SlugCaliber"])
	Crate:SetNetworkedInt("SlugDragCoef",BulletData["SlugDragCoef"])
	
	Crate:SetNetworkedInt("MuzzleVel",BulletData["MuzzleVel"])
	Crate:SetNetworkedInt("Tracer",BulletData["Tracer"])

end

function ACF_HEATCrateDisplay( Crate )

	local Tracer = ""
	if Crate:GetNetworkedInt("Tracer") > 0 then Tracer = "-T" end
	
	local ProjMass = math.floor(Crate:GetNetworkedString("ProjMass")*1000)
	local PropMass = math.floor(Crate:GetNetworkedString("PropMass")*1000)
	local FillerMass = math.floor(Crate:GetNetworkedString("FillerMass")*1000)
	
	local txt = "Round Mass : "..ProjMass.." g\nPropellant : "..PropMass.." g\nHE Content : "..FillerMass.." g"
	
	return txt
end

--Clientside effects
function ACF_HEATDetEffect( Effect, Bullet )
	
	local Radius = (Bullet.FillerMass)^0.33*8*39.37
	local Flash = EffectData()
		Flash:SetOrigin( Bullet.SimPos )
		Flash:SetNormal( Bullet.SimFlight:GetNormalized() )
		Flash:SetRadius( math.max( Radius, 1 ) )
	util.Effect( "ACF_HEAT_Explosion", Flash )
	
end

function ACF_HEATEndEffect( Effect, Bullet )	--Bullet stops here, do what you  have to do clientside
	
	local Impact = EffectData()
		Impact:SetOrigin( Bullet.SimPos )
		Impact:SetNormal( (Bullet.SimFlight):GetNormalized() )
		Impact:SetScale( Bullet.SimFlight:Length() )
		Impact:SetMagnitude( Bullet.RoundMass )
	util.Effect( "ACF_AP_Impact", Impact )

end

function ACF_HEATPierceEffect( Effect, Bullet )	--Bullet penetrated something, do what you have to clientside
	
	if Bullet.Detonated then
	
		local Spall = EffectData()
			Spall:SetOrigin( Bullet.SimPos )
			Spall:SetNormal( (Bullet.SimFlight):GetNormalized() )
			Spall:SetScale( Bullet.SimFlight:Length() )
			Spall:SetMagnitude( Bullet.RoundMass )
		util.Effect( "ACF_AP_Penetration", Spall )
	
	else
		
		ACF_HEATDetEffect( Effect, Bullet )
		Bullet.Detonated = true
		Effect:SetModel("models/Gibs/wood_gib01e.mdl")
	
	end

end

function ACF_HEATRicochetEffect( Effect, Bullet )	--Bullet ricocheted off something, do what you have to clientside

	local Spall = EffectData()
		Spall:SetOrigin( Bullet.SimPos )
		Spall:SetNormal( (Bullet.SimFlight):GetNormalized() )
		Spall:SetScale( Bullet.SimFlight:Length() )
		Spall:SetMagnitude( Bullet.RoundMass )
	util.Effect( "ACF_AP_Ricochet", Spall )

end

--GUI stuff after this
function ACF_HEATGUICreate( Panel, Table )

	acfmenupanel:AmmoSelect( ACF.AmmoBlacklist["HEAT"] )
	
	acfmenupanel:CPanelText("Desc", "")	--Description (Name, Desc)
	acfmenupanel:CPanelText("LengthDisplay", "")	--Total round length (Name, Desc)
	
	--Slider (Name, Value, Min, Max, Decimals, Title, Desc)
	acfmenupanel:AmmoSlider("PropLength",0,0,1000,3, "Propellant Length", "")	
	acfmenupanel:AmmoSlider("ProjLength",0,0,1000,3, "Projectile Length", "")	
	acfmenupanel:AmmoSlider("ConeAng",0,0,1000,3, "HEAT Cone Angle", "")
	acfmenupanel:AmmoSlider("FillerVol",0,0,1000,3, "Total HEAT Warhead volume", "")
	
	acfmenupanel:AmmoCheckbox("Tracer", "Tracer", "")			--Tracer checkbox (Name, Title, Desc)
	
	acfmenupanel:CPanelText("VelocityDisplay", "")	--Proj muzzle velocity (Name, Desc)
	acfmenupanel:CPanelText("BlastDisplay", "")	--HE Blast data (Name, Desc)
	acfmenupanel:CPanelText("FragDisplay", "")	--HE Fragmentation data (Name, Desc)
	
	acfmenupanel:CPanelText("SlugDisplay", "")	--HEAT Slug data (Name, Desc)
	
	ACF_HEATGUIUpdate( Panel, Table )
	
end

function ACF_HEATGUIUpdate( Panel, Table )

	local PlayerData = {}
		PlayerData["Id"] = acfmenupanel.AmmoData["Data"]["id"]			--AmmoSelect GUI
		PlayerData["Type"] = "HEAT"										--Hardcoded, match ACFRoundTypes table index
		PlayerData["PropLength"] = acfmenupanel.AmmoData["PropLength"]	--PropLength slider
		PlayerData["ProjLength"] = acfmenupanel.AmmoData["ProjLength"]	--ProjLength slider
		PlayerData["Data5"] = acfmenupanel.AmmoData["FillerVol"]
		PlayerData["Data6"] = acfmenupanel.AmmoData["ConeAng"]			--Not used
		--PlayerData["Data7"] = acfmenupanel.AmmoData[Name]		--Not used
		--PlayerData["Data8"] = acfmenupanel.AmmoData[Name]		--Not used
		--PlayerData["Data9"] = acfmenupanel.AmmoData[Name]		--Not used
		local Tracer = 0
		if acfmenupanel.AmmoData["Tracer"] then Tracer = 1 end
		PlayerData["Data10"] = Tracer				--Tracer
	
	local Data = ACF_HEATConvert( Panel, PlayerData )
	
	RunConsoleCommand( "acfmenu_data1", acfmenupanel.AmmoData["Data"]["id"] )
	RunConsoleCommand( "acfmenu_data2", PlayerData["Type"] )
	RunConsoleCommand( "acfmenu_data3", Data.PropLength )		--For Gun ammo, Data3 should always be Propellant
	RunConsoleCommand( "acfmenu_data4", Data.ProjLength )
	RunConsoleCommand( "acfmenu_data5", Data.FillerVol )
	RunConsoleCommand( "acfmenu_data6", Data.ConeAng )
	RunConsoleCommand( "acfmenu_data10", Data.Tracer )
	
	acfmenupanel:AmmoSlider("PropLength",Data.PropLength,Data.MinPropLength,Data["MaxTotalLength"],3, "Propellant Length", "Propellant Mass : "..(math.floor(Data.PropMass*1000)).." g" )	--Propellant Length Slider (Name, Min, Max, Decimals, Title, Desc)
	acfmenupanel:AmmoSlider("ProjLength",Data.ProjLength,Data.MinProjLength,Data["MaxTotalLength"],3, "Projectile Length", "Projectile Mass : "..(math.floor(Data.ProjMass*1000)).." g")	--Projectile Length Slider (Name, Min, Max, Decimals, Title, Desc)
	acfmenupanel:AmmoSlider("ConeAng",Data.ConeAng,Data.MinConeAng,Data.MaxConeAng,0, "Crush Cone Angle", "")	--HE Filler Slider (Name, Min, Max, Decimals, Title, Desc)
	acfmenupanel:AmmoSlider("FillerVol",Data.FillerVol,Data.MinFillerVol,Data.MaxFillerVol,3, "HE Filler Volume", "HE Filler Mass : "..(math.floor(Data["FillerMass"]*1000)).." g")	--HE Filler Slider (Name, Min, Max, Decimals, Title, Desc)
	
	acfmenupanel:AmmoCheckbox("Tracer", "Tracer : "..(math.floor(Data.Tracer*10)/10).."cm\n", "" )			--Tracer checkbox (Name, Title, Desc)

	acfmenupanel:CPanelText("Desc", ACF.RoundTypes[PlayerData["Type"]]["desc"])	--Description (Name, Desc)
	acfmenupanel:CPanelText("LengthDisplay", "Round Length : "..(math.floor((Data.PropLength+Data.ProjLength+Data.Tracer)*100)/100).."/"..(Data.MaxTotalLength).." cm")	--Total round length (Name, Desc)
	acfmenupanel:CPanelText("VelocityDisplay", "Muzzle Velocity : "..math.floor(Data.MuzzleVel*ACF.VelScale).." m/s")	--Proj muzzle velocity (Name, Desc)	
	acfmenupanel:CPanelText("BlastDisplay", "Blast Radius : "..(math.floor(Data.BlastRadius*100)/1000).." m/n")	--Proj muzzle velocity (Name, Desc)
	acfmenupanel:CPanelText("FragDisplay", "Fragments : "..(Data.Fragments).."\n Average Fragment Weight : "..(math.floor(Data.FragMass*10000)/10).." g \n Average Fragment Velocity : "..math.floor(Data.FragVel).." m/s")	--Proj muzzle penetration (Name, Desc)

	acfmenupanel:CPanelText("SlugDisplay", "Penetrator Mass : "..(math.floor(Data.SlugMass*10000)/10).." g \n Penetrator Caliber : "..(math.floor(Data.SlugCaliber*100)/10).." mm \n Penetrator Velocity : "..math.floor(Data.SlugMV).." m/s \n Penetrator Maximum Penetration : "..math.floor(Data.MaxPen).." mm RHA\n")	--Proj muzzle penetration (Name, Desc)
	
end