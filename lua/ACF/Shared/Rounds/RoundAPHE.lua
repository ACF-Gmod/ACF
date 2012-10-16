AddCSLuaFile( "ACF/Shared/Rounds/RoundAPHE.lua" )

local DefTable = {}
	DefTable.type = "Ammo"										--Tells the spawn menu what entity to spawn
	DefTable.name = "Armour Piercing Explosive (APHE)"			--Human readable name
	DefTable.model = "models/munitions/round_100mm_shot.mdl"	--Shell flight model
	DefTable.desc = "An armour piercing round with a cavity for High explosives. Less capable of defeating armour than plain Armour Piercing, but will explode after penetration"
	DefTable.netid = 5											--Unique ammotype ID for network transmission
	
	DefTable.create = function( Gun, BulletData ) ACF_APHECreate( Gun, BulletData ) end --Uses basic AP function
	DefTable.convert = function( Crate, Table ) local Result = ACF_APHEConvert( Crate, Table ) return Result end --Uses custom function
	DefTable.network = function( Crate, BulletData ) ACF_APHENetworkData( Crate, BulletData ) end	
	DefTable.cratetxt = function( Crate ) local Result =  ACF_APHECrateDisplay( Crate ) return Result end	
	
	DefTable.propimpact = function( Bullet, Index, Target, HitNormal, HitPos , Bone ) local Result = ACF_APHEPropImpact( Bullet, Index, Target, HitNormal, HitPos , Bone ) return Result end --Uses basic AP function
	DefTable.worldimpact = function( Bullet, Index, HitPos, HitNormal ) local Result = ACF_APHEWorldImpact( Bullet, Index, HitPos, HitNormal ) return Result end --Uses basic AP function
	DefTable.endflight = function( Bullet, Index, HitPos, HitNormal ) ACF_APHEEndFlight( Bullet, Index, HitPos, HitNormal ) end --Uses basic AP function
	
	DefTable.endeffect = function( Effect, Bullet ) ACF_APHEEndEffect( Effect, Bullet ) end --Uses basic AP function
	DefTable.pierceeffect = function( Effect, Bullet ) ACF_APHEPierceEffect( Effect, Bullet ) end --Uses basic AP function
	DefTable.ricocheteffect = function( Effect, Bullet ) ACF_APHERicochetEffect( Effect, Bullet ) end --Uses basic AP function
	
	DefTable.guicreate = function( Panel, Table ) ACF_APHEGUICreate( Panel, Table ) end	--References the function to use to draw that round menu, must use custom function
	DefTable.guiupdate = function( Panel, Table ) ACF_APHEGUIUpdate( Panel, Table ) end	--References the function to use to update that round menu, must use custom function

list.Set( "ACFRoundTypes", "APHE", DefTable )  --Set the round properties
list.Set( "ACFIdRounds", DefTable.netid , "APHE" ) --Index must equal the ID entry in the table above, Data must equal the index of the table above

ACF.AmmoBlacklist["APHE"] = { "MO", "MG" }

AddCSLuaFile( "ACF/Shared/Rounds/RoundHE.lua" )

