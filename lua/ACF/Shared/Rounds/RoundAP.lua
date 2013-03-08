AddCSLuaFile( "acf/shared/rounds/roundap.lua" )

local DefTable = {}
	DefTable.type = "Ammo"										--Tells the spawn menu what entity to spawn
	DefTable.name = "Armour Piercing (AP)"							--Human readable name
	DefTable.model = "models/munitions/round_100mm_shot.mdl"	--Shell flight model
	DefTable.desc = "A shell made out of a solid piece of steel, meant to penetrate armour"
	DefTable.netid = 1											--Unique ammotype ID for network transmission
	
	DefTable.create = function( Gun, BulletData ) ACF_APCreate( Gun, BulletData ) end
	DefTable.convert = function( Crate, Table ) local Result = ACF_APConvert( Crate, Table ) return Result end
	DefTable.network = function( Crate, BulletData ) ACF_APNetworkData( Crate, BulletData ) end	
	DefTable.cratetxt = function( Crate ) local Result =  ACF_APCrateDisplay( Crate ) return Result end	
	
	DefTable.propimpact = function( Bullet, Index, Target, HitNormal, HitPos , Bone ) local Result = ACF_APPropImpact( Bullet, Index, Target, HitNormal, HitPos , Bone ) return Result end
	DefTable.worldimpact = function( Bullet, Index, HitPos, HitNormal ) local Result = ACF_APWorldImpact( Bullet, Index, HitPos, HitNormal ) return Result end
	DefTable.endflight = function( Bullet, Index, HitPos, HitNormal ) ACF_APEndFlight( Bullet, Index, HitPos, HitNormal ) end
	
	DefTable.endeffect = function( Effect, Bullet ) ACF_APEndEffect( Effect, Bullet ) end
	DefTable.pierceeffect = function( Effect, Bullet ) ACF_APPierceEffect( Effect, Bullet ) end
	DefTable.ricocheteffect = function( Effect, Bullet ) ACF_APRicochetEffect( Effect, Bullet ) end
	
	DefTable.guicreate = function( Panel, Table ) ACF_APGUICreate( Panel, Table ) end	--References the function to use to draw that round menu
	DefTable.guiupdate = function( Panel, Table ) ACF_APGUIUpdate( Panel, Table ) end	--References the function to use to update that round menu

list.Set( "ACFRoundTypes", "AP", DefTable )  --Set the round properties
list.Set( "ACFIdRounds", DefTable.netid , "AP" ) --Index must equal the ID entry in the table above, Data must equal the index of the table above

ACF.AmmoBlacklist["AP"] = { "MO" }

function ACF_APConvert( Crate, PlayerData )		--Function to convert the player's slider data into the complete round data
	
	local Data = {}
	local ServerData = {}
	local GUIData = {}
	
	if not PlayerData["PropLength"] then PlayerData["PropLength"] = 0 end
	if not PlayerData["ProjLength"] then PlayerData["ProjLength"] = 0 end
	if not PlayerData["Data10"] then PlayerData["Data10"] = 0 end
	
	PlayerData, Data, ServerData, GUIData = ACF_RoundBaseGunpowder( PlayerData, Data, ServerData, GUIData )
	
	Data["ProjMass"] = Data["FrAera"] * (Data["ProjLength"]*7.9/1000) --Volume of the projectile as a cylinder * density of steel
	Data["ShovePower"] = 0.2
	Data["PenAera"] = Data["FrAera"]^ACF.PenAreaMod
	Data["DragCoef"] = ((Data["FrAera"]/10000)/Data["ProjMass"])
	Data["LimitVel"] = 800										--Most efficient penetration speed in m/s
	Data["KETransfert"] = 0.1									--Kinetic energy transfert to the target for movement purposes
	Data["Ricochet"] = 75										--Base ricochet angle
	Data["MuzzleVel"] = ACF_MuzzleVelocity( Data["PropMass"], Data["ProjMass"], Data["Caliber"] )
	
	Data["BoomPower"] = Data["PropMass"]

	if SERVER then --Only the crates need this part
		ServerData["Id"] = PlayerData["Id"]
		ServerData["Type"] = PlayerData["Type"]
		return table.Merge(Data,ServerData)
	end
	
	if CLIENT then --Only tthe GUI needs this part
		local Energy = ACF_Kinetic( Data["MuzzleVel"]*39.37 , Data["ProjMass"], Data["LimitVel"] )
		GUIData["MaxPen"] = (Energy.Penetration/Data["PenAera"])*ACF.KEtoRHA
		return table.Merge(Data,GUIData)
	end
	
