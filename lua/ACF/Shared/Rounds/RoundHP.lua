AddCSLuaFile( "ACF/Shared/Rounds/RoundHP.lua" )

local DefTable = {}
	DefTable.type = "Ammo"										--Tells the spawn menu what entity to spawn
	DefTable.name = "Hollow Point (HP)"								--Human readable name
	DefTable.model = "models/munitions/round_100mm_shot.mdl"	--Shell flight model
	DefTable.desc = "A solid shell with a soft point, meant to flatten against armour"
	DefTable.netid = 3											--Unique ammotype ID for network transmission
	
	DefTable.create = function( Gun, BulletData ) ACF_APCreate( Gun, BulletData ) end --Uses basic AP function
	DefTable.convert = function( Crate, Table ) local Result = ACF_HPConvert( Crate, Table ) return Result end --Uses custom function
	DefTable.network = function( Crate, BulletData ) ACF_HPNetworkData( Crate, BulletData ) end	
	DefTable.cratetxt = function( Crate ) local Result =  ACF_HPCrateDisplay( Crate ) return Result end	
	
	DefTable.propimpact = function( Bullet, Index, Target, HitNormal, HitPos ) local Result = ACF_APPropImpact( Bullet, Index, Target, HitNormal, HitPos ) return Result end --Uses basic AP function
	DefTable.worldimpact = function( Bullet, Index, HitPos, HitNormal ) local Result = ACF_APWorldImpact( Bullet, Index, HitPos, HitNormal ) return Result end --Uses basic AP function
	DefTable.endflight = function( Bullet, Index, HitPos, HitNormal ) ACF_APEndFlight( Bullet, Index, HitPos, HitNormal ) end --Uses basic AP function
	
	DefTable.endeffect = function( Effect, Bullet ) ACF_APEndEffect( Effect, Bullet ) end --Uses basic AP function
	DefTable.pierceeffect = function( Effect, Bullet ) ACF_APPierceEffect( Effect, Bullet ) end --Uses basic AP function
	DefTable.ricocheteffect = function( Effect, Bullet ) ACF_APRicochetEffect( Effect, Bullet ) end --Uses basic AP function
	
	DefTable.guicreate = function( Panel, Table ) ACF_HPGUICreate( Panel, Table ) end	--References the function to use to draw that round menu, must use custom function
	DefTable.guiupdate = function( Panel, Table ) ACF_HPGUIUpdate( Panel, Table ) end	--References the function to use to update that round menu, must use custom function

list.Set( "ACFRoundTypes", "HP", DefTable )  --Set the round properties
list.Set( "ACFIdRounds", DefTable.netid , "HP" ) --Index must equal the ID entry in the table above, Data must equal the index of the table above


function ACF_HPConvert( Crate, PlayerData )		--Function to convert the player's slider data into the complete round data
	
	local Data = {}
	local ServerData = {}
	local GUIData = {}
	
	if not PlayerData["PropLength"] then PlayerData["PropLength"] = 0 end
	if not PlayerData["ProjLength"] then PlayerData["ProjLength"] = 0 end
	if not PlayerData["Data5"] then PlayerData["Data5"] = 0 end
	if not PlayerData["Data10"] then PlayerData["Data10"] = 0 end
	
	PlayerData, Data, ServerData, GUIData = ACF_RoundBaseGunpowder( PlayerData, Data, ServerData, GUIData )
	
	--Shell sturdiness calcs
	Data["ProjMass"] = math.max(GUIData["ProjVolume"]-PlayerData["Data5"],0)*7.9/1000  --(Volume of the projectile as a cylinder - Volume of the cavity) * density of steel 
	Data["MuzzleVel"] = ACF_MuzzleVelocity( Data["PropMass"], Data["ProjMass"], Data["Caliber"] )
	local Energy = ACF_Kinetic( Data["MuzzleVel"]*39.37 , Data["ProjMass"], Data["LimitVel"] )
	
	local MaxVol = ACF_RoundShellCapacity( Energy.Momentum, Data["FrAera"], Data["Caliber"], Data["ProjLength"] )
	GUIData["MinCavVol"] = 0
	GUIData["MaxCavVol"] = math.min(GUIData["ProjVolume"],MaxVol)
	Data["CavVol"] = math.min(PlayerData["Data5"],GUIData["MaxCavVol"])
	
	Data["ProjMass"] = ( (Data["FrAera"] * Data["ProjLength"]) - Data["CavVol"] )*7.9/1000 --Volume of the projectile as a cylinder * fraction missing due to hollow point (Data5) * density of steel
	local ExpRatio = (Data["CavVol"]/GUIData["ProjVolume"])
	Data["ShovePower"] = 0.2 + ExpRatio/2
	Data["ExpCaliber"] = Data["Caliber"] + ExpRatio*Data["ProjLength"]
	Data["PenAera"] = (3.1416 * Data["ExpCaliber"]/2)^2^ACF.PenAreaMod
	Data["DragCoef"] = ((Data["FrAera"]/10000)/Data["ProjMass"])
	Data["LimitVel"] = 400										--Most efficient penetration speed in m/s
	Data["KETransfert"] = 0.1									--Kinetic energy transfert to the target for movement purposes
	Data["Ricochet"] = 90										--Base ricochet angle
	
	Data["BoomPower"] = Data["PropMass"]

	if SERVER then --Only the crates need this part
		ServerData["Id"] = PlayerData["Id"]
		ServerData["Type"] = PlayerData["Type"]
		return table.Merge(Data,ServerData)
	end
	
	if CLIENT then --Only tthe GUI needs this part
		GUIData["MaxKETransfert"] = Energy.Kinetic*Data["ShovePower"]
		GUIData["MaxPen"] = (Energy.Penetration/Data["PenAera"])*ACF.KEtoRHA
		return table.Merge(Data,GUIData)
	end
	
