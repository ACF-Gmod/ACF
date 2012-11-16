AddCSLuaFile( "ACF/Shared/Rounds/RoundRefill.lua" )

local DefTable = {}
	DefTable.type = "Ammo"										--Tells the spawn menu what entity to spawn
	DefTable.name = "Refill"										--Human readable name
	DefTable.model = "models/munitions/round_100mm_shot.mdl"	--Shell flight model
	DefTable.desc = "Ammo Refill"
	
	DefTable.convert = function( Crate, Table ) local Result = ACF_RefillConvert( Crate, Table ) return Result end
	DefTable.network = function( Crate, BulletData ) ACF_RefillNetworkData( Crate, BulletData ) end
	DefTable.cratetxt = function( Crate ) local Result =  ACF_RefillCrateDisplay( Crate ) return Result end	
	
	DefTable.guicreate = function( Panel, Table ) ACF_RefillGUICreate( Panel, Table ) end	--References the function to use to draw that round menu
	DefTable.guiupdate = function( Panel, Table ) ACF_RefillGUIUpdate( Panel, Table ) end	--References the function to use to update that round menu

list.Set( "ACFRoundTypes", "Refill", DefTable )  --Set the round properties

function ACF_RefillConvert( Crate, PlayerData )		--Function to convert the player's slider data into the complete round data
	
	local BulletData = {}
		BulletData["Id"] = PlayerData["Id"]
		BulletData["Type"] = PlayerData["Type"]
		
		BulletData["Caliber"] = ACF.Weapons["Guns"][PlayerData["Id"]]["caliber"]
		BulletData["ProjMass"] = 0.5*7.9/100 --Volume of the projectile as a cylinder * streamline factor (Data5) * density of steel
		BulletData["PropMass"] = 0.5*ACF.PDensity/1000 --Volume of the case as a cylinder * Powder density converted from g to kg
		BulletData["RoundVolume"] = 1
			
	return BulletData
	
end

--Ammocrate stuff
function ACF_RefillNetworkData( Crate, BulletData )

	Crate:SetNetworkedString("AmmoType","Refill")
	Crate:SetNetworkedString("AmmoID",BulletData["Id"])
	
	Crate:SetNetworkedInt("Caliber",BulletData["Caliber"])	
	Crate:SetNetworkedInt("ProjMass",BulletData["ProjMass"])
	Crate:SetNetworkedInt("FillerMass",BulletData["FillerMass"])
	Crate:SetNetworkedInt("PropMass",BulletData["PropMass"])
	
	Crate:SetNetworkedInt("DragCoef",BulletData["DragCoef"])
	Crate:SetNetworkedInt("MuzzleVel",BulletData["MuzzleVel"])
	Crate:SetNetworkedInt("Tracer",BulletData["Tracer"])

end

function ACF_RefillCrateDisplay( Crate )

	local txt = ""
	
	return txt
end

--GUI stuff after this
function ACF_RefillGUICreate( Panel, Table )

	acfmenupanel:AmmoSelect()
	acfmenupanel:CPanelText("Desc", "")	--Description (Name, Desc)		
	ACF_RefillGUIUpdate( Panel, Table )

end

function ACF_RefillGUIUpdate( Panel, Table )
		
	RunConsoleCommand( "acfmenu_data1", acfmenupanel.CData["AmmoId"] )
	RunConsoleCommand( "acfmenu_data2", "Refill")
		
	acfmenupanel.CustomDisplay:PerformLayout()
	
end