function ACF_APHEConvert( Crate, PlayerData )		--Function to convert the player's slider data into the complete round data
	
	local Data = {}
	local ServerData = {}
	local GUIData = {}
	
	if not PlayerData["PropLength"] then PlayerData["PropLength"] = 0 end
	if not PlayerData["ProjLength"] then PlayerData["ProjLength"] = 0 end
	if not PlayerData["Data5"] then PlayerData["Data5"] = 0 end
	if not PlayerData["Data10"] then PlayerData["Data10"] = 0 end
	
	PlayerData, Data, ServerData, GUIData = ACF_RoundBaseGunpowder( PlayerData, Data, ServerData, GUIData )
	
	--Shell sturdiness calcs
	Data["ProjMass"] = math.max(GUIData["ProjVolume"]-PlayerData["Data5"],0)*7.9/1000 + math.min(PlayerData["Data5"],GUIData["ProjVolume"])*ACF.HEDensity/1000--Volume of the projectile as a cylinder - Volume of the filler * density of steel + Volume of the filler * density of TNT
	Data["MuzzleVel"] = ACF_MuzzleVelocity( Data["PropMass"], Data["ProjMass"], Data["Caliber"] )
	local Energy = ACF_Kinetic( Data["MuzzleVel"]*39.37 , Data["ProjMass"], Data["LimitVel"] )
		
	local MaxVol = ACF_RoundShellCapacity( Energy.Momentum, Data["FrAera"], Data["Caliber"], Data["ProjLength"] )
	GUIData["MinFillerVol"] = 0
	GUIData["MaxFillerVol"] = math.min(GUIData["ProjVolume"],MaxVol*0.9)
	GUIData["FillerVol"] = math.min(PlayerData["Data5"],GUIData["MaxFillerVol"])
	Data["FillerMass"] = GUIData["FillerVol"] * ACF.HEDensity/1000
	
	Data["ProjMass"] = math.max(GUIData["ProjVolume"]-GUIData["FillerVol"],0)*7.9/1000 + Data["FillerMass"]
	Data["MuzzleVel"] = ACF_MuzzleVelocity( Data["PropMass"], Data["ProjMass"], Data["Caliber"] )
	
	--Random bullshit left
	Data["ShovePower"] = 0.1
	Data["PenAera"] = Data["FrAera"]^ACF.PenAreaMod
	Data["DragCoef"] = ((Data["FrAera"]/10000)/Data["ProjMass"])
	Data["LimitVel"] = 700										--Most efficient penetration speed in m/s
	Data["KETransfert"] = 0.1									--Kinetic energy transfert to the target for movement purposes
	Data["Ricochet"] = 75										--Base ricochet angle
	
	Data["BoomPower"] = Data["PropMass"] + Data["FillerMass"]

	if SERVER then --Only the crates need this part
		ServerData["Id"] = PlayerData["Id"]
		ServerData["Type"] = PlayerData["Type"]
		return table.Merge(Data,ServerData)
	end
	
	if CLIENT then --Only tthe GUI needs this part
		local Energy = ACF_Kinetic( Data["MuzzleVel"]*39.37 , Data["ProjMass"] - Data["FillerMass"], Data["LimitVel"] )
		GUIData["MaxPen"] = (Energy.Penetration/Data["PenAera"])*ACF.KEtoRHA
		
		GUIData["BlastRadius"] = Data["FillerMass"]^0.33*5*10	
		local FragMass = Data["ProjMass"] - Data["FillerMass"]
		GUIData["Fragments"] = math.max(math.floor((Data["FillerMass"]/FragMass)*ACF.HEFrag),2)
		GUIData["FragMass"] = FragMass/GUIData["Fragments"]
		GUIData["FragVel"] = (Data["FillerMass"]*ACF.HEPower*1000/GUIData["FragMass"]/GUIData["Fragments"])^0.5
		return table.Merge(Data,GUIData)
	end
	
end

function ACF_APHECreate( Gun, BulletData )
	
	ACF_CreateBullet( BulletData )
	
end

function ACF_APHEPropImpact( Index, Bullet, Target, HitNormal, HitPos , Bone ) 	--Can be called from other round types

	if ACF_Check( Target ) then
	
		local Speed = Bullet["Flight"]:Length() / ACF.VelScale
		local Energy = ACF_Kinetic( Speed , Bullet["ProjMass"] - Bullet["FillerMass"], Bullet["LimitVel"] )
		local HitRes = ACF_RoundImpact( Bullet, Speed, Energy, Target, HitPos, HitNormal , Bone )
		
		if HitRes.Overkill > 0 then
			table.insert( Bullet["Filter"] , Target )					--"Penetrate" (Ingoring the prop for the retry trace)
			ACF_Spall( HitPos , Bullet["Flight"] , Bullet["Filter"] , Energy.Kinetic*HitRes.Loss , Bullet["Caliber"] , Target.ACF.Armour , Bullet["Owner"] ) --Do some spalling
			Bullet["Flight"] = Bullet["Flight"]:GetNormalized() * (Energy.Kinetic*(1-HitRes.Loss)*2000/Bullet["ProjMass"])^0.5 * 39.37
			return "Penetrated"
		elseif HitRes.Ricochet then
			return "Ricochet"
		else
			return false
		end
	else 
		table.insert( Bullet["Filter"] , Target )
	return "Penetrated" end
	
end

function ACF_APHEWorldImpact( Index, Bullet, HitPos, HitNormal )
	local Energy = ACF_Kinetic( Bullet["Flight"]:Length() / ACF.VelScale, Bullet["ProjMass"] - Bullet["FillerMass"], Bullet["LimitVel"] )
	if ACF_PenetrateGround( Bullet, Energy, HitPos ) then
		return "Penetrated"
	else
		return false
	end

end

function ACF_APHEEndFlight( Index, Bullet, HitPos, HitNormal )
	
	ACF_HE( HitPos - Bullet["Flight"] * 0.015 , HitNormal , Bullet["FillerMass"] , Bullet["ProjMass"] - Bullet["FillerMass"] , Bullet["Owner"] )
	ACF_RemoveBullet( Index )
	