end

--Ammocrate stuff
function ACF_HPNetworkData( Crate, BulletData )

	Crate:SetNetworkedString("AmmoType","HP")
	Crate:SetNetworkedString("AmmoID",BulletData["Id"])
	
	Crate:SetNetworkedInt("Caliber",BulletData["Caliber"])	
	Crate:SetNetworkedInt("ProjMass",BulletData["ProjMass"])
	Crate:SetNetworkedInt("PropMass",BulletData["PropMass"])
	Crate:SetNetworkedInt("ExpCaliber",BulletData["ExpCaliber"])
	
	Crate:SetNetworkedInt("DragCoef",BulletData["DragCoef"])
	Crate:SetNetworkedInt("MuzzleVel",BulletData["MuzzleVel"])
	Crate:SetNetworkedInt("Tracer",BulletData["Tracer"])

end

function ACF_HPCrateDisplay( Crate )

	local Tracer = ""
	if Crate:GetNetworkedInt("Tracer") > 0 then Tracer = "-T" end
	
	local ProjMass = math.floor(Crate:GetNetworkedString("ProjMass")*1000)
	local PropMass = math.floor(Crate:GetNetworkedString("PropMass")*1000)
	local ExpCaliber = math.floor(Crate:GetNetworkedString("ExpCaliber")*1000)/100
	
	local txt = "Round Mass : "..ProjMass.." g\nPropellant : "..PropMass.." g\nExpanded Caliber : "..ExpCaliber.." mm"
	
	return txt
end

--GUI stuff after this
function ACF_HPGUICreate( Panel, Table )

	acfmenupanel:AmmoSelect()
	
	acfmenupanel:CPanelText("Desc", "")	--Description (Name, Desc)
	acfmenupanel:CPanelText("LengthDisplay", "")	--Total round length (Name, Desc)

	acfmenupanel:AmmoSlider("PropLength",0,0,1000,3, "Propellant Length", "")	--Propellant Length Slider (Name, Value, Min, Max, Decimals, Title, Desc)
	acfmenupanel:AmmoSlider("ProjLength",0,0,1000,3, "Projectile Length", "")	--Projectile Length Slider (Name, Value, Min, Max, Decimals, Title, Desc)
	acfmenupanel:AmmoSlider("CavVol",0,0,1000,2, "Hollow Point Length", "")--Hollow Point Cavity Slider (Name, Value, Min, Max, Decimals, Title, Desc)
	
	acfmenupanel:AmmoCheckbox("Tracer", "Tracer", "")			--Tracer checkbox (Name, Title, Desc)
	
	acfmenupanel:CPanelText("VelocityDisplay", "")	--Proj muzzle velocity (Name, Desc)
	acfmenupanel:CPanelText("PenetrationDisplay", "")	--Proj muzzle penetration (Name, Desc)
	acfmenupanel:CPanelText("KEDisplay", "")			--Proj muzzle KE (Name, Desc)
	
	ACF_HPGUIUpdate( Panel, nil )
	