end

function ACF_APCreate( Gun, BulletData )
	
	ACF_CreateBullet( BulletData )
	
end

function ACF_APPropImpact( Index, Bullet, Target, HitNormal, HitPos , Bone )	--Can be called from other round types

	if ACF_Check( Target ) then
	
		local Speed = Bullet["Flight"]:Length() / ACF.VelScale
		local Energy = ACF_Kinetic( Speed , Bullet["ProjMass"], Bullet["LimitVel"] )
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

function ACF_APWorldImpact( Index, Bullet, HitPos, HitNormal )
	
	local Energy = ACF_Kinetic( Bullet["Flight"]:Length() / ACF.VelScale, Bullet["ProjMass"], Bullet["LimitVel"] )
	local Retry = ACF_PenetrateGround( Bullet, Energy, HitPos )
	if Retry then
		return "Penetrated"
	else
		return false
	end

end

function ACF_APEndFlight( Index, Bullet, HitPos )

	ACF_RemoveBullet( Index )
	
end

--Ammocrate stuff
function ACF_APNetworkData( Crate, BulletData )

	Crate:SetNetworkedString("AmmoType","AP")
	Crate:SetNetworkedString("AmmoID",BulletData["Id"])
	Crate:SetNetworkedInt("Caliber",BulletData["Caliber"])	
	Crate:SetNetworkedInt("ProjMass",BulletData["ProjMass"])
	Crate:SetNetworkedInt("PropMass",BulletData["PropMass"])
	Crate:SetNetworkedInt("DragCoef",BulletData["DragCoef"])
	Crate:SetNetworkedInt("MuzzleVel",BulletData["MuzzleVel"])
	Crate:SetNetworkedInt("Tracer",BulletData["Tracer"])

end

function ACF_APCrateDisplay( Crate )

	local Tracer = ""
	if Crate:GetNetworkedInt("Tracer") > 0 then Tracer = "-T" end
	
	local ProjMass = math.floor(Crate:GetNetworkedString("ProjMass")*1000)
	local PropMass = math.floor(Crate:GetNetworkedString("PropMass")*1000)
	
	local txt = "Round Mass : "..ProjMass.." g\nPropellant : "..PropMass.." g"
	
	return txt
end

--Clientside effects, called from ACF_Bulleteffect
function ACF_APEndEffect( Effect, Bullet )	--Bullet stops here, do what you  have to do clientside
	
	local Spall = EffectData()
		Spall:SetOrigin( Bullet.SimPos )
		Spall:SetNormal( (Bullet.SimFlight):GetNormalized() )
		Spall:SetScale( Bullet.SimFlight:Length() )
		Spall:SetMagnitude( Bullet.RoundMass )
	util.Effect( "ACF_AP_Impact", Spall )

end

function ACF_APPierceEffect( Effect, Bullet )	--Bullet penetrated something, do what you have to clientside

	local Spall = EffectData()
		Spall:SetOrigin( Bullet.SimPos )
		Spall:SetNormal( (Bullet.SimFlight):GetNormalized() )
		Spall:SetScale( Bullet.SimFlight:Length() )
		Spall:SetMagnitude( Bullet.RoundMass )
	util.Effect( "ACF_AP_Penetration", Spall )

end

function ACF_APRicochetEffect( Effect, Bullet )	--Bullet ricocheted off something, do what you have to clientside

	local Spall = EffectData()
		Spall:SetOrigin( Bullet.SimPos )
		Spall:SetNormal( (Bullet.SimFlight):GetNormalized() )
		Spall:SetScale( Bullet.SimFlight:Length() )
		Spall:SetMagnitude( Bullet.RoundMass )
	util.Effect( "ACF_AP_Ricochet", Spall )
	
end