end

--Ammocrate stuff
function ACF_APHENetworkData( Crate, BulletData )

	Crate:SetNetworkedString("AmmoType","APHE")
	Crate:SetNetworkedString("AmmoID",BulletData["Id"])
	Crate:SetNetworkedInt("Caliber",BulletData["Caliber"])	
	Crate:SetNetworkedInt("ProjMass",BulletData["ProjMass"])
	Crate:SetNetworkedInt("FillerMass",BulletData["FillerMass"])
	Crate:SetNetworkedInt("PropMass",BulletData["PropMass"])
	Crate:SetNetworkedInt("DragCoef",BulletData["DragCoef"])
	Crate:SetNetworkedInt("MuzzleVel",BulletData["MuzzleVel"])
	Crate:SetNetworkedInt("Tracer",BulletData["Tracer"])

end

function ACF_APHECrateDisplay( Crate )

	local Tracer = ""
	if Crate:GetNetworkedInt("Tracer") > 0 then Tracer = "-T" end
	
	local ProjMass = math.floor(Crate:GetNetworkedString("ProjMass")*1000)
	local PropMass = math.floor(Crate:GetNetworkedString("PropMass")*1000)
	local FillerMass = math.floor(Crate:GetNetworkedString("FillerMass")*1000)
	
	local txt = "Round Mass : "..ProjMass.." g\nPropellant : "..PropMass.." g\nHE Content : "..FillerMass.." g"
	
	return txt
end

--Clientside effects
function ACF_APHEDetEffect( Effect, Bullet )
	
	local Radius = (Bullet["FillerMass"])^0.33*8*39.37
	local Flash = EffectData()
		Flash:SetOrigin( Bullet["SimPos"] )
		Flash:SetNormal( Bullet["SimFlight"]:GetNormalized() )
		Flash:SetRadius( math.max( Radius, 1 ) )
	util.Effect( "ACF_Scaled_Explosion", Flash )
	
end

function ACF_APHEEndEffect( Effect, Bullet )	--Bullet stops here, do what you  have to do clientside
		
	ACF_HEDetEffect( Effect, Bullet )

end

function ACF_APHEPierceEffect( Effect, Bullet )	--Bullet penetrated something, do what you have to clientside

	local Spall = EffectData()
		Spall:SetOrigin( Bullet.SimPos )
		Spall:SetNormal( (Bullet.SimFlight):GetNormalized() )
		Spall:SetScale( Bullet.SimFlight:Length() )
		Spall:SetMagnitude( Bullet.RoundMass )
	util.Effect( "ACF_AP_Penetration", Spall )

end

function ACF_APHERicochetEffect( Effect, Bullet )	--Bullet ricocheted off something, do what you have to clientside

	local Spall = EffectData()
		Spall:SetOrigin( Bullet.SimPos )
		Spall:SetNormal( (Bullet.SimFlight):GetNormalized() )
		Spall:SetScale( Bullet.SimFlight:Length() )
		Spall:SetMagnitude( Bullet.RoundMass )
	util.Effect( "ACF_AP_Ricochet", Spall )

end

--GUI stuff after this
function ACF_APHEGUICreate( Panel, Table )

	acfmenupanel:AmmoSelect( ACF.AmmoBlacklist["APHE"] )

	acfmenupanel:CPanelText("Desc", "")	--Description (Name, Desc)
	acfmenupanel:CPanelText("LengthDisplay", "")	--Total round length (Name, Desc)
	
	acfmenupanel:AmmoSlider("PropLength",0,0,1000,3, "Propellant Length", "")	--Propellant Length Slider (Name, Value, Min, Max, Decimals, Title, Desc)
	acfmenupanel:AmmoSlider("ProjLength",0,0,1000,3, "Projectile Length", "")	--Projectile Length Slider (Name, Value, Min, Max, Decimals, Title, Desc)
	acfmenupanel:AmmoSlider("FillerVol",0,0,1000,3, "HE Filler", "")--Hollow Point Cavity Slider (Name, Value, Min, Max, Decimals, Title, Desc)
	
	acfmenupanel:AmmoCheckbox("Tracer", "Tracer", "")			--Tracer checkbox (Name, Title, Desc)
	
	acfmenupanel:CPanelText("VelocityDisplay", "")	--Proj muzzle velocity (Name, Desc)
	acfmenupanel:CPanelText("PenetrationDisplay", "")	--Proj muzzle penetration (Name, Desc)
	acfmenupanel:CPanelText("BlastDisplay", "")	--HE Blast data (Name, Desc)
	acfmenupanel:CPanelText("FragDisplay", "")	--HE Fragmentation data (Name, Desc)
	
	ACF_APHEGUIUpdate( Panel, Table )
	