end

function ACF_HPGUIUpdate( Panel, Table )
	
	local PlayerData = {}
		PlayerData["Id"] = acfmenupanel.AmmoData["Data"]["id"]			--AmmoSelect GUI
		PlayerData["Type"] = "HP"										--Hardcoded, match ACFRoundTypes table index
		PlayerData["PropLength"] = acfmenupanel.AmmoData["PropLength"]	--PropLength slider
		PlayerData["ProjLength"] = acfmenupanel.AmmoData["ProjLength"]	--ProjLength slider
		PlayerData["Data5"] = acfmenupanel.AmmoData["CavVol"]
		--PlayerData["Data6"] = acfmenupanel.AmmoData[Name]		--Not used
		--PlayerData["Data7"] = acfmenupanel.AmmoData[Name]		--Not used
		--PlayerData["Data8"] = acfmenupanel.AmmoData[Name]		--Not used
		--PlayerData["Data9"] = acfmenupanel.AmmoData[Name]		--Not used
		local Tracer = 0
		if acfmenupanel.AmmoData["Tracer"] then Tracer = 1 end
		PlayerData["Data10"] = Tracer				--Tracer
	
	local Data = ACF_HPConvert( Panel, PlayerData )
	
	RunConsoleCommand( "acfmenu_data1", acfmenupanel.AmmoData["Data"]["id"] )
	RunConsoleCommand( "acfmenu_data2", PlayerData["Type"] )
	RunConsoleCommand( "acfmenu_data3", Data.PropLength )		--For Gun ammo, Data3 should always be Propellant
	RunConsoleCommand( "acfmenu_data4", Data.ProjLength )		--And Data4 total round mass
	RunConsoleCommand( "acfmenu_data5", Data.CavVol )
	RunConsoleCommand( "acfmenu_data10", Data.Tracer )
	
	acfmenupanel:AmmoSlider("PropLength",Data.PropLength,Data.MinPropLength,Data["MaxTotalLength"],3, "Propellant Length", "Propellant Mass : "..(math.floor(Data.PropMass*1000)).." g" )	--Propellant Length Slider (Name, Min, Max, Decimals, Title, Desc)
	acfmenupanel:AmmoSlider("ProjLength",Data.ProjLength,Data.MinProjLength,Data["MaxTotalLength"],3, "Projectile Length", "Projectile Mass : "..(math.floor(Data.ProjMass*1000)).." g")	--Projectile Length Slider (Name, Min, Max, Decimals, Title, Desc)
	
	acfmenupanel:AmmoSlider("CavVol",Data.CavVol,Data.MinCavVol,Data.MaxCavVol,2, "Hollow Point cavity Volume", "Expanded caliber : "..(math.floor(Data.ExpCaliber*10)).." mm")--Hollow Point Cavity Slider (Name, Min, Max, Decimals, Title, Desc)
	
	acfmenupanel:AmmoCheckbox("Tracer", "Tracer : "..(math.floor(Data.Tracer*10)/10).."cm\n", "" )			--Tracer checkbox (Name, Title, Desc)

	acfmenupanel:CPanelText("Desc", ACF.RoundTypes[PlayerData["Type"]]["desc"])	--Description (Name, Desc)	
	acfmenupanel:CPanelText("LengthDisplay", "Round Length : "..(math.floor((Data.PropLength+Data.ProjLength+Data.Tracer)*100)/100).."/"..(Data.MaxTotalLength).." cm")	--Total round length (Name, Desc)
	acfmenupanel:CPanelText("VelocityDisplay", "Muzzle Velocity : "..math.floor(Data.MuzzleVel*ACF.VelScale).." m/s")	--Proj muzzle velocity (Name, Desc)
	acfmenupanel:CPanelText("PenetrationDisplay", "Maximum Penetration : "..math.floor(Data.MaxPen).." mm RHA")	--Proj muzzle penetration (Name, Desc)
	acfmenupanel:CPanelText("KEDisplay", "Kinetic Energy Transfered : "..math.floor(Data.MaxKETransfert).." KJ")			--Proj muzzle KE (Name, Desc)	
		
end