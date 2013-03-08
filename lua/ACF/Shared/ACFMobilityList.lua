AddCSLuaFile( "acf/shared/acfmobilitylist.lua" )

local MobilityTable = {}  --Start mobility listing

--Gearbox Variables (made this so i don't make errors when adjusting every fucking gearbox)

--Overall Gearbox size torque limits
local GearSMT = 550
local GearMMT = 1900
local GearLMT = 10000
local GearTDSMT = 800 --Max torque for 1/2 speed smalls

--1 speed weights
local Gear1SW = 10
local Gear1MW = 20
local Gear1LW = 40

--2 speed weights
local Gear2SW = 20
local Gear2MW = 40
local Gear2LW = 80

--4 speed weights
local Gear4SW = 40
local Gear4MW = 80
local Gear4LW = 160

--6 speed weights
local Gear6SW = 60
local Gear6MW = 120
local Gear6LW = 240

--8 speed weights
local Gear8SW = 80
local Gear8MW = 160
local Gear8LW = 320




--fix 6.5l i6 sound & 1l sound

-- Gas Turbines
local EngineGTsmall = {}
	EngineGTsmall.id = "Turbine-Small"
	EngineGTsmall.ent = "acf_engine"
	EngineGTsmall.type = "Mobility"
	EngineGTsmall.name = "Gas Turbine, Small"
	EngineGTsmall.desc = "A small gas turbine, high power and a very wide powerband\n\nTurbines are powerful but suffer from poor throttle response."
	EngineGTsmall.model = "models/engines/gasturbine_s.mdl"
	EngineGTsmall.sound = "ACF_engines/turbine_small.wav"
	EngineGTsmall.category = "Turbine"
	EngineGTsmall.weight = 150
	EngineGTsmall.torque = 300	
    EngineGTsmall.flywheelmass = 1		--in Meter/Kg
	EngineGTsmall.idlerpm = 2000	--in Rotations Per Minute
	EngineGTsmall.peakminrpm = 1
	EngineGTsmall.peakmaxrpm = 1
	EngineGTsmall.limitprm = 15000
	EngineGTsmall.iselec = true
	EngineGTsmall.elecpower = 134
	EngineGTsmall.flywheeloverride = 6000

	if ( CLIENT ) then
		EngineGTsmall.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		EngineGTsmall.guiupdate = function() return end
	end
MobilityTable["Turbine-Small"] = EngineGTsmall

local EngineGTMedium = {}
	EngineGTMedium.id = "Turbine-Medium"
	EngineGTMedium.ent = "acf_engine"
	EngineGTMedium.type = "Mobility"
	EngineGTMedium.name = "Gas Turbine, Medium"
	EngineGTMedium.desc = "A medium gas turbine, moderate power but a very wide powerband\n\nTurbines are powerful but suffer from poor throttle response."
	EngineGTMedium.model = "models/engines/gasturbine_m.mdl"
	EngineGTMedium.sound = "ACF_engines/turbine_medium.wav"
	EngineGTMedium.category = "Turbine"
	EngineGTMedium.weight = 400
	EngineGTMedium.torque = 600	
    EngineGTMedium.flywheelmass = 2		--in Meter/Kg
	EngineGTMedium.idlerpm = 2000	--in Rotations Per Minute
	EngineGTMedium.peakminrpm = 1
	EngineGTMedium.peakmaxrpm = 1
	EngineGTMedium.limitprm = 12000
	EngineGTMedium.iselec = true
	EngineGTMedium.elecpower = 248
	EngineGTMedium.flywheeloverride = 6000
	
	
	if ( CLIENT ) then
		EngineGTMedium.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		EngineGTMedium.guiupdate = function() return end
	end
MobilityTable["Turbine-Medium"] = EngineGTMedium

local EngineGTLarge = {}
	EngineGTLarge.id = "Turbine-Large"
	EngineGTLarge.ent = "acf_engine"
	EngineGTLarge.type = "Mobility"
	EngineGTLarge.name = "Gas Turbine, Large"
	EngineGTLarge.desc = "A large gas turbine, powerful with a wide powerband\n\nTurbines are powerful but suffer from poor throttle response."
	EngineGTLarge.model = "models/engines/gasturbine_l.mdl"
	EngineGTLarge.sound = "ACF_engines/turbine_large.wav"
	EngineGTLarge.category = "Turbine"
	EngineGTLarge.weight = 1000
	EngineGTLarge.torque = 1500	
    EngineGTLarge.flywheelmass = 4		--in Meter/Kg
	EngineGTLarge.idlerpm = 2000	--in Rotations Per Minute
	EngineGTLarge.peakminrpm = 1
	EngineGTLarge.peakmaxrpm = 1
	EngineGTLarge.limitprm = 13500
	EngineGTLarge.iselec = true
	EngineGTLarge.elecpower = 700
	EngineGTLarge.flywheeloverride = 6000
	
	if ( CLIENT ) then
		EngineGTLarge.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		EngineGTLarge.guiupdate = function() return end
	end
MobilityTable["Turbine-Large"] = EngineGTLarge

--Electric motors
local EngineEsmall = {}
	EngineEsmall.id = "Electric-Small"
	EngineEsmall.ent = "acf_engine"
	EngineEsmall.type = "Mobility"
	EngineEsmall.name = "Electric motor, Small"
	EngineEsmall.desc = "A small electric motor, loads of torque, but low power\n\nElectric motors provide huge amounts of torque, but are very heavy"
	EngineEsmall.model = "models/engines/emotorsmall.mdl"
	EngineEsmall.sound = "ACF_engines/electric_small.wav"
	EngineEsmall.category = "Electric"
	EngineEsmall.weight = 350
	EngineEsmall.torque = 400	
    EngineEsmall.flywheelmass = 0.25	--in Meter/Kg
	EngineEsmall.idlerpm = 10	--in Rotations Per Minute
	EngineEsmall.peakminrpm = 10
	EngineEsmall.peakmaxrpm = 10
	EngineEsmall.limitprm = 10000
	EngineEsmall.iselec = true
	EngineEsmall.elecpower = 98
	EngineEsmall.flywheeloverride = 5000 --Peakmax override so the flywheel drag function will operate properly for Electrics/turbines


	if ( CLIENT ) then
		EngineEsmall.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		EngineEsmall.guiupdate = function() return end
	end
MobilityTable["Electric-Small"] = EngineEsmall

local EngineEmedium = {}
	EngineEmedium.id = "Electric-Medium"
	EngineEmedium.ent = "acf_engine"
	EngineEmedium.type = "Mobility"
	EngineEmedium.name = "Electric motor, Medium"
	EngineEmedium.desc = "A medium electric motor, loads of torque, but low power\n\nElectric motors provide huge amounts of torque, but are very heavy"
	EngineEmedium.model = "models/engines/emotormed.mdl"
	EngineEmedium.sound = "ACF_engines/electric_medium.wav"
	EngineEmedium.category = "Electric"
	EngineEmedium.weight = 1000
	EngineEmedium.torque = 1200
    EngineEmedium.flywheelmass = 1.2		--in Meter/Kg
	EngineEmedium.idlerpm = 10	--in Rotations Per Minute
	EngineEmedium.peakminrpm = 10
	EngineEmedium.peakmaxrpm = 10
	EngineEmedium.limitprm = 7000
	EngineEmedium.iselec = true
	EngineEmedium.elecpower = 208
	EngineEmedium.flywheeloverride = 8000 --Peakmax override so the flywheel drag function will operate properly for Electrics/turbines



	if ( CLIENT ) then
		EngineEmedium.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		EngineEmedium.guiupdate = function() return end
	end
MobilityTable["Electric-Medium"] = EngineEmedium

local EngineElarge = {}
	EngineElarge.id = "Electric-Large"
	EngineElarge.ent = "acf_engine"
	EngineElarge.type = "Mobility"
	EngineElarge.name = "Electric motor, Large"
	EngineElarge.desc = "A huge electric motor, loads of torque, but low power\n\nElectric motors provide huge amounts of torque, but are very heavy"
	EngineElarge.model = "models/engines/emotorlarge.mdl"
	EngineElarge.sound = "ACF_engines/electric_large.wav"
	EngineElarge.category = "Electric"
	EngineElarge.weight = 2000
	EngineElarge.torque = 3000	
    EngineElarge.flywheelmass = 8		--in Meter/Kg
	EngineElarge.idlerpm = 10	--in Rotations Per Minute
	EngineElarge.peakminrpm = 10
	EngineElarge.peakmaxrpm = 10
	EngineElarge.limitprm = 4500
	EngineElarge.iselec = true
	EngineElarge.elecpower = 340
	EngineElarge.flywheeloverride = 6000 --Peakmax override so the flywheel drag function will operate properly for Electrics/turbines


	if ( CLIENT ) then
		EngineElarge.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		EngineElarge.guiupdate = function() return end
	end
MobilityTable["Electric-Large"] = EngineElarge


--Single cylinders
local Engine2I1 = {}
	Engine2I1.id = "0.25-I1"
	Engine2I1.ent = "acf_engine"
	Engine2I1.type = "Mobility"
	Engine2I1.name = "250cc Single"
	Engine2I1.desc = "Tiny bike engine"
	Engine2I1.model = "models/engines/1cyls.mdl"
	Engine2I1.sound = "acf_engines/i1_small.wav"
	Engine2I1.category = "Single"
	Engine2I1.weight = 15
	Engine2I1.torque = 20		--in Meter/Kg
	Engine2I1.flywheelmass = 0.005	

	Engine2I1.idlerpm = 1200	--in Rotations Per Minute
	Engine2I1.peakminrpm = 4000
	Engine2I1.peakmaxrpm = 6500
	Engine2I1.limitprm = 7500
	if ( CLIENT ) then
		Engine2I1.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine2I1.guiupdate = function() return end
	end
MobilityTable["0.25-I1"] = Engine2I1

local Engine5I1 = {}
	Engine5I1.id = "0.5-I1"
	Engine5I1.ent = "acf_engine"
	Engine5I1.type = "Mobility"
	Engine5I1.name = "500cc Single"
	Engine5I1.desc = "Large single cylinder bike engine"
	Engine5I1.model = "models/engines/1cylm.mdl"
	Engine5I1.sound = "acf_engines/i1_medium.wav"
	Engine5I1.category = "Single"
	Engine5I1.weight = 30
	Engine5I1.torque = 40		--in Meter/Kg
	Engine5I1.flywheelmass = 0.005	

	Engine5I1.idlerpm = 900	--in Rotations Per Minute
	Engine5I1.peakminrpm = 4300
	Engine5I1.peakmaxrpm = 7000
	Engine5I1.limitprm = 8000
	if ( CLIENT ) then
		Engine5I1.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine5I1.guiupdate = function() return end
	end
MobilityTable["0.5-I1"] = Engine5I1

local Engine13I1 = {}
	Engine13I1.id = "1.3-I1"
	Engine13I1.ent = "acf_engine"
	Engine13I1.type = "Mobility"
	Engine13I1.name = "1300cc Single"
	Engine13I1.desc = "Ridiculously large single cylinder engine, seriously what the fuck"
	Engine13I1.model = "models/engines/1cylb.mdl"
	Engine13I1.sound = "acf_engines/i1_large.wav"
	Engine13I1.category = "Single"
	Engine13I1.weight = 55
	Engine13I1.torque = 90		--in Meter/Kg
	Engine13I1.flywheelmass = 0.1	

	Engine13I1.idlerpm = 600	--in Rotations Per Minute
	Engine13I1.peakminrpm = 3600
	Engine13I1.peakmaxrpm = 6000
	Engine13I1.limitprm = 6700
	if ( CLIENT ) then
		Engine13I1.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine13I1.guiupdate = function() return end
	end
MobilityTable["1.3-I1"] = Engine13I1

--Vtwins
local Engine6V2 = {}
	Engine6V2.id = "0.6-V2"
	Engine6V2.ent = "acf_engine"
	Engine6V2.type = "Mobility"
	Engine6V2.name = "600cc V-Twin"
	Engine6V2.desc = "Twin cylinder bike engine, torquey for its size"
	Engine6V2.model = "models/engines/v-twins.mdl"
	Engine6V2.sound = "acf_engines/vtwin_small.wav"
	Engine6V2.category = "V-Twin"
	Engine6V2.weight = 40
	Engine6V2.torque = 50		--in Meter/Kg
	Engine6V2.flywheelmass = 0.01	

	Engine6V2.idlerpm = 900	--in Rotations Per Minute
	Engine6V2.peakminrpm = 4000
	Engine6V2.peakmaxrpm = 6500
	Engine6V2.limitprm = 7500
	if ( CLIENT ) then
		Engine6V2.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine6V2.guiupdate = function() return end
	end
MobilityTable["0.6-V2"] = Engine6V2

local Engine12V2 = {}
	Engine12V2.id = "1.2-V2"
	Engine12V2.ent = "acf_engine"
	Engine12V2.type = "Mobility"
	Engine12V2.name = "1200cc V-Twin"
	Engine12V2.desc = "Large displacement vtwin engine"
	Engine12V2.model = "models/engines/v-twinm.mdl"
	Engine12V2.sound = "acf_engines/vtwin_medium.wav"
	Engine12V2.category = "V-Twin"
	Engine12V2.weight = 60
	Engine12V2.torque = 85		--in Meter/Kg
	Engine12V2.flywheelmass = 0.02	

	Engine12V2.idlerpm = 725	--in Rotations Per Minute
	Engine12V2.peakminrpm = 3300
	Engine12V2.peakmaxrpm = 5500
	Engine12V2.limitprm = 6250
	if ( CLIENT ) then
		Engine12V2.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine12V2.guiupdate = function() return end
	end
MobilityTable["1.2-V2"] = Engine12V2

local Engine24V2 = {}
	Engine24V2.id = "2.4-V2"
	Engine24V2.ent = "acf_engine"
	Engine24V2.type = "Mobility"
	Engine24V2.name = "2400cc V-Twin"
	Engine24V2.desc = "Huge fucking Vtwin 'MURRICA FUCK YEAH"
	Engine24V2.model = "models/engines/v-twinb.mdl"
	Engine24V2.sound = "acf_engines/vtwin_large.wav"
	Engine24V2.category = "V-Twin"
	Engine24V2.weight = 120
	Engine24V2.torque = 160		--in Meter/Kg
	Engine24V2.flywheelmass = 0.075	

	Engine24V2.idlerpm = 900	--in Rotations Per Minute
	Engine24V2.peakminrpm = 3300
	Engine24V2.peakmaxrpm = 5500
	Engine24V2.limitprm = 6500
	if ( CLIENT ) then
		Engine24V2.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine24V2.guiupdate = function() return end
	end
MobilityTable["2.4-V2"] = Engine24V2




-- Petrol I4s
local Engine15I4 = {}
	Engine15I4.id = "1.5-I4"
	Engine15I4.ent = "acf_engine"
	Engine15I4.type = "Mobility"
	Engine15I4.name = "1.5L I4 Petrol"
	Engine15I4.desc = "Small car engine, not a whole lot of git"
	Engine15I4.model = "models/engines/inline4s.mdl"
	Engine15I4.sound = "ACF_engines/i4_petrolsmall2.wav"
	Engine15I4.category = "I4"
	Engine15I4.weight = 125
	Engine15I4.torque = 90		--in Meter/Kg
	Engine15I4.flywheelmass = 0.06
	Engine15I4.powermod = 1

	Engine15I4.idlerpm = 900	--in Rotations Per Minute
	Engine15I4.peakminrpm = 4000
	Engine15I4.peakmaxrpm = 6500
	Engine15I4.limitprm = 7500
	if ( CLIENT ) then
		Engine15I4.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine15I4.guiupdate = function() return end
	end
MobilityTable["1.5-I4"] = Engine15I4

local Engine37I4 = {}
	Engine37I4.id = "3.7-I4"
	Engine37I4.ent = "acf_engine"
	Engine37I4.type = "Mobility"
	Engine37I4.name = "3.7L I4 Petrol"
	Engine37I4.desc = "Large inline 4, sees most use in light trucks"
	Engine37I4.model = "models/engines/inline4m.mdl"
	Engine37I4.sound = "ACF_engines/i4_petrolmedium2.wav"
	Engine37I4.category = "I4"
	Engine37I4.weight = 250
	Engine37I4.torque = 300		--in Meter/Kg
	Engine37I4.flywheelmass = 0.2
	
	Engine37I4.idlerpm = 900	--in Rotations Per Minute
	Engine37I4.peakminrpm = 3700
	Engine37I4.peakmaxrpm = 6000
	Engine37I4.limitprm = 6000
	if ( CLIENT ) then
		Engine37I4.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine37I4.guiupdate = function() return end
	end
MobilityTable["3.7-I4"] = Engine37I4

local Engine160I4 = {}
	Engine160I4.id = "16.0-I4"
	Engine160I4.ent = "acf_engine"
	Engine160I4.type = "Mobility"
	Engine160I4.name = "16.0L I4 Petrol"
	Engine160I4.desc = "Giant, thirsty I4 petrol, most commonly used in boats"
	Engine160I4.model = "models/engines/inline4l.mdl"
	Engine160I4.sound = "ACF_engines/i4_petrollarge.wav"
	Engine160I4.category = "I4"
	Engine160I4.weight = 800
	Engine160I4.torque = 950		--in Meter/Kg
	Engine160I4.flywheelmass = 1.5
	
	Engine160I4.idlerpm = 500	--in Rotations Per Minute
	Engine160I4.peakminrpm = 1750
	Engine160I4.peakmaxrpm = 3250
	Engine160I4.limitprm = 3500
	if ( CLIENT ) then
		Engine160I4.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine160I4.guiupdate = function() return end
	end
MobilityTable["16.0-I4"] = Engine160I4




-- Diesel I4s
local Engine16I4 = {}
	Engine16I4.id = "1.6-I4"
	Engine16I4.ent = "acf_engine"
	Engine16I4.type = "Mobility"
	Engine16I4.name = "1.6L I4 Diesel"
	Engine16I4.desc = "Small and light diesel, for low power applications requiring a wide powerband"
	Engine16I4.model = "models/engines/inline4s.mdl"
	Engine16I4.sound = "ACF_engines/i4_diesel2.wav"
	Engine16I4.category = "I4"
	Engine16I4.weight = 150
	Engine16I4.torque = 150		--in Meter/Kg
	Engine16I4.flywheelmass = 0.2
	
	Engine16I4.idlerpm = 650	--in Rotations Per Minute
	Engine16I4.peakminrpm = 1000
	Engine16I4.peakmaxrpm = 3000
	Engine16I4.limitprm = 5000
	if ( CLIENT ) then
		Engine16I4.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine16I4.guiupdate = function() return end
	end
MobilityTable["1.6-I4"] = Engine16I4

local Engine31I4 = {}
	Engine31I4.id = "3.1-I4"
	Engine31I4.ent = "acf_engine"
	Engine31I4.type = "Mobility"
	Engine31I4.name = "3.1L I4 Diesel"
	Engine31I4.desc = "Light truck duty diesel, good overall grunt"
	Engine31I4.model = "models/engines/inline4m.mdl"
	Engine31I4.sound = "ACF_engines/i4_dieselmedium.wav"
	Engine31I4.category = "I4"
	Engine31I4.weight = 350
	Engine31I4.torque = 400		--in Meter/Kg
	Engine31I4.flywheelmass = 1
	
	Engine31I4.idlerpm = 500	--in Rotations Per Minute
	Engine31I4.peakminrpm = 1150
	Engine31I4.peakmaxrpm = 3500
	Engine31I4.limitprm = 4000
	if ( CLIENT ) then
		Engine31I4.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine31I4.guiupdate = function() return end
	end
MobilityTable["3.1-I4"] = Engine31I4

local Engine150I4 = {}
	Engine150I4.id = "15.0-I4"
	Engine150I4.ent = "acf_engine"
	Engine150I4.type = "Mobility"
	Engine150I4.name = "15.0L I4 Diesel"
	Engine150I4.desc = "Small boat sized diesel, with large amounts of torque"
	Engine150I4.model = "models/engines/inline4l.mdl"
	Engine150I4.sound = "ACF_engines/i4_diesellarge.wav"
	Engine150I4.category = "I4"
	Engine150I4.weight = 1000
	Engine150I4.torque = 1800		--in Meter/Kg
	Engine150I4.flywheelmass = 5
	
	Engine150I4.idlerpm = 300	--in Rotations Per Minute
	Engine150I4.peakminrpm = 500
	Engine150I4.peakmaxrpm = 1500
	Engine150I4.limitprm = 2000
	if ( CLIENT ) then
		Engine150I4.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine150I4.guiupdate = function() return end
	end
MobilityTable["15.0-I4"] = Engine150I4

--Petrol Boxer 4s
local Engine14B4 = {}
	Engine14B4.id = "1.4-B4"
	Engine14B4.ent = "acf_engine"
	Engine14B4.type = "Mobility"
	Engine14B4.name = "1.4L Flat 4 Petrol"
	Engine14B4.desc = "Small air cooled flat four, most commonly found in nazi insects"
	Engine14B4.model = "models/engines/b4small.mdl"
	Engine14B4.sound = "ACF_engines/b4_petrolsmall.wav"
	Engine14B4.category = "B4"
	Engine14B4.weight = 75
	Engine14B4.torque = 105		--in Meter/Kg
	Engine14B4.flywheelmass = 0.06
	
	Engine14B4.idlerpm = 600	--in Rotations Per Minute
	Engine14B4.peakminrpm = 2600
	Engine14B4.peakmaxrpm = 4200
	Engine14B4.limitprm = 4500
	if ( CLIENT ) then
		Engine14B4.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine14B4.guiupdate = function() return end
	end
MobilityTable["1.4-B4"] = Engine14B4

local Engine21B4 = {}
	Engine21B4.id = "2.1-B4"
	Engine21B4.ent = "acf_engine"
	Engine21B4.type = "Mobility"
	Engine21B4.name = "2.1L Flat 4 Petrol"
	Engine21B4.desc = "Tuned up flat four, probably find this in things that go fast in a desert."
	Engine21B4.model = "models/engines/b4small.mdl"
	Engine21B4.sound = "ACF_engines/b4_petrolmedium.wav"
	Engine21B4.category = "B4"
	Engine21B4.weight = 150
	Engine21B4.torque = 225		--in Meter/Kg
	Engine21B4.flywheelmass = 0.15
	
	Engine21B4.idlerpm = 700	--in Rotations Per Minute
	Engine21B4.peakminrpm = 3000
	Engine21B4.peakmaxrpm = 4800
	Engine21B4.limitprm = 5000
	if ( CLIENT ) then
		Engine21B4.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine21B4.guiupdate = function() return end
	end
MobilityTable["2.1-B4"] = Engine21B4

local Engine32B4 = {}
	Engine32B4.id = "3.2-B4"
	Engine32B4.ent = "acf_engine"
	Engine32B4.type = "Mobility"
	Engine32B4.name = "3.2L Flat 4 Petrol"
	Engine32B4.desc = "Bored out fuckswindleton batshit flat four. Fuck yourself."
	Engine32B4.model = "models/engines/b4med.mdl"
	Engine32B4.sound = "ACF_engines/b4_petrollarge.wav"
	Engine32B4.category = "B4"
	Engine32B4.weight = 200
	Engine32B4.torque = 375		--in Meter/Kg
	Engine32B4.flywheelmass = 0.15
	
	Engine32B4.idlerpm = 900	--in Rotations Per Minute
	Engine32B4.peakminrpm = 3400
	Engine32B4.peakmaxrpm = 5500
	Engine32B4.limitprm = 6500
	if ( CLIENT ) then
		Engine32B4.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine32B4.guiupdate = function() return end
	end
MobilityTable["3.2-B4"] = Engine32B4
--Petrol Boxer 6s

local Engine28B6 = {}
	Engine28B6.id = "2.8-B6"
	Engine28B6.ent = "acf_engine"
	Engine28B6.type = "Mobility"
	Engine28B6.name = "2.8L Flat 6 Petrol"
	Engine28B6.desc = "Car sized flat six engine, sporty and light"
	Engine28B6.model = "models/engines/b6small.mdl"
	Engine28B6.sound = "ACF_engines/b6_petrolsmall.wav"
	Engine28B6.category = "B6"
	Engine28B6.weight = 200
	Engine28B6.torque = 170		--in Meter/Kg
	Engine28B6.flywheelmass = 0.08
	
	Engine28B6.idlerpm = 750	--in Rotations Per Minute
	Engine28B6.peakminrpm = 4300
	Engine28B6.peakmaxrpm = 6950
	Engine28B6.limitprm = 7250
	if ( CLIENT ) then
		Engine28B6.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine28B6.guiupdate = function() return end
	end
MobilityTable["2.8-B6"] = Engine28B6

local Engine50B6 = {}
	Engine50B6.id = "5.0-B6"
	Engine50B6.ent = "acf_engine"
	Engine50B6.type = "Mobility"
	Engine50B6.name = "5.0 Flat 6 Petrol"
	Engine50B6.desc = "Sports car grade flat six, renown for their smooth operation and light weight"
	Engine50B6.model = "models/engines/b6med.mdl"
	Engine50B6.sound = "ACF_engines/b6_petrolmedium.wav"
	Engine50B6.category = "B6"
	Engine50B6.weight = 275
	Engine50B6.torque = 360		--in Meter/Kg
	Engine50B6.flywheelmass = 0.1
	
	Engine50B6.idlerpm = 900	--in Rotations Per Minute
	Engine50B6.peakminrpm = 3500
	Engine50B6.peakmaxrpm = 6000
	Engine50B6.limitprm = 6800
	if ( CLIENT ) then
		Engine50B6.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine50B6.guiupdate = function() return end
	end
MobilityTable["5.0-B6"] = Engine50B6

local Engine10B6 = {}
	Engine10B6.id = "10.0-B6"
	Engine10B6.ent = "acf_engine"
	Engine10B6.type = "Mobility"
	Engine10B6.name = "10.0L Flat 6 Petrol"
	Engine10B6.desc = "Aircraft grade boxer with a high rev range biased powerband"
	Engine10B6.model = "models/engines/b6large.mdl"
	Engine10B6.sound = "ACF_engines/b6_petrollarge.wav"
	Engine10B6.category = "B6"
	Engine10B6.weight = 600
	Engine10B6.torque = 900		--in Meter/Kg
	Engine10B6.flywheelmass = 1
	
	Engine10B6.idlerpm = 620	--in Rotations Per Minute
	Engine10B6.peakminrpm = 2500
	Engine10B6.peakmaxrpm = 4100
	Engine10B6.limitprm = 4500
	if ( CLIENT ) then
		Engine10B6.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine10B6.guiupdate = function() return end
	end
MobilityTable["10.0-B6"] = Engine10B6

--Petrol V6s

local Engine36V6 = {}
	Engine36V6.id = "3.6-V6"
	Engine36V6.ent = "acf_engine"
	Engine36V6.type = "Mobility"
	Engine36V6.name = "3.6L V6 Petrol"
	Engine36V6.desc = "Meaty Car sized V6, lots of torque/n/nV6s are more torquey than the Boxer and Inline 6s but suffer in power"
	Engine36V6.model = "models/engines/v6small.mdl"
	Engine36V6.sound = "ACF_engines/v6_petrolsmall.wav"
	Engine36V6.category = "V6"
	Engine36V6.weight = 280
	Engine36V6.torque = 285		--in Meter/Kg
	Engine36V6.flywheelmass = 0.25
	
	Engine36V6.idlerpm = 700	--in Rotations Per Minute
	Engine36V6.peakminrpm = 2200
	Engine36V6.peakmaxrpm = 3500
	Engine36V6.limitprm = 5500
	if ( CLIENT ) then
		Engine36V6.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine36V6.guiupdate = function() return end
	end
MobilityTable["3.6-V6"] = Engine36V6

local Engine62V6 = {}
	Engine62V6.id = "6.2-V6"
	Engine62V6.ent = "acf_engine"
	Engine62V6.type = "Mobility"
	Engine62V6.name = "6.2L V6 Petrol"
	Engine62V6.desc = "Heavy duty v6, throatier than an LA whore, but loaded with torque/n/nV6s are more torquey than the Boxer and Inline 6s but suffer in power"
	Engine62V6.model = "models/engines/v6med.mdl"
	Engine62V6.sound = "ACF_engines/v6_petrolmedium.wav"
	Engine62V6.category = "V6"
	Engine62V6.weight = 450
	Engine62V6.torque = 525		--in Meter/Kg
	Engine62V6.flywheelmass = 0.45
	
	Engine62V6.idlerpm = 800	--in Rotations Per Minute
	Engine62V6.peakminrpm = 2200
	Engine62V6.peakmaxrpm = 3600
	Engine62V6.limitprm = 6000
	if ( CLIENT ) then
		Engine62V6.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine62V6.guiupdate = function() return end
	end
MobilityTable["6.2-V6"] = Engine62V6

local Engine120V6 = {}
	Engine120V6.id = "12.0-V6"
	Engine120V6.ent = "acf_engine"
	Engine120V6.type = "Mobility"
	Engine120V6.name = "12.0L V6 Petrol"
	Engine120V6.desc = "Fuck duty V6, guts ripped from god himself diluted in salt and shaped into an engine./n/nV6s are more torquey than the Boxer and Inline 6s but suffer in power"
	Engine120V6.model = "models/engines/v6large.mdl"
	Engine120V6.sound = "ACF_engines/v6_petrollarge.wav"
	Engine120V6.category = "V6"
	Engine120V6.weight = 750
	Engine120V6.torque = 1300		--in Meter/Kg
	Engine120V6.flywheelmass = 2.5
	
	Engine120V6.idlerpm = 600	--in Rotations Per Minute
	Engine120V6.peakminrpm = 1750
	Engine120V6.peakmaxrpm = 2950
	Engine120V6.limitprm = 3500
	if ( CLIENT ) then
		Engine120V6.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine120V6.guiupdate = function() return end
	end
MobilityTable["12.0-V6"] = Engine120V6

--Diesel L6s
local Engine30I6 = {}
	Engine30I6.id = "3.0-I6"
	Engine30I6.ent = "acf_engine"
	Engine30I6.type = "Mobility"
	Engine30I6.name = "3.0L I6 Diesel"
	Engine30I6.desc = "Car sized I6 diesel, good, wide powerband"
	Engine30I6.model = "models/engines/inline6s.mdl"
	Engine30I6.sound = "ACF_engines/l6_dieselsmall.wav"
	Engine30I6.category = "I6"
	Engine30I6.weight = 300
	Engine30I6.torque = 240		--in Meter/Kg
	Engine30I6.flywheelmass = 0.5
		
	Engine30I6.idlerpm = 650	--in Rotations Per Minute
	Engine30I6.peakminrpm = 1000
	Engine30I6.peakmaxrpm = 3000
	Engine30I6.limitprm = 4500
	if ( CLIENT ) then
		Engine30I6.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine30I6.guiupdate = function() return end
	end
MobilityTable["3.0-I6"] = Engine30I6

local Engine65I6 = {}
	Engine65I6.id = "6.5-I6"
	Engine65I6.ent = "acf_engine"
	Engine65I6.type = "Mobility"
	Engine65I6.name = "6.5L I6 Diesel"
	Engine65I6.desc = "Truck duty I6, good overall powerband and torque"
	Engine65I6.model = "models/engines/inline6m.mdl"
	Engine65I6.sound = "ACF_engines/l6_dieselmedium4.wav"
	Engine65I6.category = "I6"
	Engine65I6.weight = 650
	Engine65I6.torque = 550		--in Meter/Kg
	Engine65I6.flywheelmass = 1.5
	
	Engine65I6.idlerpm = 600	--in Rotations Per Minute
	Engine65I6.peakminrpm = 1100
	Engine65I6.peakmaxrpm = 3500
	Engine65I6.limitprm = 4000
	if ( CLIENT ) then
		Engine65I6.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine65I6.guiupdate = function() return end
	end
MobilityTable["6.5-I6"] = Engine65I6

local Engine200I6 = {}
	Engine200I6.id = "20.0-I6"
	Engine200I6.ent = "acf_engine"
	Engine200I6.type = "Mobility"
	Engine200I6.name = "20.0L I6 Diesel"
	Engine200I6.desc = "Heavy duty diesel I6, used in generators and heavy movers"
	Engine200I6.model = "models/engines/inline6l.mdl"
	Engine200I6.sound = "ACF_engines/l6_diesellarge2.wav"
	Engine200I6.category = "I6"
	Engine200I6.weight = 1000
	Engine200I6.torque = 2000		--in Meter/Kg
	Engine200I6.flywheelmass = 8
	
	Engine200I6.idlerpm = 400	--in Rotations Per Minute
	Engine200I6.peakminrpm = 500
	Engine200I6.peakmaxrpm = 1700
	Engine200I6.limitprm = 2250
	if ( CLIENT ) then
		Engine200I6.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine200I6.guiupdate = function() return end
	end
MobilityTable["20.0-I6"] = Engine200I6



--Petrol L6s
local Engine22I6 = {}
	Engine22I6.id = "2.2-I6"
	Engine22I6.ent = "acf_engine"
	Engine22I6.type = "Mobility"
	Engine22I6.name = "2.2L I6 Petrol"
	Engine22I6.desc = "Car sized I6 petrol with power in the high revs"
	Engine22I6.model = "models/engines/inline6s.mdl"
	Engine22I6.sound = "ACF_engines/l6_petrolsmall2.wav"
	Engine22I6.category = "I6"
	Engine22I6.weight = 250
	Engine22I6.torque = 190		--in Meter/Kg
	Engine22I6.flywheelmass = 0.1
	
	Engine22I6.idlerpm = 800	--in Rotations Per Minute
	Engine22I6.peakminrpm = 4000
	Engine22I6.peakmaxrpm = 6500
	Engine22I6.limitprm = 7200
	if ( CLIENT ) then
		Engine22I6.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine22I6.guiupdate = function() return end
	end
MobilityTable["2.2-I6"] = Engine22I6

local Engine48I6 = {}
	Engine48I6.id = "4.8-I6"
	Engine48I6.ent = "acf_engine"
	Engine48I6.type = "Mobility"
	Engine48I6.name = "4.8L I6 Petrol"
	Engine48I6.desc = "Light truck duty I6, good for offroad applications"
	Engine48I6.model = "models/engines/inline6m.mdl"
	Engine48I6.sound = "ACF_engines/l6_petrolmedium.wav"
	Engine48I6.category = "I6"
	Engine48I6.weight = 350
	Engine48I6.torque = 400		--in Meter/Kg
	Engine48I6.flywheelmass = 0.2
	
	Engine48I6.idlerpm = 900	--in Rotations Per Minute
	Engine48I6.peakminrpm = 3500
	Engine48I6.peakmaxrpm = 5800
	Engine48I6.limitprm = 6500
	if ( CLIENT ) then
		Engine48I6.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine48I6.guiupdate = function() return end
	end
MobilityTable["4.8-I6"] = Engine48I6

local Engine172I6 = {}
	Engine172I6.id = "17.2-I6"
	Engine172I6.ent = "acf_engine"
	Engine172I6.type = "Mobility"
	Engine172I6.name = "17.2L I6 Petrol"
	Engine172I6.desc = "Heavy tractor duty petrol I6, decent overall powerband"
	Engine172I6.model = "models/engines/inline6l.mdl"
	Engine172I6.sound = "ACF_engines/l6_petrollarge2.wav"
	Engine172I6.category = "I6"
	Engine172I6.weight = 700
	Engine172I6.torque = 1200		--in Meter/Kg
	Engine172I6.flywheelmass = 2.5
	
	Engine172I6.idlerpm = 800	--in Rotations Per Minute
	Engine172I6.peakminrpm = 2000
	Engine172I6.peakmaxrpm = 3300
	Engine172I6.limitprm = 4000
	if ( CLIENT ) then
		Engine172I6.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine172I6.guiupdate = function() return end
	end
MobilityTable["17.2-I6"] = Engine172I6




--Diesel V12s

local Engine40V12 = {}
	Engine40V12.id = "4.0-V12"
	Engine40V12.ent = "acf_engine"
	Engine40V12.type = "Mobility"
	Engine40V12.name = "4.0L V12 Diesel"
	Engine40V12.desc = "An old V12; not much power, but a lot of smooth torque"
	Engine40V12.model = "models/engines/v12s.mdl"
	Engine40V12.sound = "ACF_engines/v12_dieselsmall.wav"
	Engine40V12.category = "V12"
	Engine40V12.weight = 400
	Engine40V12.torque = 400		--in Meter/Kg
	Engine40V12.flywheelmass = 0.475
	
	Engine40V12.idlerpm = 650	--in Rotations Per Minute
	Engine40V12.peakminrpm = 1200
	Engine40V12.peakmaxrpm = 3800
	Engine40V12.limitprm = 4000
	if ( CLIENT ) then
		Engine40V12.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine40V12.guiupdate = function() return end
	end
MobilityTable["4.0-V12"] = Engine40V12

local Engine92V12 = {}
	Engine92V12.id = "9.2-V12"
	Engine92V12.ent = "acf_engine"
	Engine92V12.type = "Mobility"
	Engine92V12.name = "9.2L V12 Diesel"
	Engine92V12.desc = "High torque V12, used mainly for vehicles that require balls"
	Engine92V12.model = "models/engines/v12m.mdl"
	Engine92V12.sound = "ACF_engines/v12_dieselmedium.wav"
	Engine92V12.category = "V12"
	Engine92V12.weight = 900
	Engine92V12.torque = 1000		--in Meter/Kg
	Engine92V12.flywheelmass = 2.5
	
	Engine92V12.idlerpm = 675	--in Rotations Per Minute
	Engine92V12.peakminrpm = 1100
	Engine92V12.peakmaxrpm = 3300
	Engine92V12.limitprm = 3500
	if ( CLIENT ) then
		Engine92V12.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine92V12.guiupdate = function() return end
	end
MobilityTable["9.2-V12"] = Engine92V12

local Engine210V12 = {}
	Engine210V12.id = "21.0-V12"
	Engine210V12.ent = "acf_engine"
	Engine210V12.type = "Mobility"
	Engine210V12.name = "21.0 V12 Diesel"
	Engine210V12.desc = "Extreme duty V12; however massively powerful, it is enormous and heavy"
	Engine210V12.model = "models/engines/v12l.mdl"
	Engine210V12.sound = "ACF_engines/v12_diesellarge.wav"
	Engine210V12.category = "V12"
	Engine210V12.weight = 1500
	Engine210V12.torque = 2800		--in Meter/Kg
	Engine210V12.flywheelmass = 7
	
	Engine210V12.idlerpm = 400	--in Rotations Per Minute
	Engine210V12.peakminrpm = 500
	Engine210V12.peakmaxrpm = 1500
	Engine210V12.limitprm = 2500
	if ( CLIENT ) then
		Engine210V12.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine210V12.guiupdate = function() return end
	end
MobilityTable["21.0-V12"] = Engine210V12



--Petrol V12s
local Engine46V12 = {}
	Engine46V12.id = "4.6-V12"
	Engine46V12.ent = "acf_engine"
	Engine46V12.type = "Mobility"
	Engine46V12.name = "4.6L V12 Petrol"
	Engine46V12.desc = "An old racing engine; low on torque, but plenty of power"
	Engine46V12.model = "models/engines/v12s.mdl"
	Engine46V12.sound = "ACF_engines/v12_petrolsmall.wav"
	Engine46V12.category = "V12"
	Engine46V12.weight = 300
	Engine46V12.torque = 250		--in Meter/Kg
	Engine46V12.flywheelmass = 0.2
	
	Engine46V12.idlerpm = 1000	--in Rotations Per Minute
	Engine46V12.peakminrpm = 4500
	Engine46V12.peakmaxrpm = 7500
	Engine46V12.limitprm = 8000
	if ( CLIENT ) then
		Engine46V12.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine46V12.guiupdate = function() return end
	end
MobilityTable["4.6-V12"] = Engine46V12

local Engine70V12 = {}
	Engine70V12.id = "7.0-V12"
	Engine70V12.ent = "acf_engine"
	Engine70V12.type = "Mobility"
	Engine70V12.name = "7.0L V12 Petrol"
	Engine70V12.desc = "A high end V12; primarily found in very expensive cars"
	Engine70V12.model = "models/engines/v12m.mdl"
	Engine70V12.sound = "ACF_engines/v12_petrolmedium.wav"
	Engine70V12.category = "V12"
	Engine70V12.weight = 450
	Engine70V12.torque = 520		--in Meter/Kg
	Engine70V12.flywheelmass = 0.450
	
	Engine70V12.idlerpm = 800	--in Rotations Per Minute
	Engine70V12.peakminrpm = 3600
	Engine70V12.peakmaxrpm = 6000
	Engine70V12.limitprm = 7500
	if ( CLIENT ) then
		Engine70V12.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine70V12.guiupdate = function() return end
	end
MobilityTable["7.0-V12"] = Engine70V12

local Engine230V12 = {}
	Engine230V12.id = "23.0-V12"
	Engine230V12.ent = "acf_engine"
	Engine230V12.type = "Mobility"
	Engine230V12.name = "23.0 V12 Petrol"
	Engine230V12.desc = "A large, thirsty gasoline V12, likes to break down and roast crewmen"
	Engine230V12.model = "models/engines/v12l.mdl"
	Engine230V12.sound = "ACF_engines/v12_petrollarge.wav"
	Engine230V12.category = "V12"
	Engine230V12.weight = 1300
	Engine230V12.torque = 1800		--in Meter/Kg
	Engine230V12.flywheelmass = 5
	
	Engine230V12.idlerpm = 600	--in Rotations Per Minute
	Engine230V12.peakminrpm = 1500
	Engine230V12.peakmaxrpm = 3000
	Engine230V12.limitprm = 3000
	if ( CLIENT ) then
		Engine230V12.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine230V12.guiupdate = function() return end
	end
MobilityTable["23.0-V12"] = Engine230V12




--Petrol Radials
local Engine38R7 = {}
	Engine38R7.id = "3.8-R7"
	Engine38R7.ent = "acf_engine"
	Engine38R7.type = "Mobility"
	Engine38R7.name = "3.8L R7 Petrol"
	Engine38R7.desc = "A tiny, old worn-out radial."
	Engine38R7.model = "models/engines/radial7s.mdl"
	Engine38R7.sound = "ACF_engines/R7_petrolsmall.wav"
	Engine38R7.category = "Radial"
	Engine38R7.weight = 150
	Engine38R7.torque = 250		--in Meter/Kg
	Engine38R7.flywheelmass = 0.15
	
	Engine38R7.idlerpm = 700	--in Rotations Per Minute
	Engine38R7.peakminrpm = 2800
	Engine38R7.peakmaxrpm = 4500
	Engine38R7.limitprm = 5000
	if ( CLIENT ) then
		Engine38R7.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine38R7.guiupdate = function() return end
	end
MobilityTable["3.8-R7"] = Engine38R7

local Engine11R7 = {}
	Engine11R7.id = "11.0-R7"
	Engine11R7.ent = "acf_engine"
	Engine11R7.type = "Mobility"
	Engine11R7.name = "11.0 R7 Petrol"
	Engine11R7.desc = "Mid range radial, thirsty and smooth"
	Engine11R7.model = "models/engines/radial7m.mdl"
	Engine11R7.sound = "ACF_engines/R7_petrolmedium.wav"
	Engine11R7.category = "Radial"
	Engine11R7.weight = 350
	Engine11R7.torque = 550		--in Meter/Kg
	Engine11R7.flywheelmass = 0.350
	
	Engine11R7.idlerpm = 600	--in Rotations Per Minute
	Engine11R7.peakminrpm = 2200
	Engine11R7.peakmaxrpm = 3700
	Engine11R7.limitprm = 3700
	if ( CLIENT ) then
		Engine11R7.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine11R7.guiupdate = function() return end
	end
MobilityTable["11.0-R7"] = Engine11R7

local Engine240R7 = {}
	Engine240R7.id = "24.0-R7"
	Engine240R7.ent = "acf_engine"
	Engine240R7.type = "Mobility"
	Engine240R7.name = "24.0L R7 Petrol"
	Engine240R7.desc = "The beast of Radials, this monster was destined for fighter aircraft."
	Engine240R7.model = "models/engines/radial7l.mdl"
	Engine240R7.sound = "ACF_engines/R7_petrollarge.wav"
	Engine240R7.category = "Radial"
	Engine240R7.weight = 800
	Engine240R7.torque = 1600		--in Meter/Kg
	Engine240R7.flywheelmass = 3
	
	Engine240R7.idlerpm = 750	--in Rotations Per Minute
	Engine240R7.peakminrpm = 1900
	Engine240R7.peakmaxrpm = 3000
	Engine240R7.limitprm = 3000
	if ( CLIENT ) then
		Engine240R7.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine240R7.guiupdate = function() return end
	end
MobilityTable["24.0-R7"] = Engine240R7





--Petrol V8s
local Engine180V8 = {}
	Engine180V8.id = "18.0-V8"
	Engine180V8.ent = "acf_engine"
	Engine180V8.type = "Mobility"
	Engine180V8.name = "18.0L V8 Petrol"
	Engine180V8.desc = "American Ford GAA V8, decent overall power and torque and fairly lightweight"
	Engine180V8.model = "models/engines/v8l.mdl"
	Engine180V8.sound = "ACF_engines/v8_petrollarge.wav"
	Engine180V8.category = "V8"
	Engine180V8.weight = 900
	Engine180V8.torque = 1420		--in Meter/Kg
	Engine180V8.flywheelmass = 2.8
	
	Engine180V8.idlerpm = 600	--in Rotations Per Minute
	Engine180V8.peakminrpm = 1800
	Engine180V8.peakmaxrpm = 3000
	Engine180V8.limitprm = 3800
	if ( CLIENT ) then
		Engine180V8.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine180V8.guiupdate = function() return end
	end
MobilityTable["18.0-V8"] = Engine180V8

local Engine90V8 = {}
	Engine90V8.id = "9.0-V8"
	Engine90V8.ent = "acf_engine"
	Engine90V8.type = "Mobility"
	Engine90V8.name = "9.0L V8 Petrol"
	Engine90V8.desc = "Thirsty, giant V8, for medium applications"
	Engine90V8.model = "models/engines/v8m.mdl"
	Engine90V8.sound = "ACF_engines/v8_petrolmedium.wav"
	Engine90V8.category = "V8"
	Engine90V8.weight = 500
	Engine90V8.torque = 575		--in Meter/Kg
	Engine90V8.flywheelmass = 0.25
	
	Engine90V8.idlerpm = 700	--in Rotations Per Minute
	Engine90V8.peakminrpm = 3100
	Engine90V8.peakmaxrpm = 5000
	Engine90V8.limitprm = 5500
	if ( CLIENT ) then
		Engine90V8.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine90V8.guiupdate = function() return end
	end
MobilityTable["9.0-V8"] = Engine90V8

local Engine57V8 = {}
	Engine57V8.id = "5.7-V8"
	Engine57V8.ent = "acf_engine"
	Engine57V8.type = "Mobility"
	Engine57V8.name = "5.7L V8 Petrol"
	Engine57V8.desc = "Car sized petrol engine, good power and mid range torque"
	Engine57V8.model = "models/engines/v8s.mdl"
	Engine57V8.sound = "ACF_engines/v8_petrolsmall.wav"
	Engine57V8.category = "V8"
	Engine57V8.weight = 350
	Engine57V8.torque = 400		--in Meter/Kg
	Engine57V8.flywheelmass = 0.15
	--Engine57V8.idlesound = "ACF_engines/v8idle_petrolsmall.wav"
	
	Engine57V8.idlerpm = 800	--in Rotations Per Minute
	Engine57V8.peakminrpm = 3000
	Engine57V8.peakmaxrpm = 5000
	Engine57V8.limitprm = 6500
	if ( CLIENT ) then
		Engine57V8.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine57V8.guiupdate = function() return end
	end
MobilityTable["5.7-V8"] = Engine57V8




--Diesel V8s
local Engine190V8 = {}
	Engine190V8.id = "19.0-V8"
	Engine190V8.ent = "acf_engine"
	Engine190V8.type = "Mobility"
	Engine190V8.name = "19.0L V8 Diesel"
	Engine190V8.desc = "Heavy duty diesel V8, used for heavy construction equipment"
	Engine190V8.model = "models/engines/v8l.mdl"
	Engine190V8.sound = "ACF_engines/v8_diesellarge.wav"
	Engine190V8.category = "V8"
	Engine190V8.weight = 1300
	Engine190V8.torque = 2400		--in Meter/Kg
	Engine190V8.flywheelmass = 4.5
	
	Engine190V8.idlerpm = 500	--in Rotations Per Minute
	Engine190V8.peakminrpm = 550
	Engine190V8.peakmaxrpm = 1650
	Engine190V8.limitprm = 2700
	if ( CLIENT ) then
		Engine190V8.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine190V8.guiupdate = function() return end
	end
MobilityTable["19.0-V8"] = Engine190V8

local Engine78V8 = {}
	Engine78V8.id = "7.8-V8"
	Engine78V8.ent = "acf_engine"
	Engine78V8.type = "Mobility"
	Engine78V8.name = "7.8L V8 Diesel"
	Engine78V8.desc = "Utility grade V8 diesel, has a good, wide powerband"
	Engine78V8.model = "models/engines/v8m.mdl"
	Engine78V8.sound = "ACF_engines/v8_dieselmedium2.wav"
	Engine78V8.category = "V8"
	Engine78V8.weight = 600
	Engine78V8.torque = 710		--in Meter/Kg
	Engine78V8.flywheelmass = 1.5
	
	Engine78V8.idlerpm = 650	--in Rotations Per Minute
	Engine78V8.peakminrpm = 1000
	Engine78V8.peakmaxrpm = 3000
	Engine78V8.limitprm = 4000
	if ( CLIENT ) then
		Engine78V8.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine78V8.guiupdate = function() return end
	end
MobilityTable["7.8-V8"] = Engine78V8

local Engine45V8 = {}
	Engine45V8.id = "4.5-V8"
	Engine45V8.ent = "acf_engine"
	Engine45V8.type = "Mobility"
	Engine45V8.name = "4.5L V8 Diesel"
	Engine45V8.desc = "Light duty diesel v8, good for light vehicles that require a lot of torque"
	Engine45V8.model = "models/engines/v8s.mdl"
	Engine45V8.sound = "ACF_engines/v8_dieselsmall.wav"
	Engine45V8.category = "V8"
	Engine45V8.weight = 400
	Engine45V8.torque = 475		--in Meter/Kg
	Engine45V8.flywheelmass = 0.75
	
	Engine45V8.idlerpm = 800	--in Rotations Per Minute
	Engine45V8.peakminrpm = 1000
	Engine45V8.peakmaxrpm = 3000
	Engine45V8.limitprm = 5000
	if ( CLIENT ) then
		Engine45V8.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine45V8.guiupdate = function() return end
	end
MobilityTable["4.5-V8"] = Engine45V8





-- Diffs

local Gear1TS = {}
	Gear1TS.id = "1Gear-T-S"
	Gear1TS.ent = "acf_gearbox"
	Gear1TS.type = "Mobility"
	Gear1TS.name = "Differential, Small"
	Gear1TS.desc = "Small differential, used to connect power from gearbox to wheels"
	Gear1TS.model = "models/engines/transaxial_s.mdl"
	Gear1TS.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear1TS.category = "Differential"
	Gear1TS.weight = Gear1SW
	Gear1TS.switch = 0.3
	Gear1TS.maxtq = GearTDSMT
	Gear1TS.gears = 1
	Gear1TS.doubleclutch = false
	Gear1TS.geartable = {}
		Gear1TS.geartable[-1] = 0.5
		Gear1TS.geartable[0] = 0
		Gear1TS.geartable[1] = 0.5
	if ( CLIENT ) then
		Gear1TS.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear1TS.guiupdate = function() return end
	end
MobilityTable["1Gear-T-S"] = Gear1TS

local Gear1TM = {}
	Gear1TM.id = "1Gear-T-M"
	Gear1TM.ent = "acf_gearbox"
	Gear1TM.type = "Mobility"
	Gear1TM.name = "Differential, Medium"
	Gear1TM.desc = "Medium duty differential"
	Gear1TM.model = "models/engines/transaxial_m.mdl"
	Gear1TM.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear1TM.category = "Differential"
	Gear1TM.weight = Gear1MW
	Gear1TM.switch = 0.4
	Gear1TM.maxtq = GearMMT
	Gear1TM.gears = 1
	Gear1TM.doubleclutch = false
	Gear1TM.geartable = {}
		Gear1TM.geartable[-1] = 0.5
		Gear1TM.geartable[0] = 0
		Gear1TM.geartable[1] = 0.5
	if ( CLIENT ) then
		Gear1TM.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear1TM.guiupdate = function() return end
	end
MobilityTable["1Gear-T-M"] = Gear1TM

local Gear1TL = {}
	Gear1TL.id = "1Gear-T-L"
	Gear1TL.ent = "acf_gearbox"
	Gear1TL.type = "Mobility"
	Gear1TL.name = "Differential, Large"
	Gear1TL.desc = "Heavy duty differential, for the heaviest of engines"
	Gear1TL.model = "models/engines/transaxial_l.mdl"
	Gear1TL.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear1TL.category = "Differential"
	Gear1TL.weight = Gear1LW
	Gear1TL.switch = 0.6
	Gear1TL.maxtq = GearLMT
	Gear1TL.gears = 1
	Gear1TL.doubleclutch = false
	Gear1TL.geartable = {}
		Gear1TL.geartable[-1] = 1
		Gear1TL.geartable[0] = 0
		Gear1TL.geartable[1] = 0.5
	if ( CLIENT ) then
		Gear1TL.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear1TL.guiupdate = function() return end
	end
MobilityTable["1Gear-T-L"] = Gear1TL



local Gear1LS = {}
	Gear1LS.id = "1Gear-L-S"
	Gear1LS.ent = "acf_gearbox"
	Gear1LS.type = "Mobility"
	Gear1LS.name = "Differential, Inline, Small"
	Gear1LS.desc = "Small differential, used to connect power from gearbox to wheels"
	Gear1LS.model = "models/engines/linear_s.mdl"
	Gear1LS.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear1LS.category = "Differential"
	Gear1LS.weight = Gear1SW
	Gear1LS.switch = 0.3
	Gear1LS.maxtq = GearTDSMT
	Gear1LS.gears = 1
	Gear1LS.doubleclutch = false
	Gear1LS.geartable = {}
		Gear1LS.geartable[-1] = 0.5
		Gear1LS.geartable[0] = 0
		Gear1LS.geartable[1] = 0.5
	if ( CLIENT ) then
		Gear1LS.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear1LS.guiupdate = function() return end
	end
MobilityTable["1Gear-L-S"] = Gear1LS

local Gear1LM = {}
	Gear1LM.id = "1Gear-L-M"
	Gear1LM.ent = "acf_gearbox"
	Gear1LM.type = "Mobility"
	Gear1LM.name = "Differential, Inline, Medium"
	Gear1LM.desc = "Medium duty differential"
	Gear1LM.model = "models/engines/linear_m.mdl"
	Gear1LM.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear1LM.category = "Differential"
	Gear1LM.weight = Gear1MW
	Gear1LM.switch = 0.4
	Gear1LM.maxtq = GearMMT
	Gear1LM.gears = 1
	Gear1LM.doubleclutch = false
	Gear1LM.geartable = {}
		Gear1LM.geartable[-1] = 0.5
		Gear1LM.geartable[0] = 0
		Gear1LM.geartable[1] = 0.5
	if ( CLIENT ) then
		Gear1LM.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear1LM.guiupdate = function() return end
	end
MobilityTable["1Gear-L-M"] = Gear1LM

local Gear1LL = {}
	Gear1LL.id = "1Gear-L-L"
	Gear1LL.ent = "acf_gearbox"
	Gear1LL.type = "Mobility"
	Gear1LL.name = "Differential, Inline, Large"
	Gear1LL.desc = "Heavy duty differential, for the heaviest of engines"
	Gear1LL.model = "models/engines/linear_l.mdl"
	Gear1LL.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear1LL.category = "Differential"
	Gear1LL.weight = Gear1LW
	Gear1LL.switch = 0.6
	Gear1LL.maxtq = GearLMT
	Gear1LL.gears = 1
	Gear1LL.doubleclutch = false
	Gear1LL.geartable = {}
		Gear1LL.geartable[-1] = 1
		Gear1LL.geartable[0] = 0
		Gear1LL.geartable[1] = 0.5
	if ( CLIENT ) then
		Gear1LL.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear1LL.guiupdate = function() return end
	end
MobilityTable["1Gear-L-L"] = Gear1LL

--Diffs, dual clutch


local Gear1TDS = {}
	Gear1TDS.id = "1Gear-TD-S"
	Gear1TDS.ent = "acf_gearbox"
	Gear1TDS.type = "Mobility"
	Gear1TDS.name = "Differential, Small, Dual Clutch"
	Gear1TDS.desc = "Small differential, used to connect power from gearbox to wheels"
	Gear1TDS.model = "models/engines/transaxial_s.mdl"
	Gear1TDS.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear1TDS.category = "Differential"
	Gear1TDS.weight = Gear1SW
	Gear1TDS.switch = 0.3
	Gear1TDS.maxtq = GearTDSMT
	Gear1TDS.gears = 1
	Gear1TDS.doubleclutch = true
	Gear1TDS.geartable = {}
		Gear1TDS.geartable[-1] = 0.5
		Gear1TDS.geartable[0] = 0
		Gear1TDS.geartable[1] = 0.5
	if ( CLIENT ) then
		Gear1TDS.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear1TDS.guiupdate = function() return end
	end
MobilityTable["1Gear-TD-S"] = Gear1TDS

local Gear1TDM = {}
	Gear1TDM.id = "1Gear-TD-M"
	Gear1TDM.ent = "acf_gearbox"
	Gear1TDM.type = "Mobility"
	Gear1TDM.name = "Differential, Medium, Dual Clutch"
	Gear1TDM.desc = "Medium duty differential"
	Gear1TDM.model = "models/engines/transaxial_m.mdl"
	Gear1TDM.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear1TDM.category = "Differential"
	Gear1TDM.weight = Gear1MW
	Gear1TDM.switch = 0.4
	Gear1TDM.maxtq = GearMMT
	Gear1TDM.gears = 1
	Gear1TDM.doubleclutch = true
	Gear1TDM.geartable = {}
		Gear1TDM.geartable[-1] = 0.5
		Gear1TDM.geartable[0] = 0
		Gear1TDM.geartable[1] = 0.5
	if ( CLIENT ) then
		Gear1TDM.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear1TDM.guiupdate = function() return end
	end
MobilityTable["1Gear-TD-M"] = Gear1TDM

local Gear1TDL = {}
	Gear1TDL.id = "1Gear-TD-L"
	Gear1TDL.ent = "acf_gearbox"
	Gear1TDL.type = "Mobility"
	Gear1TDL.name = "Differential, Large, Dual Clutch"
	Gear1TDL.desc = "Heavy duty differential, for the heaviest of engines"
	Gear1TDL.model = "models/engines/transaxial_l.mdl"
	Gear1TDL.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear1TDL.category = "Differential"
	Gear1TDL.weight = Gear1LW
	Gear1TDL.switch = 0.6
	Gear1TDL.maxtq = GearLMT
	Gear1TDL.gears = 1
	Gear1TDL.doubleclutch = true
	Gear1TDL.geartable = {}
		Gear1TDL.geartable[-1] = 1
		Gear1TDL.geartable[0] = 0
		Gear1TDL.geartable[1] = 0.5
	if ( CLIENT ) then
		Gear1TDL.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear1TDL.guiupdate = function() return end
	end
MobilityTable["1Gear-TD-L"] = Gear1TDL



local Gear1LDS = {}
	Gear1LDS.id = "1Gear-LD-S"
	Gear1LDS.ent = "acf_gearbox"
	Gear1LDS.type = "Mobility"
	Gear1LDS.name = "Differential, Inline, Small, Dual Clutch"
	Gear1LDS.desc = "Small differential, used to connect power from gearbox to wheels"
	Gear1LDS.model = "models/engines/linear_s.mdl"
	Gear1LDS.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear1LDS.category = "Differential"
	Gear1LDS.weight = Gear1SW
	Gear1LDS.switch = 0.3
	Gear1LDS.maxtq = GearTDSMT
	Gear1LDS.gears = 1
	Gear1LDS.doubleclutch = true
	Gear1LDS.geartable = {}
		Gear1LDS.geartable[-1] = 0.5
		Gear1LDS.geartable[0] = 0
		Gear1LDS.geartable[1] = 0.5
	if ( CLIENT ) then
		Gear1LDS.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear1LDS.guiupdate = function() return end
	end
MobilityTable["1Gear-LD-S"] = Gear1LDS

local Gear1LDM = {}
	Gear1LDM.id = "1Gear-LD-M"
	Gear1LDM.ent = "acf_gearbox"
	Gear1LDM.type = "Mobility"
	Gear1LDM.name = "Differential, Inline, Medium, Dual Clutch"
	Gear1LDM.desc = "Medium duty differential"
	Gear1LDM.model = "models/engines/linear_m.mdl"
	Gear1LDM.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear1LDM.category = "Differential"
	Gear1LDM.weight = Gear1MW
	Gear1LDM.switch = 0.4
	Gear1LDM.maxtq = GearMMT
	Gear1LDM.gears = 1
	Gear1LDM.doubleclutch = true
	Gear1LDM.geartable = {}
		Gear1LDM.geartable[-1] = 0.5
		Gear1LDM.geartable[0] = 0
		Gear1LDM.geartable[1] = 0.5
	if ( CLIENT ) then
		Gear1LDM.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear1LDM.guiupdate = function() return end
	end
MobilityTable["1Gear-LD-M"] = Gear1LDM

local Gear1LDL = {}
	Gear1LDL.id = "1Gear-LD-L"
	Gear1LDL.ent = "acf_gearbox"
	Gear1LDL.type = "Mobility"
	Gear1LDL.name = "Differential, Inline, Large, Dual Clutch"
	Gear1LDL.desc = "Heavy duty differential, for the heaviest of engines"
	Gear1LDL.model = "models/engines/linear_l.mdl"
	Gear1LDL.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear1LDL.category = "Differential"
	Gear1LDL.weight = Gear1LW
	Gear1LDL.switch = 0.6
	Gear1LDL.maxtq = GearLMT
	Gear1LDL.gears = 1
	Gear1LDL.doubleclutch = true
	Gear1LDL.geartable = {}
		Gear1LDL.geartable[-1] = 1
		Gear1LDL.geartable[0] = 0
		Gear1LDL.geartable[1] = 0.5
	if ( CLIENT ) then
		Gear1LDL.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear1LDL.guiupdate = function() return end
	end
MobilityTable["1Gear-LD-L"] = Gear1LDL


--2 speed transfer boxes

local Gear2TS = {}
	Gear2TS.id = "2Gear-T-S"
	Gear2TS.ent = "acf_gearbox"
	Gear2TS.type = "Mobility"
	Gear2TS.name = "Transfer case, Small"
	Gear2TS.desc = "2 speed gearbox, useful for low/high range and tank turning"
	Gear2TS.model = "models/engines/transaxial_s.mdl"
	Gear2TS.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear2TS.category = "Transfer"
	Gear2TS.weight = Gear2SW
	Gear2TS.switch = 0.3
	Gear2TS.maxtq = GearTDSMT
	Gear2TS.gears = 2
	Gear2TS.doubleclutch = true
	Gear2TS.geartable = {}
		Gear2TS.geartable[-1] = 0.5
		Gear2TS.geartable[0] = 0
		Gear2TS.geartable[1] = 0.5
		Gear2TS.geartable[2] = -0.5
	if ( CLIENT ) then
		Gear2TS.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear2TS.guiupdate = function() return end
	end
MobilityTable["2Gear-T-S"] = Gear2TS

local Gear2TM = {}
	Gear2TM.id = "2Gear-T-M"
	Gear2TM.ent = "acf_gearbox"
	Gear2TM.type = "Mobility"
	Gear2TM.name = "Transfer case, Medium"
	Gear2TM.desc = "2 speed gearbox, useful for low/high range and tank turning"
	Gear2TM.model = "models/engines/transaxial_m.mdl"
	Gear2TM.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear2TM.category = "Transfer"
	Gear2TM.weight = Gear2MW
	Gear2TM.switch = 0.4
	Gear2TM.maxtq = GearMMT
	Gear2TM.gears = 2
	Gear2TM.doubleclutch = true
	Gear2TM.geartable = {}
		Gear2TM.geartable[-1] = 0.5
		Gear2TM.geartable[0] = 0
		Gear2TM.geartable[1] = 0.5
		Gear2TM.geartable[2] = -0.5
	if ( CLIENT ) then
		Gear2TM.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear2TM.guiupdate = function() return end
	end
MobilityTable["2Gear-T-M"] = Gear2TM

local Gear2TL = {}
	Gear2TL.id = "2Gear-T-L"
	Gear2TL.ent = "acf_gearbox"
	Gear2TL.type = "Mobility"
	Gear2TL.name = "Transfer case, Large"
	Gear2TL.desc = "2 speed gearbox, useful for low/high range and tank turning"
	Gear2TL.model = "models/engines/transaxial_l.mdl"
	Gear2TL.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear2TL.category = "Transfer"
	Gear2TL.weight = Gear2LW
	Gear2TL.switch = 0.6
	Gear2TL.maxtq = GearLMT
	Gear2TL.gears = 2
	Gear2TL.doubleclutch = true
	Gear2TL.geartable = {}
		Gear2TL.geartable[-1] = 1
		Gear2TL.geartable[0] = 0
		Gear2TL.geartable[1] = 0.5
		Gear2TL.geartable[2] = -0.5
	if ( CLIENT ) then
		Gear2TL.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear2TL.guiupdate = function() return end
	end
MobilityTable["2Gear-T-L"] = Gear2TL

local Gear2LS = {}
	Gear2LS.id = "2Gear-L-S"
	Gear2LS.ent = "acf_gearbox"
	Gear2LS.type = "Mobility"
	Gear2LS.name = "Transfer case, Inline, Small"
	Gear2LS.desc = "2 speed gearbox, useful for low/high range and tank turning"
	Gear2LS.model = "models/engines/linear_s.mdl"
	Gear2LS.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear2LS.category = "Transfer"
	Gear2LS.weight = Gear2SW
	Gear2LS.switch = 0.3
	Gear2LS.maxtq = GearTDSMT
	Gear2LS.gears = 2
	Gear2LS.doubleclutch = true
	Gear2LS.geartable = {}
		Gear2LS.geartable[-1] = 0.5
		Gear2LS.geartable[0] = 0
		Gear2LS.geartable[1] = 0.5
		Gear2LS.geartable[2] = -0.5
	if ( CLIENT ) then
		Gear2LS.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear2LS.guiupdate = function() return end
	end
MobilityTable["2Gear-L-S"] = Gear2LS

local Gear2LM = {}
	Gear2LM.id = "2Gear-L-M"
	Gear2LM.ent = "acf_gearbox"
	Gear2LM.type = "Mobility"
	Gear2LM.name = "Transfer case, Inline, Medium"
	Gear2LM.desc = "2 speed gearbox, useful for low/high range and tank turning"
	Gear2LM.model = "models/engines/linear_m.mdl"
	Gear2LM.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear2LM.category = "Transfer"
	Gear2LM.weight = Gear2MW
	Gear2LM.switch = 0.4
	Gear2LM.maxtq = GearMMT
	Gear2LM.gears = 2
	Gear2LM.doubleclutch = true
	Gear2LM.geartable = {}
		Gear2LM.geartable[-1] = 0.5
		Gear2LM.geartable[0] = 0
		Gear2LM.geartable[1] = 0.5
		Gear2LM.geartable[2] = -0.5
	if ( CLIENT ) then
		Gear2LM.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear2LM.guiupdate = function() return end
	end
MobilityTable["2Gear-L-M"] = Gear2LM

local Gear2LL = {}
	Gear2LL.id = "2Gear-L-L"
	Gear2LL.ent = "acf_gearbox"
	Gear2LL.type = "Mobility"
	Gear2LL.name = "Transfer case, Inline, Large"
	Gear2LL.desc = "2 speed gearbox, useful for low/high range and tank turning"
	Gear2LL.model = "models/engines/linear_l.mdl"
	Gear2LL.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear2LL.category = "Transfer"
	Gear2LL.weight = Gear2LW
	Gear2LL.switch = 0.6
	Gear2LL.maxtq = GearLMT
	Gear2LL.gears = 2
	Gear2LL.doubleclutch = true
	Gear2LL.geartable = {}
		Gear2LL.geartable[-1] = 1
		Gear2LL.geartable[0] = 0
		Gear2LL.geartable[1] = 0.5
		Gear2LL.geartable[2] = -0.5
	if ( CLIENT ) then
		Gear2LL.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear2LL.guiupdate = function() return end
	end
MobilityTable["2Gear-L-L"] = Gear2LL



local Gear1LS = {}
	Gear1LS.id = "1Gear-L-S"
	Gear1LS.ent = "acf_gearbox"
	Gear1LS.type = "Mobility"
	Gear1LS.name = "Differential, Inline, Small"
	Gear1LS.desc = "Small differential, used to connect power from gearbox to wheels"
	Gear1LS.model = "models/engines/linear_s.mdl"
	Gear1LS.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear1LS.category = "Differential"
	Gear1LS.weight = Gear1SW
	Gear1LS.switch = 0.3
	Gear1LS.maxtq = GearTDSMT
	Gear1LS.gears = 1
	Gear1LS.doubleclutch = false
	Gear1LS.geartable = {}
		Gear1LS.geartable[-1] = 0.5
		Gear1LS.geartable[0] = 0
		Gear1LS.geartable[1] = 0.5
	if ( CLIENT ) then
		Gear1LS.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear1LS.guiupdate = function() return end
	end
MobilityTable["1Gear-L-S"] = Gear1LS

local Gear1LM = {}
	Gear1LM.id = "1Gear-L-M"
	Gear1LM.ent = "acf_gearbox"
	Gear1LM.type = "Mobility"
	Gear1LM.name = "Differential, Inline, Medium"
	Gear1LM.desc = "Medium duty differential"
	Gear1LM.model = "models/engines/linear_m.mdl"
	Gear1LM.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear1LM.category = "Differential"
	Gear1LM.weight = Gear1MW
	Gear1LM.switch = 0.4
	Gear1LM.maxtq = GearMMT
	Gear1LM.gears = 1
	Gear1LM.doubleclutch = false
	Gear1LM.geartable = {}
		Gear1LM.geartable[-1] = 0.5
		Gear1LM.geartable[0] = 0
		Gear1LM.geartable[1] = 0.5
	if ( CLIENT ) then
		Gear1LM.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear1LM.guiupdate = function() return end
	end
MobilityTable["1Gear-L-M"] = Gear1LM

local Gear1LL = {}
	Gear1LL.id = "1Gear-L-L"
	Gear1LL.ent = "acf_gearbox"
	Gear1LL.type = "Mobility"
	Gear1LL.name = "Differential, Inline, Large"
	Gear1LL.desc = "Heavy duty differential, for the heaviest of engines"
	Gear1LL.model = "models/engines/linear_l.mdl"
	Gear1LL.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear1LL.category = "Differential"
	Gear1LL.weight = Gear1LW
	Gear1LL.switch = 0.6
	Gear1LL.maxtq = GearLMT
	Gear1LL.gears = 1
	Gear1LL.doubleclutch = false
	Gear1LL.geartable = {}
		Gear1LL.geartable[-1] = 1
		Gear1LL.geartable[0] = 0
		Gear1LL.geartable[1] = 0.5
	if ( CLIENT ) then
		Gear1LL.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear1LL.guiupdate = function() return end
	end
MobilityTable["1Gear-L-L"] = Gear1LL

--


local Gear1TDS = {}
	Gear1TDS.id = "1Gear-TD-S"
	Gear1TDS.ent = "acf_gearbox"
	Gear1TDS.type = "Mobility"
	Gear1TDS.name = "Differential, Small, Dual Clutch"
	Gear1TDS.desc = "Small differential, used to connect power from gearbox to wheels"
	Gear1TDS.model = "models/engines/transaxial_s.mdl"
	Gear1TDS.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear1TDS.category = "Differential"
	Gear1TDS.weight = Gear1SW
	Gear1TDS.switch = 0.3
	Gear1TDS.maxtq = GearTDSMT
	Gear1TDS.gears = 1
	Gear1TDS.doubleclutch = true
	Gear1TDS.geartable = {}
		Gear1TDS.geartable[-1] = 0.5
		Gear1TDS.geartable[0] = 0
		Gear1TDS.geartable[1] = 0.5
	if ( CLIENT ) then
		Gear1TDS.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear1TDS.guiupdate = function() return end
	end
MobilityTable["1Gear-TD-S"] = Gear1TDS

local Gear1TDM = {}
	Gear1TDM.id = "1Gear-TD-M"
	Gear1TDM.ent = "acf_gearbox"
	Gear1TDM.type = "Mobility"
	Gear1TDM.name = "Differential, Medium, Dual Clutch"
	Gear1TDM.desc = "Medium duty differential"
	Gear1TDM.model = "models/engines/transaxial_m.mdl"
	Gear1TDM.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear1TDM.category = "Differential"
	Gear1TDM.weight = Gear1MW
	Gear1TDM.switch = 0.4
	Gear1TDM.maxtq = GearMMT
	Gear1TDM.gears = 1
	Gear1TDM.doubleclutch = true
	Gear1TDM.geartable = {}
		Gear1TDM.geartable[-1] = 0.5
		Gear1TDM.geartable[0] = 0
		Gear1TDM.geartable[1] = 0.5
	if ( CLIENT ) then
		Gear1TDM.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear1TDM.guiupdate = function() return end
	end
MobilityTable["1Gear-TD-M"] = Gear1DTM

local Gear1TDL = {}
	Gear1TDL.id = "1Gear-TD-L"
	Gear1TDL.ent = "acf_gearbox"
	Gear1TDL.type = "Mobility"
	Gear1TDL.name = "Differential, Large, Dual Clutch"
	Gear1TDL.desc = "Heavy duty differential, for the heaviest of engines"
	Gear1TDL.model = "models/engines/transaxial_l.mdl"
	Gear1TDL.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear1TDL.category = "Differential"
	Gear1TDL.weight = Gear1LW
	Gear1TDL.switch = 0.6
	Gear1TDL.maxtq = GearLMT
	Gear1TDL.gears = 1
	Gear1TDL.doubleclutch = true
	Gear1TDL.geartable = {}
		Gear1TDL.geartable[-1] = 1
		Gear1TDL.geartable[0] = 0
		Gear1TDL.geartable[1] = 0.5
	if ( CLIENT ) then
		Gear1TDL.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear1TDL.guiupdate = function() return end
	end
MobilityTable["1Gear-TD-L"] = Gear1TDL



local Gear1LDS = {}
	Gear1LDS.id = "1Gear-LD-S"
	Gear1LDS.ent = "acf_gearbox"
	Gear1LDS.type = "Mobility"
	Gear1LDS.name = "Differential, Inline, Small, Dual Clutch"
	Gear1LDS.desc = "Small differential, used to connect power from gearbox to wheels"
	Gear1LDS.model = "models/engines/linear_s.mdl"
	Gear1LDS.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear1LDS.category = "Differential"
	Gear1LDS.weight = Gear1SW
	Gear1LDS.switch = 0.3
	Gear1LDS.maxtq = GearTDSMT
	Gear1LDS.gears = 1
	Gear1LDS.doubleclutch = true
	Gear1LDS.geartable = {}
		Gear1LDS.geartable[-1] = 0.5
		Gear1LDS.geartable[0] = 0
		Gear1LDS.geartable[1] = 0.5
	if ( CLIENT ) then
		Gear1LDS.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear1LDS.guiupdate = function() return end
	end
MobilityTable["1Gear-LD-S"] = Gear1LDS

local Gear1LDM = {}
	Gear1LDM.id = "1Gear-LD-M"
	Gear1LDM.ent = "acf_gearbox"
	Gear1LDM.type = "Mobility"
	Gear1LDM.name = "Differential, Inline, Medium, Dual Clutch"
	Gear1LDM.desc = "Medium duty differential"
	Gear1LDM.model = "models/engines/linear_m.mdl"
	Gear1LDM.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear1LDM.category = "Differential"
	Gear1LDM.weight = Gear1MW
	Gear1LDM.switch = 0.4
	Gear1LDM.maxtq = GearMMT
	Gear1LDM.gears = 1
	Gear1LDM.doubleclutch = true
	Gear1LDM.geartable = {}
		Gear1LDM.geartable[-1] = 0.5
		Gear1LDM.geartable[0] = 0
		Gear1LDM.geartable[1] = 0.5
	if ( CLIENT ) then
		Gear1LDM.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear1LDM.guiupdate = function() return end
	end
MobilityTable["1Gear-LD-M"] = Gear1LDM

local Gear1LDL = {}
	Gear1LDL.id = "1Gear-LD-L"
	Gear1LDL.ent = "acf_gearbox"
	Gear1LDL.type = "Mobility"
	Gear1LDL.name = "Differential, Inline, Large, Dual Clutch"
	Gear1LDL.desc = "Heavy duty differential, for the heaviest of engines"
	Gear1LDL.model = "models/engines/linear_l.mdl"
	Gear1LDL.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear1LDL.category = "Differential"
	Gear1LDL.weight = Gear1LW
	Gear1LDL.switch = 0.6
	Gear1LDL.maxtq = GearLMT
	Gear1LDL.gears = 1
	Gear1LDL.doubleclutch = true
	Gear1LDL.geartable = {}
		Gear1LDL.geartable[-1] = 1
		Gear1LDL.geartable[0] = 0
		Gear1LDL.geartable[1] = 0.5
	if ( CLIENT ) then
		Gear1LDL.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear1LDL.guiupdate = function() return end
	end
MobilityTable["1Gear-LD-L"] = Gear1LDL

-- 4 speed normal gearboxes
local Gear4TS = {}
	Gear4TS.id = "4Gear-T-S"
	Gear4TS.ent = "acf_gearbox"
	Gear4TS.type = "Mobility"
	Gear4TS.name = "4-Speed, Transaxial, Small"
	Gear4TS.desc = "A small, and light 4 speed gearbox, with a somewhat limited max torque rating\n\nThe Final Drive slider is a multiplier applied to all the other gear ratios"
	Gear4TS.model = "models/engines/transaxial_s.mdl"
	Gear4TS.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear4TS.category = "4-Speed"
	Gear4TS.weight = Gear4SW
	Gear4TS.switch = 0.3
	Gear4TS.maxtq = GearSMT
	Gear4TS.gears = 4
	Gear4TS.doubleclutch = false
	Gear4TS.geartable = {}
		Gear4TS.geartable[-1] = 0.5
		Gear4TS.geartable[0] = 0
		Gear4TS.geartable[1] = 0.1
		Gear4TS.geartable[2] = 0.2
		Gear4TS.geartable[3] = 0.3
		Gear4TS.geartable[4] = -0.1
	if ( CLIENT ) then
		Gear4TS.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear4TS.guiupdate = function() return end
	end
MobilityTable["4Gear-T-S"] = Gear4TS

local Gear4TM = {}
	Gear4TM.id = "4Gear-T-M"
	Gear4TM.ent = "acf_gearbox"
	Gear4TM.type = "Mobility"
	Gear4TM.name = "4-Speed, Transaxial, Medium"
	Gear4TM.desc = "A medium sized, 4 speed gearbox"
	Gear4TM.model = "models/engines/transaxial_m.mdl"
	Gear4TM.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear4TM.category = "4-Speed"
	Gear4TM.weight = Gear4MW
	Gear4TM.switch = 0.4
	Gear4TM.maxtq = GearMMT
	Gear4TM.gears = 4
	Gear4TM.doubleclutch = false
	Gear4TM.geartable = {}
		Gear4TM.geartable[-1] = 0.5
		Gear4TM.geartable[0] = 0
		Gear4TM.geartable[1] = 0.1
		Gear4TM.geartable[2] = 0.2
		Gear4TM.geartable[3] = 0.3
		Gear4TM.geartable[4] = -0.1
	if ( CLIENT ) then
		Gear4TM.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear4TM.guiupdate = function() return end
	end
MobilityTable["4Gear-T-M"] = Gear4TM

local Gear4TL = {}
	Gear4TL.id = "4Gear-T-L"
	Gear4TL.ent = "acf_gearbox"
	Gear4TL.type = "Mobility"
	Gear4TL.name = "4-Speed, Transaxial, Large"
	Gear4TL.desc = "A large, heavy and sturdy 4 speed gearbox"
	Gear4TL.model = "models/engines/transaxial_l.mdl"
	Gear4TL.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear4TL.category = "4-Speed"
	Gear4TL.weight = Gear4LW
	Gear4TL.switch = 0.6
	Gear4TL.maxtq = GearLMT
	Gear4TL.gears = 4
	Gear4TL.doubleclutch = false
	Gear4TL.geartable = {}
		Gear4TL.geartable[-1] = 1
		Gear4TL.geartable[0] = 0
		Gear4TL.geartable[1] = 0.1
		Gear4TL.geartable[2] = 0.2
		Gear4TL.geartable[3] = 0.3
		Gear4TL.geartable[4] = -0.1
	if ( CLIENT ) then
		Gear4TL.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear4TL.guiupdate = function() return end
	end
MobilityTable["4Gear-T-L"] = Gear4TL




-- 4 speed dual clutch gearboxes
local Gear4TDS = {}
	Gear4TDS.id = "4Gear-TD-S"
	Gear4TDS.ent = "acf_gearbox"
	Gear4TDS.type = "Mobility"
	Gear4TDS.name = "4-Speed, Transaxial Dual Clutch, Small"
	Gear4TDS.desc = "A small, and light 4 speed gearbox, with a somewhat limited max torque rating. The dual clutch allows you to apply power and brake each side independently\n\nThe Final Drive slider is a multiplier applied to all the other gear ratios"
	Gear4TDS.model = "models/engines/transaxial_s.mdl"
	Gear4TDS.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear4TDS.category = "4-Speed"
	Gear4TDS.weight = Gear4SW
	Gear4TDS.switch = 0.3
	Gear4TDS.maxtq = GearSMT
	Gear4TDS.gears = 4
	Gear4TDS.doubleclutch = true
	Gear4TDS.geartable = {}
		Gear4TDS.geartable[-1] = 0.5
		Gear4TDS.geartable[0] = 0
		Gear4TDS.geartable[1] = 0.1
		Gear4TDS.geartable[2] = 0.2
		Gear4TDS.geartable[3] = 0.3
		Gear4TDS.geartable[4] = -0.1
	if ( CLIENT ) then
		Gear4TDS.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear4TDS.guiupdate = function() return end
	end
MobilityTable["4Gear-TD-S"] = Gear4TDS

local Gear4TDM = {}
	Gear4TDM.id = "4Gear-TD-M"
	Gear4TDM.ent = "acf_gearbox"
	Gear4TDM.type = "Mobility"
	Gear4TDM.name = "4-Speed, Transaxial Dual Clutch, Medium"
	Gear4TDM.desc = "A medium sized, 4 speed gearbox. The dual clutch allows you to apply power and brake each side independently"
	Gear4TDM.model = "models/engines/transaxial_m.mdl"
	Gear4TDM.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear4TDM.category = "4-Speed"
	Gear4TDM.weight = Gear4MW
	Gear4TDM.switch = 0.4
	Gear4TDM.maxtq = GearMMT
	Gear4TDM.gears = 4
	Gear4TDM.doubleclutch = true
	Gear4TDM.geartable = {}
		Gear4TDM.geartable[-1] = 0.5
		Gear4TDM.geartable[0] = 0
		Gear4TDM.geartable[1] = 0.1
		Gear4TDM.geartable[2] = 0.2
		Gear4TDM.geartable[3] = 0.3
		Gear4TDM.geartable[4] = -0.1
	if ( CLIENT ) then
		Gear4TDM.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear4TDM.guiupdate = function() return end
	end
MobilityTable["4Gear-TD-M"] = Gear4TDM

local Gear4TDL = {}
	Gear4TDL.id = "4Gear-TD-L"
	Gear4TDL.ent = "acf_gearbox"
	Gear4TDL.type = "Mobility"
	Gear4TDL.name = "4-Speed, Transaxial Dual Clutch, Large"
	Gear4TDL.desc = "A large, heavy and sturdy 4 speed gearbox. The dual clutch allows you to apply power and brake each side independently"
	Gear4TDL.model = "models/engines/transaxial_l.mdl"
	Gear4TDL.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear4TDL.category = "4-Speed"
	Gear4TDL.weight = Gear4LW
	Gear4TDL.switch = 0.6
	Gear4TDL.maxtq = GearLMT
	Gear4TDL.gears = 4
	Gear4TDL.doubleclutch = true
	Gear4TDL.geartable = {}
		Gear4TDL.geartable[-1] = 1
		Gear4TDL.geartable[0] = 0
		Gear4TDL.geartable[1] = 0.1
		Gear4TDL.geartable[2] = 0.2
		Gear4TDL.geartable[3] = 0.3
		Gear4TDL.geartable[4] = -0.1
	if ( CLIENT ) then
		Gear4TDL.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear4TDL.guiupdate = function() return end
	end
MobilityTable["4Gear-TD-L"] = Gear4TDL




-- 6 speed normal gearboxes
local Gear6TS = {}
	Gear6TS.id = "6Gear-T-S"
	Gear6TS.ent = "acf_gearbox"
	Gear6TS.type = "Mobility"
	Gear6TS.name = "6-Speed, Transaxial, Small"
	Gear6TS.desc = "A small and light 6 speed gearbox, with a limited max torque rating."
	Gear6TS.model = "models/engines/transaxial_s.mdl"
	Gear6TS.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear6TS.category = "6-Speed"
	Gear6TS.weight = Gear6SW
	Gear6TS.switch = 0.3
	Gear6TS.maxtq = GearSMT
	Gear6TS.gears = 6
	Gear6TS.doubleclutch = false
	Gear6TS.geartable = {}
		Gear6TS.geartable[-1] = 0.5
		Gear6TS.geartable[0] = 0
		Gear6TS.geartable[1] = 0.1
		Gear6TS.geartable[2] = 0.2
		Gear6TS.geartable[3] = 0.3
		Gear6TS.geartable[4] = 0.4
		Gear6TS.geartable[5] = 0.5
		Gear6TS.geartable[6] = -0.1
	if ( CLIENT ) then
		Gear6TS.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear6TS.guiupdate = function() return end
	end
MobilityTable["6Gear-T-S"] = Gear6TS

local Gear6TM = {}
	Gear6TM.id = "6Gear-T-M"
	Gear6TM.ent = "acf_gearbox"
	Gear6TM.type = "Mobility"
	Gear6TM.name = "6-Speed, Transaxial, Medium"
	Gear6TM.desc = "A medium duty 6 speed gearbox with a limited torque rating."
	Gear6TM.model = "models/engines/transaxial_m.mdl"
	Gear6TM.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear6TM.category = "6-Speed"
	Gear6TM.weight = Gear6MW
	Gear6TM.switch = 0.4
	Gear6TM.maxtq = GearMMT
	Gear6TM.gears = 6
	Gear6TM.doubleclutch = false
	Gear6TM.geartable = {}
		Gear6TM.geartable[-1] = 0.5
		Gear6TM.geartable[0] = 0
		Gear6TM.geartable[1] = 0.1
		Gear6TM.geartable[2] = 0.2
		Gear6TM.geartable[3] = 0.3
		Gear6TM.geartable[4] = 0.4
		Gear6TM.geartable[5] = 0.5
		Gear6TM.geartable[6] = -0.1
	if ( CLIENT ) then
		Gear6TM.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear6TM.guiupdate = function() return end
	end
MobilityTable["6Gear-T-M"] = Gear6TM

local Gear6TL = {}
	Gear6TL.id = "6Gear-T-L"
	Gear6TL.ent = "acf_gearbox"
	Gear6TL.type = "Mobility"
	Gear6TL.name = "6-Speed, Transaxial, Large"
	Gear6TL.desc = "Heavy duty 6 speed gearbox, however not as resilient as a 4 speed."
	Gear6TL.model = "models/engines/transaxial_l.mdl"
	Gear6TL.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear6TL.category = "6-Speed"
	Gear6TL.weight = Gear6LW
	Gear6TL.switch = 0.6
	Gear6TL.maxtq = GearLMT
	Gear6TL.gears = 6
	Gear6TL.doubleclutch = false
	Gear6TL.geartable = {}
		Gear6TL.geartable[-1] = 1
		Gear6TL.geartable[0] = 0
		Gear6TL.geartable[1] = 0.1
		Gear6TL.geartable[2] = 0.2
		Gear6TL.geartable[3] = 0.3
		Gear6TL.geartable[4] = 0.4
		Gear6TL.geartable[5] = 0.5
		Gear6TL.geartable[6] = -0.1
	if ( CLIENT ) then
		Gear6TL.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear6TL.guiupdate = function() return end
	end
MobilityTable["6Gear-T-L"] = Gear6TL




-- 6 speed dual clutch gearboxes
local Gear6TDS = {}
	Gear6TDS.id = "6Gear-TD-S"
	Gear6TDS.ent = "acf_gearbox"
	Gear6TDS.type = "Mobility"
	Gear6TDS.name = "6-Speed, Transaxial Dual Clutch, Small"
	Gear6TDS.desc = "A small and light 6 speed gearbox, with a limited max torque rating. The dual clutch allows you to apply power and brake each side independently\n\nThe Final Drive slider is a multiplier applied to all the other gear ratios"
	Gear6TDS.model = "models/engines/transaxial_s.mdl"
	Gear6TDS.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear6TDS.category = "6-Speed"
	Gear6TDS.weight = Gear6SW
	Gear6TDS.switch = 0.3
	Gear6TDS.maxtq = GearSMT
	Gear6TDS.gears = 6
	Gear6TDS.doubleclutch = true
	Gear6TDS.geartable = {}
		Gear6TDS.geartable[-1] = 0.5
		Gear6TDS.geartable[0] = 0
		Gear6TDS.geartable[1] = 0.1
		Gear6TDS.geartable[2] = 0.2
		Gear6TDS.geartable[3] = 0.3
		Gear6TDS.geartable[4] = 0.4
		Gear6TDS.geartable[5] = 0.5
		Gear6TDS.geartable[6] = -0.1
	if ( CLIENT ) then
		Gear6TDS.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear6TDS.guiupdate = function() return end
	end
MobilityTable["6Gear-TD-S"] = Gear6TDS

local Gear6TDM = {}
	Gear6TDM.id = "6Gear-TD-M"
	Gear6TDM.ent = "acf_gearbox"
	Gear6TDM.type = "Mobility"
	Gear6TDM.name = "6-Speed, Transaxial Dual Clutch, Medium"
	Gear6TDM.desc = "A a medium duty 6 speed gearbox. The added gears reduce torque capacity substantially. The dual clutch allows you to apply power and brake each side independently\n\nThe Final Drive slider is a multiplier applied to all the other gear ratios"
	Gear6TDM.model = "models/engines/transaxial_m.mdl"
	Gear6TDM.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear6TDM.category = "6-Speed"
	Gear6TDM.weight = Gear6MW
	Gear6TDM.switch = 0.4
	Gear6TDM.maxtq = GearMMT
	Gear6TDM.gears = 6
	Gear6TDM.doubleclutch = true
	Gear6TDM.geartable = {}
		Gear6TDM.geartable[-1] = 0.5
		Gear6TDM.geartable[0] = 0
		Gear6TDM.geartable[1] = 0.1
		Gear6TDM.geartable[2] = 0.2
		Gear6TDM.geartable[3] = 0.3
		Gear6TDM.geartable[4] = 0.4
		Gear6TDM.geartable[5] = 0.5
		Gear6TDM.geartable[6] = -0.1
	if ( CLIENT ) then
		Gear6TDM.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear6TDM.guiupdate = function() return end
	end
MobilityTable["6Gear-TD-M"] = Gear6TDM

local Gear6TDL = {}
	Gear6TDL.id = "6Gear-TD-L"
	Gear6TDL.ent = "acf_gearbox"
	Gear6TDL.type = "Mobility"
	Gear6TDL.name = "6-Speed, Transaxial Dual Clutch, Large"
	Gear6TDL.desc = "Heavy duty 6 speed gearbox, however not as resilient as a 4 speed. The dual clutch allows you to apply power and brake each side independently\n\nThe Final Drive slider is a multiplier applied to all the other gear ratios"
	Gear6TDL.model = "models/engines/transaxial_l.mdl"
	Gear6TDL.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear6TDL.category = "6-Speed"
	Gear6TDL.weight = Gear6LW
	Gear6TDL.switch = 0.6
	Gear6TDL.maxtq = GearLMT
	Gear6TDL.gears = 6
	Gear6TDL.doubleclutch = true
	Gear6TDL.geartable = {}
		Gear6TDL.geartable[-1] = 1
		Gear6TDL.geartable[0] = 0
		Gear6TDL.geartable[1] = 0.1
		Gear6TDL.geartable[2] = 0.2
		Gear6TDL.geartable[3] = 0.3
		Gear6TDL.geartable[4] = 0.4
		Gear6TDL.geartable[5] = 0.5
		Gear6TDL.geartable[6] = -0.1
	if ( CLIENT ) then
		Gear6TDL.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear6TDL.guiupdate = function() return end
	end
MobilityTable["6Gear-TD-L"] = Gear6TDL

--8 speed gearboxes normal

local Gear8TS = {}
	Gear8TS.id = "8Gear-T-S"
	Gear8TS.ent = "acf_gearbox"
	Gear8TS.type = "Mobility"
	Gear8TS.name = "8-Speed, Transaxial, Small"
	Gear8TS.desc = "A small and light 8 speed gearbox.."
	Gear8TS.model = "models/engines/transaxial_s.mdl"
	Gear8TS.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear8TS.category = "8-Speed"
	Gear8TS.weight = Gear8SW
	Gear8TS.switch = 0.3
	Gear8TS.maxtq = GearSMT
	Gear8TS.gears = 8
	Gear8TS.doubleclutch = false
	Gear8TS.geartable = {}
		Gear8TS.geartable[-1] = 0.5
		Gear8TS.geartable[0] = 0
		Gear8TS.geartable[1] = 0.1
		Gear8TS.geartable[2] = 0.2
		Gear8TS.geartable[3] = 0.3
		Gear8TS.geartable[4] = 0.4
		Gear8TS.geartable[5] = 0.5
		Gear8TS.geartable[6] = 0.6
		Gear8TS.geartable[7] = 0.7
		Gear8TS.geartable[8] = -0.1
	if ( CLIENT ) then
		Gear8TS.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear8TS.guiupdate = function() return end
	end
MobilityTable["8Gear-T-S"] = Gear8TS

local Gear8TM = {}
	Gear8TM.id = "8Gear-T-M"
	Gear8TM.ent = "acf_gearbox"
	Gear8TM.type = "Mobility"
	Gear8TM.name = "8-Speed, Transaxial, Medium"
	Gear8TM.desc = "A medium duty 8 speed gearbox.."
	Gear8TM.model = "models/engines/transaxial_m.mdl"
	Gear8TM.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear8TM.category = "8-Speed"
	Gear8TM.weight = Gear8MW
	Gear8TM.switch = 0.4
	Gear8TM.maxtq = GearMMT
	Gear8TM.gears = 8
	Gear8TM.doubleclutch = false
	Gear8TM.geartable = {}
		Gear8TM.geartable[-1] = 0.5
		Gear8TM.geartable[0] = 0
		Gear8TM.geartable[1] = 0.1
		Gear8TM.geartable[2] = 0.2
		Gear8TM.geartable[3] = 0.3
		Gear8TM.geartable[4] = 0.4
		Gear8TM.geartable[5] = 0.5
		Gear8TM.geartable[6] = 0.6
		Gear8TM.geartable[7] = 0.7
		Gear8TM.geartable[8] = -0.1
	if ( CLIENT ) then
		Gear8TM.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear8TM.guiupdate = function() return end
	end
MobilityTable["8Gear-T-M"] = Gear8TM

local Gear8TL = {}
	Gear8TL.id = "8Gear-T-L"
	Gear8TL.ent = "acf_gearbox"
	Gear8TL.type = "Mobility"
	Gear8TL.name = "8-Speed, Transaxial, Large"
	Gear8TL.desc = "Heavy duty 8 speed gearbox, however rather heavy."
	Gear8TL.model = "models/engines/transaxial_l.mdl"
	Gear8TL.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear8TL.category = "8-Speed"
	Gear8TL.weight = Gear8LW
	Gear8TL.switch = 0.6
	Gear8TL.maxtq = GearLMT
	Gear8TL.gears = 8
	Gear8TL.doubleclutch = false
	Gear8TL.geartable = {}
		Gear8TL.geartable[-1] = 1
		Gear8TL.geartable[0] = 0
		Gear8TL.geartable[1] = 0.1
		Gear8TL.geartable[2] = 0.2
		Gear8TL.geartable[3] = 0.3
		Gear8TL.geartable[4] = 0.4
		Gear8TL.geartable[5] = 0.5
		Gear8TL.geartable[6] = 0.6
		Gear8TL.geartable[7] = 0.7
		Gear8TL.geartable[8] = -0.1
	if ( CLIENT ) then
		Gear8TL.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear8TL.guiupdate = function() return end
	end
MobilityTable["8Gear-T-L"] = Gear8TL

--8 speed gearboxes inline

local Gear8LS = {}
	Gear8LS.id = "8Gear-L-S"
	Gear8LS.ent = "acf_gearbox"
	Gear8LS.type = "Mobility"
	Gear8LS.name = "8-Speed, Inline, Small"
	Gear8LS.desc = "A small and light 8 speed gearbox."
	Gear8LS.model = "models/engines/linear_s.mdl"
	Gear8LS.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear8LS.category = "8-Speed"
	Gear8LS.weight = Gear8SW
	Gear8LS.switch = 0.3
	Gear8LS.maxtq = GearSMT
	Gear8LS.gears = 8
	Gear8LS.doubleclutch = false
	Gear8LS.geartable = {}
		Gear8LS.geartable[-1] = 0.5
		Gear8LS.geartable[0] = 0
		Gear8LS.geartable[1] = 0.1
		Gear8LS.geartable[2] = 0.2
		Gear8LS.geartable[3] = 0.3
		Gear8LS.geartable[4] = 0.4
		Gear8LS.geartable[5] = 0.5
		Gear8LS.geartable[6] = 0.6
		Gear8LS.geartable[7] = 0.7
		Gear8LS.geartable[8] = -0.1
	if ( CLIENT ) then
		Gear8LS.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear8LS.guiupdate = function() return end
	end
MobilityTable["8Gear-L-S"] = Gear8LS

local Gear8LM = {}
	Gear8LM.id = "8Gear-L-M"
	Gear8LM.ent = "acf_gearbox"
	Gear8LM.type = "Mobility"
	Gear8LM.name = "8-Speed, Inline, Medium"
	Gear8LM.desc = "A medium duty 8 speed gearbox.."
	Gear8LM.model = "models/engines/linear_m.mdl"
	Gear8LM.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear8LM.category = "8-Speed"
	Gear8LM.weight = Gear8MW
	Gear8LM.switch = 0.4
	Gear8LM.maxtq = GearMMT
	Gear8LM.gears = 8
	Gear8LM.doubleclutch = false
	Gear8LM.geartable = {}
		Gear8LM.geartable[-1] = 0.5
		Gear8LM.geartable[0] = 0
		Gear8LM.geartable[1] = 0.1
		Gear8LM.geartable[2] = 0.2
		Gear8LM.geartable[3] = 0.3
		Gear8LM.geartable[4] = 0.4
		Gear8LM.geartable[5] = 0.5
		Gear8LM.geartable[6] = 0.6
		Gear8LM.geartable[7] = 0.7
		Gear8LM.geartable[8] = -0.1
	if ( CLIENT ) then
		Gear8LM.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear8LM.guiupdate = function() return end
	end
MobilityTable["8Gear-L-M"] = Gear8LM

local Gear8LL = {}
	Gear8LL.id = "8Gear-L-L"
	Gear8LL.ent = "acf_gearbox"
	Gear8LL.type = "Mobility"
	Gear8LL.name = "8-Speed, Inline, Large"
	Gear8LL.desc = "Heavy duty 8 speed gearbox, however rather heavy."
	Gear8LL.model = "models/engines/linear_l.mdl"
	Gear8LL.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear8LL.category = "8-Speed"
	Gear8LL.weight = Gear8LW
	Gear8LL.switch = 0.6
	Gear8LL.maxtq = GearLMT
	Gear8LL.gears = 8
	Gear8LL.doubleclutch = false
	Gear8LL.geartable = {}
		Gear8LL.geartable[-1] = 1
		Gear8LL.geartable[0] = 0
		Gear8LL.geartable[1] = 0.1
		Gear8LL.geartable[2] = 0.2
		Gear8LL.geartable[3] = 0.3
		Gear8LL.geartable[4] = 0.4
		Gear8LL.geartable[5] = 0.5
		Gear8LL.geartable[6] = 0.6
		Gear8LL.geartable[7] = 0.7
		Gear8LL.geartable[8] = -0.1
	if ( CLIENT ) then
		Gear8LL.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear8LL.guiupdate = function() return end
	end
MobilityTable["8Gear-L-L"] = Gear8LL




-- 8 speed dual clutch gearboxes transaxial
local Gear8TDS = {}
	Gear8TDS.id = "8Gear-TD-S"
	Gear8TDS.ent = "acf_gearbox"
	Gear8TDS.type = "Mobility"
	Gear8TDS.name = "8-Speed, Transaxial Dual Clutch, Small"
	Gear8TDS.desc = "A small and light 8 speed gearbox The dual clutch allows you to apply power and brake each side independently\n\nThe Final Drive slider is a multiplier applied to all the other gear ratios"
	Gear8TDS.model = "models/engines/transaxial_s.mdl"
	Gear8TDS.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear8TDS.category = "8-Speed"
	Gear8TDS.weight = Gear8SW
	Gear8TDS.switch = 0.3
	Gear8TDS.maxtq = GearSMT
	Gear8TDS.gears = 8
	Gear8TDS.doubleclutch = true
	Gear8TDS.geartable = {}
		Gear8TDS.geartable[-1] = 0.5
		Gear8TDS.geartable[0] = 0
		Gear8TDS.geartable[1] = 0.1
		Gear8TDS.geartable[2] = 0.2
		Gear8TDS.geartable[3] = 0.3
		Gear8TDS.geartable[4] = 0.4
		Gear8TDS.geartable[5] = 0.5
		Gear8TDS.geartable[6] = 0.6
		Gear8TDS.geartable[7] = 0.7
		Gear8TDS.geartable[8] = -0.1
	if ( CLIENT ) then
		Gear8TDS.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear8TDS.guiupdate = function() return end
	end
MobilityTable["8Gear-TD-S"] = Gear8TDS

local Gear8TDM = {}
	Gear8TDM.id = "8Gear-TD-M"
	Gear8TDM.ent = "acf_gearbox"
	Gear8TDM.type = "Mobility"
	Gear8TDM.name = "8-Speed, Transaxial Dual Clutch, Medium"
	Gear8TDM.desc = "A a medium duty 8 speed gearbox. The dual clutch allows you to apply power and brake each side independently\n\nThe Final Drive slider is a multiplier applied to all the other gear ratios"
	Gear8TDM.model = "models/engines/transaxial_m.mdl"
	Gear8TDM.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear8TDM.category = "8-Speed"
	Gear8TDM.weight = Gear8MW
	Gear8TDM.switch = 0.4
	Gear8TDM.maxtq = GearMMT
	Gear8TDM.gears = 8
	Gear8TDM.doubleclutch = true
	Gear8TDM.geartable = {}
		Gear8TDM.geartable[-1] = 0.5
		Gear8TDM.geartable[0] = 0
		Gear8TDM.geartable[1] = 0.1
		Gear8TDM.geartable[2] = 0.2
		Gear8TDM.geartable[3] = 0.3
		Gear8TDM.geartable[4] = 0.4
		Gear8TDM.geartable[5] = 0.5
		Gear8TDM.geartable[6] = 0.6
		Gear8TDM.geartable[7] = 0.7
		Gear8TDM.geartable[8] = -0.1
	if ( CLIENT ) then
		Gear8TDM.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear8TDM.guiupdate = function() return end
	end
MobilityTable["8Gear-TD-M"] = Gear8TDM

local Gear8TDL = {}
	Gear8TDL.id = "8Gear-TD-L"
	Gear8TDL.ent = "acf_gearbox"
	Gear8TDL.type = "Mobility"
	Gear8TDL.name = "8-Speed, Transaxial Dual Clutch, Large"
	Gear8TDL.desc = "Heavy duty 8 speed gearbox. The dual clutch allows you to apply power and brake each side independently\n\nThe Final Drive slider is a multiplier applied to all the other gear ratios"
	Gear8TDL.model = "models/engines/transaxial_l.mdl"
	Gear8TDL.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear8TDL.category = "8-Speed"
	Gear8TDL.weight = Gear8LW
	Gear8TDL.switch = 0.6
	Gear8TDL.maxtq = GearLMT
	Gear8TDL.gears = 8
	Gear8TDL.doubleclutch = true
	Gear8TDL.geartable = {}
		Gear8TDL.geartable[-1] = 1
		Gear8TDL.geartable[0] = 0
		Gear8TDL.geartable[1] = 0.1
		Gear8TDL.geartable[2] = 0.2
		Gear8TDL.geartable[3] = 0.3
		Gear8TDL.geartable[4] = 0.4
		Gear8TDL.geartable[5] = 0.5
		Gear8TDL.geartable[6] = 0.6
		Gear8TDL.geartable[7] = 0.7
		Gear8TDL.geartable[8] = -0.1
	if ( CLIENT ) then
		Gear8TDL.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear8TDL.guiupdate = function() return end
	end
MobilityTable["8Gear-TD-L"] = Gear8TDL

-- 8 speed dual clutch gearboxes inline
local Gear8LDS = {}
	Gear8LDS.id = "8Gear-LD-S"
	Gear8LDS.ent = "acf_gearbox"
	Gear8LDS.type = "Mobility"
	Gear8LDS.name = "8-Speed, Inline Dual Clutch, Small"
	Gear8LDS.desc = "A small and light 8 speed gearbox The dual clutch allows you to apply power and brake each side independently\n\nThe Final Drive slider is a multiplier applied to all the other gear ratios"
	Gear8LDS.model = "models/engines/linear_s.mdl"
	Gear8LDS.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear8LDS.category = "8-Speed"
	Gear8LDS.weight = Gear8SW
	Gear8LDS.switch = 0.3
	Gear8LDS.maxtq = GearSMT
	Gear8LDS.gears = 8
	Gear8LDS.doubleclutch = true
	Gear8LDS.geartable = {}
		Gear8LDS.geartable[-1] = 0.5
		Gear8LDS.geartable[0] = 0
		Gear8LDS.geartable[1] = 0.1
		Gear8LDS.geartable[2] = 0.2
		Gear8LDS.geartable[3] = 0.3
		Gear8LDS.geartable[4] = 0.4
		Gear8LDS.geartable[5] = 0.5
		Gear8LDS.geartable[6] = 0.6
		Gear8LDS.geartable[7] = 0.7
		Gear8LDS.geartable[8] = -0.1
	if ( CLIENT ) then
		Gear8LDS.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear8LDS.guiupdate = function() return end
	end
MobilityTable["8Gear-LD-S"] = Gear8LDS

local Gear8LDM = {}
	Gear8LDM.id = "8Gear-LD-M"
	Gear8LDM.ent = "acf_gearbox"
	Gear8LDM.type = "Mobility"
	Gear8LDM.name = "8-Speed, Inline Dual Clutch, Medium"
	Gear8LDM.desc = "A a medium duty 8 speed gearbox. The dual clutch allows you to apply power and brake each side independently\n\nThe Final Drive slider is a multiplier applied to all the other gear ratios"
	Gear8LDM.model = "models/engines/linear_m.mdl"
	Gear8LDM.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear8LDM.category = "8-Speed"
	Gear8LDM.weight = Gear8MW
	Gear8LDM.switch = 0.4
	Gear8LDM.maxtq = GearMMT
	Gear8LDM.gears = 8
	Gear8LDM.doubleclutch = true
	Gear8LDM.geartable = {}
		Gear8LDM.geartable[-1] = 0.5
		Gear8LDM.geartable[0] = 0
		Gear8LDM.geartable[1] = 0.1
		Gear8LDM.geartable[2] = 0.2
		Gear8LDM.geartable[3] = 0.3
		Gear8LDM.geartable[4] = 0.4
		Gear8LDM.geartable[5] = 0.5
		Gear8LDM.geartable[6] = 0.6
		Gear8LDM.geartable[7] = 0.7
		Gear8LDM.geartable[8] = -0.1
	if ( CLIENT ) then
		Gear8LDM.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear8LDM.guiupdate = function() return end
	end
MobilityTable["8Gear-LD-M"] = Gear8LDM

local Gear8LDL = {}
	Gear8LDL.id = "8Gear-LD-L"
	Gear8LDL.ent = "acf_gearbox"
	Gear8LDL.type = "Mobility"
	Gear8LDL.name = "8-Speed, Inline Dual Clutch, Large"
	Gear8LDL.desc = "Heavy duty 8 speed gearbox. The dual clutch allows you to apply power and brake each side independently\n\nThe Final Drive slider is a multiplier applied to all the other gear ratios"
	Gear8LDL.model = "models/engines/linear_l.mdl"
	Gear8LDL.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear8LDL.category = "8-Speed"
	Gear8LDL.weight = Gear8LW
	Gear8LDL.switch = 0.6
	Gear8LDL.maxtq = GearLMT
	Gear8LDL.gears = 8
	Gear8LDL.doubleclutch = true
	Gear8LDL.geartable = {}
		Gear8LDL.geartable[-1] = 1
		Gear8LDL.geartable[0] = 0
		Gear8LDL.geartable[1] = 0.1
		Gear8LDL.geartable[2] = 0.2
		Gear8LDL.geartable[3] = 0.3
		Gear8LDL.geartable[4] = 0.4
		Gear8LDL.geartable[5] = 0.5
		Gear8LDL.geartable[6] = 0.6
		Gear8LDL.geartable[7] = 0.7
		Gear8LDL.geartable[8] = -0.1
	if ( CLIENT ) then
		Gear8LDL.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear8LDL.guiupdate = function() return end
	end
MobilityTable["8Gear-LD-L"] = Gear8LDL

-- 6 speed dual clutch inline gearboxes
local Gear6LDS = {}
	Gear6LDS.id = "6Gear-LD-S"
	Gear6LDS.ent = "acf_gearbox"
	Gear6LDS.type = "Mobility"
	Gear6LDS.name = "6-Speed, Inline Dual Clutch, Small"
	Gear6LDS.desc = "A small and light 6 speed inline gearbox, with a limited max torque rating. The dual clutch allows you to apply power and brake each side independently\n\nThe Final Drive slider is a multiplier applied to all the other gear ratios"
	Gear6LDS.model = "models/engines/linear_s.mdl"
	Gear6LDS.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear6LDS.category = "6-Speed"
	Gear6LDS.weight = Gear6SW
	Gear6LDS.switch = 0.3
	Gear6LDS.maxtq = GearSMT
	Gear6LDS.gears = 6
	Gear6LDS.doubleclutch = true
	Gear6LDS.geartable = {}
		Gear6LDS.geartable[-1] = 0.5
		Gear6LDS.geartable[0] = 0
		Gear6LDS.geartable[1] = 0.1
		Gear6LDS.geartable[2] = 0.2
		Gear6LDS.geartable[3] = 0.3
		Gear6LDS.geartable[4] = 0.4
		Gear6LDS.geartable[5] = 0.5
		Gear6LDS.geartable[6] = -0.1
	if ( CLIENT ) then
		Gear6LDS.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear6LDS.guiupdate = function() return end
	end
MobilityTable["6Gear-LD-S"] = Gear6LDS

local Gear6LDM = {}
	Gear6LDM.id = "6Gear-LD-M"
	Gear6LDM.ent = "acf_gearbox"
	Gear6LDM.type = "Mobility"
	Gear6LDM.name = "6-Speed, Inline Dual Clutch, Medium"
	Gear6LDM.desc = "A a medium duty 6 speed inline gearbox. The added gears reduce torque capacity substantially. The dual clutch allows you to apply power and brake each side independently\n\nThe Final Drive slider is a multiplier applied to all the other gear ratios"
	Gear6LDM.model = "models/engines/linear_m.mdl"
	Gear6LDM.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear6LDM.category = "6-Speed"
	Gear6LDM.weight = Gear6MW
	Gear6LDM.switch = 0.4
	Gear6LDM.maxtq = GearMMT
	Gear6LDM.gears = 6
	Gear6LDM.doubleclutch = true
	Gear6LDM.geartable = {}
		Gear6LDM.geartable[-1] = 0.5
		Gear6LDM.geartable[0] = 0
		Gear6LDM.geartable[1] = 0.1
		Gear6LDM.geartable[2] = 0.2
		Gear6LDM.geartable[3] = 0.3
		Gear6LDM.geartable[4] = 0.4
		Gear6LDM.geartable[5] = 0.5
		Gear6LDM.geartable[6] = -0.1
	if ( CLIENT ) then
		Gear6LDM.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear6LDM.guiupdate = function() return end
	end
MobilityTable["6Gear-LD-M"] = Gear6LDM

local Gear6LDL = {}
	Gear6LDL.id = "6Gear-LD-L"
	Gear6LDL.ent = "acf_gearbox"
	Gear6LDL.type = "Mobility"
	Gear6LDL.name = "6-Speed, Inline Dual Clutch, Large"
	Gear6LDL.desc = "Heavy duty 6 speed inline gearbox, however not as resilient as a 4 speed. The dual clutch allows you to apply power and brake each side independently\n\nThe Final Drive slider is a multiplier applied to all the other gear ratios"
	Gear6LDL.model = "models/engines/linear_l.mdl"
	Gear6LDL.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear6LDL.category = "6-Speed"
	Gear6LDL.weight = Gear6LW
	Gear6LDL.switch = 0.6
	Gear6LDL.maxtq = GearLMT
	Gear6LDL.gears = 6
	Gear6LDL.doubleclutch = true
	Gear6LDL.geartable = {}
		Gear6LDL.geartable[-1] = 1
		Gear6LDL.geartable[0] = 0
		Gear6LDL.geartable[1] = 0.1
		Gear6LDL.geartable[2] = 0.2
		Gear6LDL.geartable[3] = 0.3
		Gear6LDL.geartable[4] = 0.4
		Gear6LDL.geartable[5] = 0.5
		Gear6LDL.geartable[6] = -0.1
	if ( CLIENT ) then
		Gear6LDL.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear6LDL.guiupdate = function() return end
	end
MobilityTable["6Gear-LD-L"] = Gear6LDL




-- 6 speed normal inline gearboxes
local Gear6LS = {}
	Gear6LS.id = "6Gear-L-S"
	Gear6LS.ent = "acf_gearbox"
	Gear6LS.type = "Mobility"
	Gear6LS.name = "6-Speed, Inline, Small"
	Gear6LS.desc = "A small and light 6 speed inline gearbox, with a limited max torque rating."
	Gear6LS.model = "models/engines/linear_s.mdl"
	Gear6LS.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear6LS.category = "6-Speed"
	Gear6LS.weight = Gear6SW
	Gear6LS.switch = 0.3
	Gear6LS.maxtq = GearSMT
	Gear6LS.gears = 6
	Gear6LS.doubleclutch = false
	Gear6LS.geartable = {}
		Gear6LS.geartable[-1] = 0.5
		Gear6LS.geartable[0] = 0
		Gear6LS.geartable[1] = 0.1
		Gear6LS.geartable[2] = 0.2
		Gear6LS.geartable[3] = 0.3
		Gear6LS.geartable[4] = 0.4
		Gear6LS.geartable[5] = 0.5
		Gear6LS.geartable[6] = -0.1
	if ( CLIENT ) then
		Gear6LS.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear6LS.guiupdate = function() return end
	end
MobilityTable["6Gear-L-S"] = Gear6LS

local Gear6LM = {}
	Gear6LM.id = "6Gear-L-M"
	Gear6LM.ent = "acf_gearbox"
	Gear6LM.type = "Mobility"
	Gear6LM.name = "6-Speed, Inline, Medium"
	Gear6LM.desc = "A medium duty 6 speed inline gearbox with a limited torque rating."
	Gear6LM.model = "models/engines/linear_m.mdl"
	Gear6LM.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear6LM.category = "6-Speed"
	Gear6LM.weight = Gear6MW
	Gear6LM.switch = 0.4
	Gear6LM.maxtq = GearMMT
	Gear6LM.gears = 6
	Gear6LM.doubleclutch = false
	Gear6LM.geartable = {}
		Gear6LM.geartable[-1] = 0.5
		Gear6LM.geartable[0] = 0
		Gear6LM.geartable[1] = 0.1
		Gear6LM.geartable[2] = 0.2
		Gear6LM.geartable[3] = 0.3
		Gear6LM.geartable[4] = 0.4
		Gear6LM.geartable[5] = 0.5
		Gear6LM.geartable[6] = -0.1
	if ( CLIENT ) then
		Gear6LM.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear6LM.guiupdate = function() return end
	end
MobilityTable["6Gear-L-M"] = Gear6LM

local Gear6LL = {}
	Gear6LL.id = "6Gear-L-L"
	Gear6LL.ent = "acf_gearbox"
	Gear6LL.type = "Mobility"
	Gear6LL.name = "6-Speed, Inline, Large"
	Gear6LL.desc = "Heavy duty 6 speed inline gearbox, however not as resilient as a 4 speed."
	Gear6LL.model = "models/engines/linear_l.mdl"
	Gear6LL.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear6LL.category = "6-Speed"
	Gear6LL.weight = Gear6LW
	Gear6LL.switch = 0.6
	Gear6LL.maxtq = GearLMT
	Gear6LL.gears = 6
	Gear6LL.doubleclutch = false
	Gear6LL.geartable = {}
		Gear6LL.geartable[-1] = 1
		Gear6LL.geartable[0] = 0
		Gear6LL.geartable[1] = 0.1
		Gear6LL.geartable[2] = 0.2
		Gear6LL.geartable[3] = 0.3
		Gear6LL.geartable[4] = 0.4
		Gear6LL.geartable[5] = 0.5
		Gear6LL.geartable[6] = -0.1
	if ( CLIENT ) then
		Gear6LL.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear6LL.guiupdate = function() return end
	end
MobilityTable["6Gear-L-L"] = Gear6LL






-- 4 speed normal inline gearboxes
local Gear4LS = {}
	Gear4LS.id = "4Gear-L-S"
	Gear4LS.ent = "acf_gearbox"
	Gear4LS.type = "Mobility"
	Gear4LS.name = "4-Speed, Inline, Small"
	Gear4LS.desc = "A small, and light 4 speed inline gearbox, with a somewhat limited max torque rating\n\nThe Final Drive slider is a multiplier applied to all the other gear ratios"
	Gear4LS.model = "models/engines/linear_s.mdl"
	Gear4LS.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear4LS.category = "4-Speed"
	Gear4LS.weight = Gear4SW
	Gear4LS.switch = 0.3
	Gear4LS.maxtq = GearSMT
	Gear4LS.gears = 4
	Gear4LS.doubleclutch = false
	Gear4LS.geartable = {}
		Gear4LS.geartable[-1] = 0.5
		Gear4LS.geartable[0] = 0
		Gear4LS.geartable[1] = 0.1
		Gear4LS.geartable[2] = 0.2
		Gear4LS.geartable[3] = 0.3
		Gear4LS.geartable[4] = -0.1
	if ( CLIENT ) then
		Gear4LS.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear4LS.guiupdate = function() return end
	end
MobilityTable["4Gear-L-S"] = Gear4LS

local Gear4LM = {}
	Gear4LM.id = "4Gear-L-M"
	Gear4LM.ent = "acf_gearbox"
	Gear4LM.type = "Mobility"
	Gear4LM.name = "4-Speed, Inline, Medium"
	Gear4LM.desc = "A medium sized, 4 speed inline gearbox"
	Gear4LM.model = "models/engines/linear_m.mdl"
	Gear4LM.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear4LM.category = "4-Speed"
	Gear4LM.weight = Gear4MW
	Gear4LM.switch = 0.4
	Gear4LM.maxtq = GearMMT
	Gear4LM.gears = 4
	Gear4LM.doubleclutch = false
	Gear4LM.geartable = {}
		Gear4LM.geartable[-1] = 0.5
		Gear4LM.geartable[0] = 0
		Gear4LM.geartable[1] = 0.1
		Gear4LM.geartable[2] = 0.2
		Gear4LM.geartable[3] = 0.3
		Gear4LM.geartable[4] = -0.1
	if ( CLIENT ) then
		Gear4LM.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear4LM.guiupdate = function() return end
	end
MobilityTable["4Gear-L-M"] = Gear4LM

local Gear4LL = {}
	Gear4LL.id = "4Gear-L-L"
	Gear4LL.ent = "acf_gearbox"
	Gear4LL.type = "Mobility"
	Gear4LL.name = "4-Speed, Inline, Large"
	Gear4LL.desc = "A large, heavy and sturdy 4 speed inline gearbox"
	Gear4LL.model = "models/engines/linear_l.mdl"
	Gear4LL.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear4LL.category = "4-Speed"
	Gear4LL.weight = Gear4LW
	Gear4LL.switch = 0.6
	Gear4LL.maxtq =  GearLMT
	Gear4LL.gears = 4
	Gear4LL.doubleclutch = false
	Gear4LL.geartable = {}
		Gear4LL.geartable[-1] = 1
		Gear4LL.geartable[0] = 0
		Gear4LL.geartable[1] = 0.1
		Gear4LL.geartable[2] = 0.2
		Gear4LL.geartable[3] = 0.3
		Gear4LL.geartable[4] = -0.1
	if ( CLIENT ) then
		Gear4LL.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear4LL.guiupdate = function() return end
	end
MobilityTable["4Gear-L-L"] = Gear4LL




-- 4 speed inline dual clutch gearboxes
local Gear4TLS = {}
	Gear4TLS.id = "4Gear-LD-S"
	Gear4TLS.ent = "acf_gearbox"
	Gear4TLS.type = "Mobility"
	Gear4TLS.name = "4-Speed, Inline Dual Clutch, Small"
	Gear4TLS.desc = "A small, and light 4 speed inline gearbox, with a somewhat limited max torque rating. The dual clutch allows you to apply power and brake each side independently\n\nThe Final Drive slider is a multiplier applied to all the other gear ratios"
	Gear4TLS.model = "models/engines/linear_s.mdl"
	Gear4TLS.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear4TLS.category = "4-Speed"
	Gear4TLS.weight = Gear4SW
	Gear4TLS.switch = 0.3
	Gear4TLS.maxtq = GearSMT
	Gear4TLS.gears = 4
	Gear4TLS.doubleclutch = true
	Gear4TLS.geartable = {}
		Gear4TLS.geartable[-1] = 0.5
		Gear4TLS.geartable[0] = 0
		Gear4TLS.geartable[1] = 0.1
		Gear4TLS.geartable[2] = 0.2
		Gear4TLS.geartable[3] = 0.3
		Gear4TLS.geartable[4] = -0.1
	if ( CLIENT ) then
		Gear4TLS.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear4TLS.guiupdate = function() return end
	end
MobilityTable["4Gear-LD-S"] = Gear4TLS

local Gear4TLM = {}
	Gear4TLM.id = "4Gear-LD-M"
	Gear4TLM.ent = "acf_gearbox"
	Gear4TLM.type = "Mobility"
	Gear4TLM.name = "4-Speed, Inline Dual Clutch, Medium"
	Gear4TLM.desc = "A medium sized, 4 speed inline gearbox. The dual clutch allows you to apply power and brake each side independently"
	Gear4TLM.model = "models/engines/linear_m.mdl"
	Gear4TLM.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear4TLM.category = "4-Speed"
	Gear4TLM.weight = Gear4MW
	Gear4TLM.switch = 0.4
	Gear4TLM.maxtq = GearMMT
	Gear4TLM.gears = 4
	Gear4TLM.doubleclutch = true
	Gear4TLM.geartable = {}
		Gear4TLM.geartable[-1] = 0.5
		Gear4TLM.geartable[0] = 0
		Gear4TLM.geartable[1] = 0.1
		Gear4TLM.geartable[2] = 0.2
		Gear4TLM.geartable[3] = 0.3
		Gear4TLM.geartable[4] = -0.1
	if ( CLIENT ) then
		Gear4TLM.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear4TLM.guiupdate = function() return end
	end
MobilityTable["4Gear-LD-M"] = Gear4TLM

local Gear4LDL = {}
	Gear4LDL.id = "4Gear-LD-L"
	Gear4LDL.ent = "acf_gearbox"
	Gear4LDL.type = "Mobility"
	Gear4LDL.name = "4-Speed, Inline Dual Clutch, Large"
	Gear4LDL.desc = "A large, heavy and sturdy 4 speed inline gearbox. The dual clutch allows you to apply power and brake each side independently"
	Gear4LDL.model = "models/engines/linear_l.mdl"
	Gear4LDL.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear4LDL.category = "4-Speed"
	Gear4LDL.weight = Gear4LW
	Gear4LDL.switch = 0.6
	Gear4LDL.maxtq = GearLMT
	Gear4LDL.gears = 4
	Gear4LDL.doubleclutch = true
	Gear4LDL.geartable = {}
		Gear4LDL.geartable[-1] = 1
		Gear4LDL.geartable[0] = 0
		Gear4LDL.geartable[1] = 0.1
		Gear4LDL.geartable[2] = 0.2
		Gear4LDL.geartable[3] = 0.3
		Gear4LDL.geartable[4] = -0.1
	if ( CLIENT ) then
		Gear4LDL.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear4LDL.guiupdate = function() return end
	end
MobilityTable["4Gear-LD-L"] = Gear4LDL




-- 6 speed normal inline gearboxes
local Gear6LS = {}
	Gear6LS.id = "6Gear-L-S"
	Gear6LS.ent = "acf_gearbox"
	Gear6LS.type = "Mobility"
	Gear6LS.name = "6-Speed, Inline, Small"
	Gear6LS.desc = "A small and light 6 speed inline gearbox, with a limited max torque rating."
	Gear6LS.model = "models/engines/linear_s.mdl"
	Gear6LS.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear6LS.category = "6-Speed"
	Gear6LS.weight = Gear6SW
	Gear6LS.switch = 0.3
	Gear6LS.maxtq = GearSMT
	Gear6LS.gears = 6
	Gear6LS.doubleclutch = false
	Gear6LS.geartable = {}
		Gear6LS.geartable[-1] = 0.5
		Gear6LS.geartable[0] = 0
		Gear6LS.geartable[1] = 0.1
		Gear6LS.geartable[2] = 0.2
		Gear6LS.geartable[3] = 0.3
		Gear6LS.geartable[4] = 0.4
		Gear6LS.geartable[5] = 0.5
		Gear6LS.geartable[6] = -0.1
	if ( CLIENT ) then
		Gear6LS.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear6LS.guiupdate = function() return end
	end
MobilityTable["6Gear-L-S"] = Gear6LS

local Gear6LM = {}
	Gear6LM.id = "6Gear-L-M"
	Gear6LM.ent = "acf_gearbox"
	Gear6LM.type = "Mobility"
	Gear6LM.name = "6-Speed, Inline, Medium"
	Gear6LM.desc = "A medium duty 6 speed inline gearbox with a limited torque rating."
	Gear6LM.model = "models/engines/linear_m.mdl"
	Gear6LM.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear6LM.category = "6-Speed"
	Gear6LM.weight = Gear6MW
	Gear6LM.switch = 0.4
	Gear6LM.maxtq = GearMMT
	Gear6LM.gears = 6
	Gear6LM.doubleclutch = false
	Gear6LM.geartable = {}
		Gear6LM.geartable[-1] = 0.5
		Gear6LM.geartable[0] = 0
		Gear6LM.geartable[1] = 0.1
		Gear6LM.geartable[2] = 0.2
		Gear6LM.geartable[3] = 0.3
		Gear6LM.geartable[4] = 0.4
		Gear6LM.geartable[5] = 0.5
		Gear6LM.geartable[6] = -0.1
	if ( CLIENT ) then
		Gear6LM.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear6LM.guiupdate = function() return end
	end
MobilityTable["6Gear-L-M"] = Gear6LM

local Gear6LL = {}
	Gear6LL.id = "6Gear-L-L"
	Gear6LL.ent = "acf_gearbox"
	Gear6LL.type = "Mobility"
	Gear6LL.name = "6-Speed, Inline, Large"
	Gear6LL.desc = "Heavy duty 6 speed inline gearbox, however not as resilient as a 4 speed."
	Gear6LL.model = "models/engines/linear_l.mdl"
	Gear6LL.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear6LL.category = "6-Speed"
	Gear6LL.weight = Gear6LW
	Gear6LL.switch = 0.6
	Gear6LL.maxtq = GearLMT
	Gear6LL.gears = 6
	Gear6LL.doubleclutch = false
	Gear6LL.geartable = {}
		Gear6LL.geartable[-1] = 1
		Gear6LL.geartable[0] = 0
		Gear6LL.geartable[1] = 0.1
		Gear6LL.geartable[2] = 0.2
		Gear6LL.geartable[3] = 0.3
		Gear6LL.geartable[4] = 0.4
		Gear6LL.geartable[5] = 0.5
		Gear6LL.geartable[6] = -0.1
	if ( CLIENT ) then
		Gear6LL.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear6LL.guiupdate = function() return end
	end
MobilityTable["6Gear-L-L"] = Gear6LL





-- 6 speed dual clutch inline gearboxes
local Gear6LDS = {}
	Gear6LDS.id = "6Gear-LD-S"
	Gear6LDS.ent = "acf_gearbox"
	Gear6LDS.type = "Mobility"
	Gear6LDS.name = "6-Speed, Inline Dual Clutch, Small"
	Gear6LDS.desc = "A small and light 6 speed inline gearbox, with a limited max torque rating. The dual clutch allows you to apply power and brake each side independently\n\nThe Final Drive slider is a multiplier applied to all the other gear ratios"
	Gear6LDS.model = "models/engines/linear_s.mdl"
	Gear6LDS.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear6LDS.category = "6-Speed"
	Gear6LDS.weight = Gear6SW
	Gear6LDS.switch = 0.3
	Gear6LDS.maxtq = GearSMT
	Gear6LDS.gears = 6
	Gear6LDS.doubleclutch = true
	Gear6LDS.geartable = {}
		Gear6LDS.geartable[-1] = 0.5
		Gear6LDS.geartable[0] = 0
		Gear6LDS.geartable[1] = 0.1
		Gear6LDS.geartable[2] = 0.2
		Gear6LDS.geartable[3] = 0.3
		Gear6LDS.geartable[4] = 0.4
		Gear6LDS.geartable[5] = 0.5
		Gear6LDS.geartable[6] = -0.1
	if ( CLIENT ) then
		Gear6LDS.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear6LDS.guiupdate = function() return end
	end
MobilityTable["6Gear-LD-S"] = Gear6LDS

local Gear6LDM = {}
	Gear6LDM.id = "6Gear-LD-M"
	Gear6LDM.ent = "acf_gearbox"
	Gear6LDM.type = "Mobility"
	Gear6LDM.name = "6-Speed, Inline Dual Clutch, Medium"
	Gear6LDM.desc = "A a medium duty 6 speed inline gearbox. The added gears reduce torque capacity substantially. The dual clutch allows you to apply power and brake each side independently\n\nThe Final Drive slider is a multiplier applied to all the other gear ratios"
	Gear6LDM.model = "models/engines/linear_m.mdl"
	Gear6LDM.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear6LDM.category = "6-Speed"
	Gear6LDM.weight = Gear6MW
	Gear6LDM.switch = 0.4
	Gear6LDM.maxtq = GearMMT
	Gear6LDM.gears = 6
	Gear6LDM.doubleclutch = true
	Gear6LDM.geartable = {}
		Gear6LDM.geartable[-1] = 0.5
		Gear6LDM.geartable[0] = 0
		Gear6LDM.geartable[1] = 0.1
		Gear6LDM.geartable[2] = 0.2
		Gear6LDM.geartable[3] = 0.3
		Gear6LDM.geartable[4] = 0.4
		Gear6LDM.geartable[5] = 0.5
		Gear6LDM.geartable[6] = -0.1
	if ( CLIENT ) then
		Gear6LDM.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear6LDM.guiupdate = function() return end
	end
MobilityTable["6Gear-LD-M"] = Gear6LDM

local Gear6LDL = {}
	Gear6LDL.id = "6Gear-LD-L"
	Gear6LDL.ent = "acf_gearbox"
	Gear6LDL.type = "Mobility"
	Gear6LDL.name = "6-Speed, Inline Dual Clutch, Large"
	Gear6LDL.desc = "Heavy duty 6 speed inline gearbox, however not as resilient as a 4 speed. The dual clutch allows you to apply power and brake each side independently\n\nThe Final Drive slider is a multiplier applied to all the other gear ratios"
	Gear6LDL.model = "models/engines/linear_l.mdl"
	Gear6LDL.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear6LDL.category = "6-Speed"
	Gear6LDL.weight = Gear6LW
	Gear6LDL.switch = 0.6
	Gear6LDL.maxtq = GearLMT
	Gear6LDL.gears = 6
	Gear6LDL.doubleclutch = true
	Gear6LDL.geartable = {}
		Gear6LDL.geartable[-1] = 1
		Gear6LDL.geartable[0] = 0
		Gear6LDL.geartable[1] = 0.1
		Gear6LDL.geartable[2] = 0.2
		Gear6LDL.geartable[3] = 0.3
		Gear6LDL.geartable[4] = 0.4
		Gear6LDL.geartable[5] = 0.5
		Gear6LDL.geartable[6] = -0.1
	if ( CLIENT ) then
		Gear6LDL.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear6LDL.guiupdate = function() return end
	end
MobilityTable["6Gear-LD-L"] = Gear6LDL

--Straight through gearboxes
local Gear4STS = {}
	Gear4STS.id = "4Gear-ST-S"
	Gear4STS.ent = "acf_gearbox"
	Gear4STS.type = "Mobility"
	Gear4STS.name = "4-Speed, Straight, Small"
	Gear4STS.desc = "A small straight-through gearbox"
	Gear4STS.model = "models/engines/t5small.mdl"
	Gear4STS.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear4STS.category = "4-Speed"
	Gear4STS.weight = Gear4SW
	Gear4STS.switch = 0.3
	Gear4STS.maxtq =  GearSMT
	Gear4STS.gears = 4
	Gear4STS.doubleclutch = false
	Gear4STS.geartable = {}
		Gear4STS.geartable[-1] = 1
		Gear4STS.geartable[0] = 0
		Gear4STS.geartable[1] = 0.1
		Gear4STS.geartable[2] = 0.2
		Gear4STS.geartable[3] = 0.3
		Gear4STS.geartable[4] = -0.1
	if ( CLIENT ) then
		Gear4STS.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear4STS.guiupdate = function() return end
	end
MobilityTable["4Gear-ST-S"] = Gear4STS

local Gear4STM = {}
	Gear4STM.id = "4Gear-ST-M"
	Gear4STM.ent = "acf_gearbox"
	Gear4STM.type = "Mobility"
	Gear4STM.name = "4-Speed, Straight, Medium"
	Gear4STM.desc = "A medium sized, 4 speed straight-through gearbox."
	Gear4STM.model = "models/engines/t5med.mdl"
	Gear4STM.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear4STM.category = "4-Speed"
	Gear4STM.weight = Gear4MW
	Gear4STM.switch = 0.4
	Gear4STM.maxtq = GearMMT
	Gear4STM.gears = 4
	Gear4STM.doubleclutch = false
	Gear4STM.geartable = {}
		Gear4STM.geartable[-1] = 0.5
		Gear4STM.geartable[0] = 0
		Gear4STM.geartable[1] = 0.1
		Gear4STM.geartable[2] = 0.2
		Gear4STM.geartable[3] = 0.3
		Gear4STM.geartable[4] = -0.1
	if ( CLIENT ) then
		Gear4STM.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear4STM.guiupdate = function() return end
	end
MobilityTable["4Gear-ST-M"] = Gear4STM

local Gear4STL = {}
	Gear4STL.id = "4Gear-ST-L"
	Gear4STL.ent = "acf_gearbox"
	Gear4STL.type = "Mobility"
	Gear4STL.name = "4-Speed, Straight, Large"
	Gear4STL.desc = "A large sized, 4 speed straight-through gearbox."
	Gear4STL.model = "models/engines/t5large.mdl"
	Gear4STL.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear4STL.category = "4-Speed"
	Gear4STL.weight = Gear4LW
	Gear4STL.switch = 0.6
	Gear4STL.maxtq = GearLMT
	Gear4STL.gears = 4
	Gear4STL.doubleclutch = false
	Gear4STL.geartable = {}
		Gear4STL.geartable[-1] = 0.5
		Gear4STL.geartable[0] = 0
		Gear4STL.geartable[1] = 0.1
		Gear4STL.geartable[2] = 0.2
		Gear4STL.geartable[3] = 0.3
		Gear4STL.geartable[4] = -0.1
	if ( CLIENT ) then
		Gear4STL.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear4STL.guiupdate = function() return end
	end
MobilityTable["4Gear-ST-L"] = Gear4STL

local Gear6STS = {}
	Gear6STS.id = "6Gear-ST-S"
	Gear6STS.ent = "acf_gearbox"
	Gear6STS.type = "Mobility"
	Gear6STS.name = "6-Speed, Straight, Small"
	Gear6STS.desc = "A small and light 6 speed straight-through gearbox."
	Gear6STS.model = "models/engines/t5small.mdl"
	Gear6STS.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear6STS.category = "6-Speed"
	Gear6STS.weight = Gear6SW
	Gear6STS.switch = 0.3
	Gear6STS.maxtq = GearSMT
	Gear6STS.gears = 6
	Gear6STS.doubleclutch = false
	Gear6STS.geartable = {}
		Gear6STS.geartable[-1] = 0.5
		Gear6STS.geartable[0] = 0
		Gear6STS.geartable[1] = 0.1
		Gear6STS.geartable[2] = 0.2
		Gear6STS.geartable[3] = 0.3
		Gear6STS.geartable[4] = 0.4
		Gear6STS.geartable[5] = 0.5
		Gear6STS.geartable[6] = -0.1
	if ( CLIENT ) then
		Gear6STS.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear6STS.guiupdate = function() return end
	end
MobilityTable["6Gear-ST-S"] = Gear6STS

local Gear6STM = {}
	Gear6STM.id = "6Gear-ST-M"
	Gear6STM.ent = "acf_gearbox"
	Gear6STM.type = "Mobility"
	Gear6STM.name = "6-Speed, Straight, Medium"
	Gear6STM.desc = "A medium 6 speed straight-through gearbox."
	Gear6STM.model = "models/engines/t5med.mdl"
	Gear6STM.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear6STM.category = "6-Speed"
	Gear6STM.weight = Gear6MW
	Gear6STM.switch = 0.4
	Gear6STM.maxtq = GearMMT
	Gear6STM.gears = 6
	Gear6STM.doubleclutch = false
	Gear6STM.geartable = {}
		Gear6STM.geartable[-1] = 0.5
		Gear6STM.geartable[0] = 0
		Gear6STM.geartable[1] = 0.1
		Gear6STM.geartable[2] = 0.2
		Gear6STM.geartable[3] = 0.3
		Gear6STM.geartable[4] = 0.4
		Gear6STM.geartable[5] = 0.5
		Gear6STM.geartable[6] = -0.1
	if ( CLIENT ) then
		Gear6STM.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear6STM.guiupdate = function() return end
	end
MobilityTable["6Gear-ST-M"] = Gear6STM




local Gear6STL = {}
	Gear6STL.id = "6Gear-ST-L"
	Gear6STL.ent = "acf_gearbox"
	Gear6STL.type = "Mobility"
	Gear6STL.name = "6-Speed, Straight, Large"
	Gear6STL.desc = "A large 6 speed straight-through gearbox."
	Gear6STL.model = "models/engines/t5large.mdl"
	Gear6STL.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear6STL.category = "6-Speed"
	Gear6STL.weight = Gear6LW
	Gear6STL.switch = 0.6
	Gear6STL.maxtq = GearLMT
	Gear6STL.gears = 6
	Gear6STL.doubleclutch = false
	Gear6STL.geartable = {}
		Gear6STL.geartable[-1] = 0.5
		Gear6STL.geartable[0] = 0
		Gear6STL.geartable[1] = 0.1
		Gear6STL.geartable[2] = 0.2
		Gear6STL.geartable[3] = 0.3
		Gear6STL.geartable[4] = 0.4
		Gear6STL.geartable[5] = 0.5
		Gear6STL.geartable[6] = -0.1
	if ( CLIENT ) then
		Gear6STL.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear6STL.guiupdate = function() return end
	end
MobilityTable["6Gear-ST-L"] = Gear6STL

local Gear8STS = {}
	Gear8STS.id = "8Gear-ST-S"
	Gear8STS.ent = "acf_gearbox"
	Gear8STS.type = "Mobility"
	Gear8STS.name = "8-Speed, Straight, Small"
	Gear8STS.desc = "A small and light 8 speed straight-through gearbox."
	Gear8STS.model = "models/engines/t5small.mdl"
	Gear8STS.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear8STS.category = "8-Speed"
	Gear8STS.weight = Gear8SW
	Gear8STS.switch = 0.3
	Gear8STS.maxtq = GearSMT
	Gear8STS.gears = 8
	Gear8STS.doubleclutch = false
	Gear8STS.geartable = {}
		Gear8STS.geartable[-1] = 0.5
		Gear8STS.geartable[0] = 0
		Gear8STS.geartable[1] = 0.1
		Gear8STS.geartable[2] = 0.2
		Gear8STS.geartable[3] = 0.3
		Gear8STS.geartable[4] = 0.4
		Gear8STS.geartable[5] = 0.5
		Gear8STS.geartable[6] = 0.6
		Gear8STS.geartable[7] = 0.7
		Gear8STS.geartable[8] = 0.8
	if ( CLIENT ) then
		Gear8STS.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear8STS.guiupdate = function() return end
	end
MobilityTable["8Gear-ST-S"] = Gear8STS

local Gear8STM = {}
	Gear8STM.id = "8Gear-ST-M"
	Gear8STM.ent = "acf_gearbox"
	Gear8STM.type = "Mobility"
	Gear8STM.name = "8-Speed, Straight, Medium"
	Gear8STM.desc = "A medium 8 speed straight-through gearbox."
	Gear8STM.model = "models/engines/t5med.mdl"
	Gear8STM.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear8STM.category = "8-Speed"
	Gear8STM.weight = Gear8MW
	Gear8STM.switch = 0.4
	Gear8STM.maxtq = GearMMT
	Gear8STM.gears = 8
	Gear8STM.doubleclutch = false
	Gear8STM.geartable = {}
		Gear8STM.geartable[-1] = 0.5
		Gear8STM.geartable[0] = 0
		Gear8STM.geartable[1] = 0.1
		Gear8STM.geartable[2] = 0.2
		Gear8STM.geartable[3] = 0.3
		Gear8STM.geartable[4] = 0.4
		Gear8STM.geartable[5] = 0.5
		Gear8STM.geartable[6] = 0.6
		Gear8STM.geartable[7] = 0.7
		Gear8STM.geartable[8] = -0.1
	if ( CLIENT ) then
		Gear8STM.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear8STM.guiupdate = function() return end
	end
MobilityTable["8Gear-ST-M"] = Gear8STM




local Gear8STL = {}
	Gear8STL.id = "8Gear-ST-L"
	Gear8STL.ent = "acf_gearbox"
	Gear8STL.type = "Mobility"
	Gear8STL.name = "8-Speed, Straight, Large"
	Gear8STL.desc = "A large 8 speed straight-through gearbox."
	Gear8STL.model = "models/engines/t5large.mdl"
	Gear8STL.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear8STL.category = "8-Speed"
	Gear8STL.weight = Gear8LW
	Gear8STL.switch = 0.6
	Gear8STL.maxtq = GearLMT
	Gear8STL.gears = 8
	Gear8STL.doubleclutch = false
	Gear8STL.geartable = {}
		Gear8STL.geartable[-1] = 0.5
		Gear8STL.geartable[0] = 0
		Gear8STL.geartable[1] = 0.1
		Gear8STL.geartable[2] = 0.2
		Gear8STL.geartable[3] = 0.3
		Gear8STL.geartable[4] = 0.4
		Gear8STL.geartable[5] = 0.5
		Gear8STL.geartable[6] = 0.6
		Gear8STL.geartable[7] = 0.7
		Gear8STL.geartable[8] = -0.1
	if ( CLIENT ) then
		Gear8STL.guicreate = (function( Panel, Table ) ACFGearboxGUICreate( Table ) end or nil)
		Gear8STL.guiupdate = function() return end
	end
MobilityTable["8Gear-ST-L"] = Gear8STL



-- local Tracks = {}
	-- Tracks.id = "CarV8"
	-- Tracks.ent = "acf_engine"
	-- Tracks.type = "Mobility"
	-- Tracks.name = "Track"
	-- Tracks.desc = "Tank tracks"
	-- Tracks.model = "models/vehicle/vehicle_engine_block.mdl"
	-- Tracks.weight = 200
	-- if ( CLIENT ) then
		-- Tracks.guicreate = (function( Panel, Table ) ACFTrackGUICreate( Table ) end or nil)
		-- Tracks.guiupdate = function() return end
	-- end
-- MobilityTable["Tracks"] = Tracks

list.Set( "ACFEnts", "Mobility", MobilityTable )	--end mobility listing