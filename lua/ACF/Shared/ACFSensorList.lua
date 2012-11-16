AddCSLuaFile( "ACF/Shared/ACFSensorList.lua" )

local SensorTable = {}  --Start sensors listing

local Stabiliser = {}
	Stabiliser.id = "Stabiliser"
	Stabiliser.ent = "acf_viewpod"
	Stabiliser.type = "Sensors"
	Stabiliser.name = "Stabiliser"
	Stabiliser.desc = "Pod view stabiliser"
	Stabiliser.model = "models/jaanus/wiretool/wiretool_siren.mdl"
	Stabiliser.weight = 20
	if ( CLIENT ) then
		Stabiliser.guicreate = (function( Panel, Table ) ACFViewPodGUICreate( Table ) end or nil)
		Stabiliser.guiupdate = function() return end
	end
SensorTable["Stabiliser"] = Stabiliser
	
list.Set( "ACFEnts", "Sensors", SensorTable )	--end sensors listing