--GUI stuff after this
function ACF_APGUICreate( Panel, Table )

	acfmenupanel:AmmoSelect( ACF.AmmoBlacklist["AP"] )
	
	acfmenupanel:CPanelText("Desc", "")	--Description (Name, Desc)
	acfmenupanel:CPanelText("LengthDisplay", "")	--Total round length (Name, Desc)
	
	acfmenupanel:AmmoSlider("PropLength",0,0,1000,3, "Propellant Length", "")	--Propellant Length Slider (Name, Value, Min, Max, Decimals, Title, Desc)
	acfmenupanel:AmmoSlider("ProjLength",0,0,1000,3, "Projectile Length", "")	--Projectile Length Slider (Name, Value, Min, Max, Decimals, Title, Desc)
	
	acfmenupanel:AmmoCheckbox("Tracer", "Tracer", "")			--Tracer checkbox (Name, Title, Desc)
	
	acfmenupanel:CPanelText("VelocityDisplay", "")	--Proj muzzle velocity (Name, Desc)
	acfmenupanel:CPanelText("PenetrationDisplay", "")	--Proj muzzle penetration (Name, Desc)
	
	ACF_APGUIUpdate( Panel, Table )

end

function ACF_APGUIUpdate( Panel, Table )
	
	local PlayerData = {}
		PlayerData["Id"] = acfmenupanel.AmmoData["Data"]["id"]			--AmmoSelect GUI
		PlayerData["Type"] = "AP"										--Hardcoded, match ACFRoundTypes table index
		PlayerData["PropLength"] = acfmenupanel.AmmoData["PropLength"]	--PropLength slider
		PlayerData["ProjLength"] = acfmenupanel.AmmoData["ProjLength"]	--ProjLength slider
		--PlayerData["Data5"] = acfmenupanel.AmmoData[Name]		--Not used
		--PlayerData["Data6"] = acfmenupanel.AmmoData[Name]		--Not used
		--PlayerData["Data7"] = acfmenupanel.AmmoData[Name]		--Not used
		--PlayerData["Data8"] = acfmenupanel.AmmoData[Name]		--Not used
		--PlayerData["Data9"] = acfmenupanel.AmmoData[Name]		--Not used
		local Tracer = 0
		if acfmenupanel.AmmoData["Tracer"] then Tracer = 1 end
		PlayerData["Data10"] = Tracer				--Tracer
	
	local Data = ACF_APConvert( Panel, PlayerData )
	
	RunConsoleCommand( "acfmenu_data1", acfmenupanel.AmmoData["Data"]["id"] )
	RunConsoleCommand( "acfmenu_data2", PlayerData["Type"] )
	RunConsoleCommand( "acfmenu_data3", Data.PropLength )		--For Gun ammo, Data3 should always be Propellant
	RunConsoleCommand( "acfmenu_data4", Data.ProjLength )		--And Data4 total round mass
	RunConsoleCommand( "acfmenu_data10", Data.Tracer )
	
	acfmenupanel:AmmoSlider("PropLength",Data.PropLength,Data.MinPropLength,Data["MaxTotalLength"],3, "Propellant Length", "Propellant Mass : "..(math.floor(Data.PropMass*1000)).." g" )	--Propellant Length Slider (Name, Min, Max, Decimals, Title, Desc)
	acfmenupanel:AmmoSlider("ProjLength",Data.ProjLength,Data.MinProjLength,Data["MaxTotalLength"],3, "Projectile Length", "Projectile Mass : "..(math.floor(Data.ProjMass*1000)).." g")	--Projectile Length Slider (Name, Min, Max, Decimals, Title, Desc)

	acfmenupanel:AmmoCheckbox("Tracer", "Tracer : "..(math.floor(Data.Tracer*10)/10).."cm\n", "" )			--Tracer checkbox (Name, Title, Desc)
	
	acfmenupanel:CPanelText("Desc", ACF.RoundTypes[PlayerData["Type"]]["desc"])	--Description (Name, Desc)
	acfmenupanel:CPanelText("LengthDisplay", "Round Length : "..(math.floor((Data.PropLength+Data.ProjLength+Data.Tracer)*100)/100).."/"..(Data.MaxTotalLength).." cm")	--Total round length (Name, Desc)
	acfmenupanel:CPanelText("VelocityDisplay", "Muzzle Velocity : "..math.floor(Data.MuzzleVel*ACF.VelScale).." m\\s")	--Proj muzzle velocity (Name, Desc)
	acfmenupanel:CPanelText("PenetrationDisplay", "Maximum Penetration : "..math.floor(Data.MaxPen).." mm RHA")	--Proj muzzle penetration (Name, Desc)
	
end
