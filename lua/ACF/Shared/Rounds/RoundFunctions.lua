AddCSLuaFile( "acf/shared/rounds/roundfunctions.lua" )

function ACF_RoundBaseGunpowder( PlayerData, Data, ServerData, GUIData )

	local BulletMax = ACF.Weapons["Guns"][PlayerData["Id"]]["round"]
	GUIData["MaxTotalLength"] = BulletMax["maxlength"]
		
	Data["Caliber"] = ACF.Weapons["Guns"][PlayerData["Id"]]["caliber"]
	Data["FrAera"] = 3.1416 * (Data["Caliber"]/2)^2
	
	Data["Tracer"] = 0
	if PlayerData["Data10"]*1 > 0 then	--Check for tracer
		Data["Tracer"] = math.min(5/Data["Caliber"],2.5) --Tracer space calcs
	end
	
	local PropMax = (BulletMax["propweight"]*1000/ACF.PDensity) / Data["FrAera"]	--Current casing absolute max propellant capacity
	local CurLength = (PlayerData["ProjLength"] + math.min(PlayerData["PropLength"],PropMax) + Data["Tracer"])
	GUIData["MinPropLength"] = 0.01
	GUIData["MaxPropLength"] = math.max(math.min(GUIData["MaxTotalLength"]-CurLength+PlayerData["PropLength"], PropMax),GUIData["MinPropLength"]) --Check if the desired prop lenght fits in the case and doesn't exceed the gun max
	
	GUIData["MinProjLength"] = Data["Caliber"]*1.5
	GUIData["MaxProjLength"] = math.max(GUIData["MaxTotalLength"]-CurLength+PlayerData["ProjLength"],GUIData["MinProjLength"]) --Check if the desired proj lenght fits in the case
	
	local Ratio = math.min( (GUIData["MaxTotalLength"] - Data["Tracer"])/(PlayerData["ProjLength"] + math.min(PlayerData["PropLength"],PropMax)) , 1 ) --This is to check the current ratio between elements if i need to clamp it
	Data["ProjLength"] = math.Clamp(PlayerData["ProjLength"]*Ratio,GUIData["MinProjLength"],GUIData["MaxProjLength"])
	Data["PropLength"] = math.Clamp(PlayerData["PropLength"]*Ratio,GUIData["MinPropLength"],GUIData["MaxPropLength"])
	
	Data["PropMass"] = Data["FrAera"] * (Data["PropLength"]*ACF.PDensity/1000) --Volume of the case as a cylinder * Powder density converted from g to kg
	GUIData["ProjVolume"] = Data["FrAera"] * Data["ProjLength"]
	Data["RoundVolume"] = Data["FrAera"] * (Data["ProjLength"] + Data["PropLength"])
	
	return PlayerData, Data, ServerData, GUIData
end

function ACF_RoundShellCapacity( Momentum, FrAera, Caliber, ProjLength )
	local MinWall = 0.2+((Momentum/FrAera)^0.7)/50 --The minimal shell wall thickness required to survive firing at the current energy level	
	local Length = math.max(ProjLength-MinWall,0)
	local Radius = math.max((Caliber/2)-MinWall,0)
	local Volume = 3.1416*Radius^2 * Length
	return  Volume, Length, Radius --Returning the cavity volume and the minimum wall thickness
end