end

function ACF_APHEGUIUpdate( Panel, Table )

	local PlayerData = {}
		PlayerData["Id"] = acfmenupanel.AmmoData["Data"]["id"]			--AmmoSelect GUI
		PlayerData["Type"] = "APHE"										--Hardcoded, match ACFRoundTypes table index
		PlayerData["PropLength"] = acfmenupanel.AmmoData["PropLength"]	--PropLength slider
		PlayerData["ProjLength"] = acfmenupanel.AmmoData["ProjLength"]	--ProjLength slider
		PlayerData["Data5"] = acfmenupanel.AmmoData["FillerVol"]
		--PlayerData["Data6"] = acfmenupanel.AmmoData[Name]		--Not used
		--PlayerData["Data7"] = acfmenupanel.AmmoData[Name]		--Not used
		--PlayerData["Data8"] = acfmenupanel.AmmoData[Name]		--Not used
		--PlayerData["Data9"] = acfmenupanel.AmmoData[Name]		--Not used
		local Tracer = 0
		if acfmenupanel.AmmoData["Tracer"] then Tracer = 1 end
		PlayerData["Data10"] = Tracer				--Tracer
	
	local Data = ACF_APHEConvert( Panel, PlayerData )
	
	RunConsoleCommand( "acfmenu_data1", acfmenupanel.AmmoData["Data"]["id"] )
	RunConsoleCommand( "acfmenu_data2", PlayerData["Type"] )
	RunConsoleCommand( "acfmenu_data3", Data.PropLength )		--For Gun ammo, Data3 should always be Propellant
	RunConsoleCommand( "acfmenu_data4", Data.ProjLength )		--And Data4 total round mass
	RunConsoleCommand( "acfmenu_data5", Data.FillerVol )
	RunConsoleCommand( "acfmenu_data10", Data.Tracer )
	
	acfmenupanel:AmmoSlider("PropLength",Data.PropLength,Data.MinPropLength,Data["MaxTotalLength"],3, "Propellant Length", "Propellant Mass : "..(math.floor(Data.PropMass*1000)).." g" )	--Propellant Length Slider (Name, Min, Max, Decimals, Title, Desc)
	acfmenupanel:AmmoSlider("ProjLength",Data.ProjLength,Data.MinProjLength,Data["MaxTotalLength"],3, "Projectile Length", "Projectile Mass : "..(math.floor(Data.ProjMass*1000)).." g")	--Projectile Length Slider (Name, Min, Max, Decimals, Title, Desc)
	acfmenupanel:AmmoSlider("FillerVol",Data.FillerVol,Data.MinFillerVol,Data.MaxFillerVol,3, "HE Filler Volume", "HE Filler Mass : "..(math.floor(Data["FillerMass"]*1000)).." g")	--HE Filler Slider (Name, Min, Max, Decimals, Title, Desc)
	
	acfmenupanel:AmmoCheckbox("Tracer", "Tracer : "..(math.floor(Data.Tracer*10)/10).."cm\n", "" )			--Tracer checkbox (Name, Title, Desc)

	acfmenupanel:CPanelText("Desc", ACF.RoundTypes[PlayerData["Type"]]["desc"])	--Description (Name, Desc)
	acfmenupanel:CPanelText("LengthDisplay", "Round Length : "..(math.floor((Data.PropLength+Data.ProjLength+Data.Tracer)*100)/100).."/"..(Data.MaxTotalLength).." cm")	--Total round length (Name, Desc)
	acfmenupanel:CPanelText("VelocityDisplay", "Muzzle Velocity : "..math.floor(Data.MuzzleVel*ACF.VelScale).." m/s")	--Proj muzzle velocity (Name, Desc)	
	acfmenupanel:CPanelText("PenetrationDisplay", "Maximum Penetration : "..math.floor(Data.MaxPen).." mm RHA")	--Proj muzzle penetration (Name, Desc)
	acfmenupanel:CPanelText("BlastDisplay", "Blast Radius : "..(math.floor(Data.BlastRadius*100)/1000).." m\n")	--Proj muzzle velocity (Name, Desc)
	acfmenupanel:CPanelText("FragDisplay", "Fragments : "..(Data.Fragments).."\n Average Fragment Weight : "..(math.floor(Data.FragMass*10000)/10).." g \n Average Fragment Velocity : "..math.floor(Data.FragVel).." m/s")	--Proj muzzle penetration (Name, Desc)
	
end
