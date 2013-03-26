ACF = {}
ACF.AmmoTypes = {}
ACF.MenuFunc = {}
ACF.AmmoBlacklist = {}
ACF.Version = 324 -- Make sure to change this as the version goes up or the update check is for nothing! -wrex
ACF.CurrentVersion = 0 -- just defining a variable, do not change
print("ACF Loaded")

ACF.Threshold = 150	--Health Divisor
ACF.PartialPenPenalty = 5 --Exponent for the damage penalty for partial penetration
ACF.PenAreaMod = 0.85
ACF.KinFudgeFactor = 2.1	--True kinetic would be 2, over that it's speed biaised, below it's mass biaised
ACF.KEtoRHA = 0.25		--Empirical conversion from (kinetic energy in KJ)/(Aera in Cm2) to RHA penetration
ACF.GroundtoRHA = 0.05		--How much mm of steel is a mm of ground worth (Real soil is about 0.15
ACF.KEtoSpall = 1
ACF.AmmoMod = 1			-- Ammo modifier. 1 is 1x the amount of ammo
ACF.ArmorMod = 1
ACF.Spalling = 0

ACF.HEPower = 6000		--HE Filler power per KG in KJ
ACF.HEDensity = 1.65	--HE Filler density (That's TNT density)
ACF.HEFrag = 1500		--Mean fragment number for equal weight TNT and casing
ACF.HEBlastPen = 0.4	--Blast penetration exponent based of HE power

ACF.HEATMVScale = 0.73	--Filler KE to HEAT slug KE conversion expotential

ACF.DragDiv = 40		--Drag fudge factor
ACF.VelScale = 1		--Scale factor for the shell velocities in the game world
-- local PhysEnv = physenv.GetPerformanceSettings()
ACF.PhysMaxVel = 4000

ACF.PBase = 1050		--1KG of propellant produces this much KE at the muzzle, in kj
ACF.PScale = 1	--Gun Propellant power expotential
ACF.MVScale = 0.5  --Propellant to MV convertion expotential
ACF.PDensity = 1.6	--Gun propellant density (Real powders go from 0.7 to 1.6, i'm using higher densities to simulate case bottlenecking)

ACF.Year = 1945

CreateConVar('sbox_max_acf_gun', 12)
CreateConVar('sbox_max_acf_ammo', 32)
CreateConVar('sbox_max_acf_misc', 32)

AddCSLuaFile( "acf_globals.lua" )
AddCSLuaFile( "acf/client/cl_acfballistics.lua" )
AddCSLuaFile( "acf/client/cl_acfmenu_gui.lua" )

AddCSLuaFile( "acf/client/cl_acfballistics.lua" )
AddCSLuaFile( "acf/client/cl_acfmenu_gui.lua" )

if (SERVER) then

	include("acf/server/sv_acfbase.lua")
	include("acf/server/sv_acfdamage.lua")
	include("acf/server/sv_acfballistics.lua")
	
	resource.AddFile( "materials/HUD/killicons/acf_AC.vtf" )
	resource.AddFile( "materials/HUD/killicons/acf_AC.vmt" )
	resource.AddFile( "materials/HUD/killicons/acf_AL.vtf" )
	resource.AddFile( "materials/HUD/killicons/acf_AL.vmt" )
	resource.AddFile( "materials/HUD/killicons/acf_C.vtf" )
	resource.AddFile( "materials/HUD/killicons/acf_C.vmt" )
	resource.AddFile( "materials/HUD/killicons/acf_GL.vtf" )
	resource.AddFile( "materials/HUD/killicons/acf_GL.vmt" )
	resource.AddFile( "materials/HUD/killicons/acf_HMG.vtf" )
	resource.AddFile( "materials/HUD/killicons/acf_HMG.vmt" )
	resource.AddFile( "materials/HUD/killicons/acf_HW.vtf" )
	resource.AddFile( "materials/HUD/killicons/acf_HW.vmt" )
	resource.AddFile( "materials/HUD/killicons/acf_MG.vtf" )
	resource.AddFile( "materials/HUD/killicons/acf_MG.vmt" )
	resource.AddFile( "materials/HUD/killicons/acf_MO.vtf" )
	resource.AddFile( "materials/HUD/killicons/acf_MO.vmt" )
	resource.AddFile( "materials/HUD/killicons/acf_RAC.vtf" )
	resource.AddFile( "materials/HUD/killicons/acf_RAC.vmt" )

	
elseif (CLIENT) then

	include("acf/client/cl_acfballistics.lua")
	--include("ACF/Client/cl_ACFMenu_GUI.lua")
	
	killicon.Add( "acf_AC", "HUD/killicons/acf_AC", Color( 181, 48, 48, 255 ) )
	killicon.Add( "acf_AL", "HUD/killicons/acf_AL", Color( 181, 48, 48, 255 ) )
	killicon.Add( "acf_C", "HUD/killicons/acf_C", Color( 181, 48, 48, 255 ) )
	killicon.Add( "acf_GL", "HUD/killicons/acf_GL", Color( 181, 48, 48, 255 ) )
	killicon.Add( "acf_HMG", "HUD/killicons/acf_HMG", Color( 181, 48, 48, 255 ) )
	killicon.Add( "acf_HW", "HUD/killicons/acf_HW", Color( 181, 48, 48, 255 ) )
	killicon.Add( "acf_MG", "HUD/killicons/acf_MG", Color( 181, 48, 48, 255 ) )
	killicon.Add( "acf_MO", "HUD/killicons/acf_MO", Color( 181, 48, 48, 255 ) )
	killicon.Add( "acf_RAC", "HUD/killicons/acf_RAC", Color( 181, 48, 48, 255 ) )
	
end

include("acf/shared/rounds/roundap.lua")
include("acf/shared/rounds/roundaphe.lua")
include("acf/shared/rounds/roundhe.lua")
include("acf/shared/rounds/roundheat.lua")
include("acf/shared/rounds/roundhp.lua")
include("acf/shared/rounds/roundsmoke.lua")
include("acf/shared/rounds/roundrefill.lua")
include("acf/shared/rounds/roundfunctions.lua")

include("acf/shared/acfgunlist.lua")
include("acf/shared/acfmobilitylist.lua")
include("acf/shared/acfsensorlist.lua")
include("acf/shared/acfmissilelist.lua")

ACF.Weapons = list.Get("ACFEnts")
	
ACF.Classes = list.Get("ACFClasses")

ACF.RoundTypes = list.Get("ACFRoundTypes")

ACF.IdRounds = list.Get("ACFIdRounds")	--Lookup tables so i can get rounds classes from clientside with just an integer

timer.Simple(5,function()
	game.AddParticles("particles/acf_muzzleflashes.pcf")
	game.AddParticles("particles/explosion1.pcf")
	game.AddParticles("particles/rocket_motor.pcf")


	for Class,Table in pairs(ACF.Classes["GunClass"]) do
		PrecacheParticleSystem(Table["muzzleflash"])
	end
end)

function ACF_MuzzleVelocity( Propellant, Mass, Caliber )

	local PEnergy = ACF.PBase * ((1+Propellant)^ACF.PScale-1)
	local Speed = ((PEnergy*2000/Mass)^ACF.MVScale)
	local Final = Speed -- - Speed * math.Clamp(Speed/2000,0,0.5)

	return Final
end

function ACF_Kinetic( Speed , Mass, LimitVel )
	
	LimitVel = LimitVel or 99999
	Speed = Speed/39.37
	
	local Energy = {}
		Energy.Kinetic = ((Mass) * ((Speed)^2))/2000 --Energy in KiloJoules
		Energy.Momentum = (Speed * Mass)
		
		local KE = (Mass * (Speed^ACF.KinFudgeFactor))/2000 + Energy.Momentum
		Energy.Penetration = math.max( KE - (math.max(Speed-LimitVel,0)^2)/(LimitVel*5) * (KE/200)^0.95 , KE*0.1 )
		--Energy.Penetration = math.max( KE - (math.max(Speed-LimitVel,0)^2)/(LimitVel*5) * (KE/200)^0.95 , KE*0.1 )
		--Energy.Penetration = math.max(Energy.Momentum^ACF.KinFudgeFactor - math.max(Speed-LimitVel,0)/(LimitVel*5) * Energy.Momentum , Energy.Momentum*0.1)
	
	return Energy
end

-- New healthmod/armormod/ammomod cvars
CreateConVar("acf_healthmod", 1)
CreateConVar("acf_armormod", 1)
CreateConVar("acf_ammomod", 1)
CreateConVar("acf_spalling", 0)

function ACF_CVarChangeCallback(CVar, Prev, New)
	if( CVar == "acf_healthmod" ) then
		ACF.Threshold = 150 / math.max(New, 0.01)
		print ("Health Mod changed to a factor of " .. New)
	elseif( CVar == "acf_armormod" ) then
		ACF.ArmorMod = 1 * math.max(New, 0)
		print ("Armor Mod changed to a factor of " .. New)
	elseif( CVar == "acf_ammomod" ) then
		ACF.AmmoMod = 1 * math.max(New, 0.01)
		print ("Ammo Mod changed to a factor of " .. New)
	elseif( CVar == "acf_spalling" ) then
		ACF.Spalling = math.floor(math.Clamp(New, 0, 1))
		local text = "off"
		if(ACF.Spalling > 0) then
			text = "on"
		end
		print ("ACF Spalling is now " .. text)
	end	
end


function ACF_UpdateChecking( )
	
	print("Checking for updates....")
	
	http.Fetch("http://acf.googlecode.com/svn/",function(contents,size)
		local rev = tonumber(string.match( contents, "Revision ([0-9]+)" ))
		if rev and ACF.Version >= rev then
			print("ACF Is Up To Date, Latest Version: "..rev)
			
		elseif !rev then
			print("No Internet Connection Detected! ACF Update Check Failed")
		else
			print("A newer version of ACF is available! Version: "..rev..", You have Version: "..ACF.Version)
			
			print("Please update!")
		end
		ACF.CurrentVersion = rev
		
	end, function() end)
end
ACF_UpdateChecking( )

if SERVER then
	duplicator.RegisterEntityModifier( "acf_diffsound", function( ply , Entity , data)
		if !IsValid( Entity ) then return end
		local sound = data[1]
		timer.Simple(1, function()
			if Entity:GetClass() == "acf_engine" then
				Entity.SoundPath = sound
			elseif Entity:GetClass() == "acf_gun" then
				Entity.Sound = sound
			end
		end)
		
		duplicator.StoreEntityModifier( Entity, "acf_diffsound", {sound} )
	end)
end

concommand.Add("acf_replacesound", function(ply, _, args)
	if CLIENT then return end
	local sound
	if type(args) == "table" then 
		sound = args[1]
	else
		sound = args
	end
	
	if not sound then return end
	
	if not file.Find("sounds"..sound, "GAME") then
		print("sounds/"..sound.."*")
		print("There is no such sound!")
		return
	end
	
	local tr = ply:GetEyeTrace()
	if not tr.Entity or (tr.Entity:GetClass() ~= "acf_gun" and tr.Entity:GetClass() ~= "acf_engine") then
		print("You need to look at engine or gun to change it's sound")
		return
	end
	local ent = tr.Entity
	if ent:GetClass() == "acf_engine" then
		ent.SoundPath = sound
	elseif ent:GetClass() == "acf_gun" then
		ent.Sound = sound
		ent:SetNWString( "Sound", sound )
	end
	duplicator.StoreEntityModifier( ent , "acf_diffsound", {sound} )
end)

function ACF_ChatVersionPrint(ply)
	if not ACF.Version or ACF.Version < ACF.CurrentVersion then
	timer.Simple( 2,function()
		ply:SendLua(
			"chat.AddText(Color(255,0,0),\"A newer version of ACF is available! Version: \"..ACF.CurrentVersion)"
			) 
		end)
	end	
end

hook.Add("PlayerInitialSpawn","versioncheck",ACF_ChatVersionPrint)

cvars.AddChangeCallback("acf_healthmod", ACF_CVarChangeCallback)
cvars.AddChangeCallback("acf_armormod", ACF_CVarChangeCallback)
cvars.AddChangeCallback("acf_ammomod", ACF_CVarChangeCallback)
cvars.AddChangeCallback("acf_spalling", ACF_CVarChangeCallback)

/*
ONE HUGE HACK to get good killicons.
*/

if SERVER then
	util.AddNetworkString( "ACF_KilledByACF" )
	
	hook.Add("PlayerDeath", "ACF_PlayerDeath",function( victim, inflictor, attacker )
		if victim.KilledByAmmo then
			net.Start("ACF_KilledByACF")
				net.WriteString( victim:Nick()..";ammo;"..attacker:Nick() )
			net.Broadcast()
		elseif inflictor:GetClass() == "acf_gun" then
			net.Start("ACF_KilledByACF")
				net.WriteString( victim:Nick()..";"..inflictor.Class..";"..attacker:Nick() )
			net.Broadcast()
		end
	end)
end


if CLIENT then
	
	net.Receive("ACF_KilledByACF", function()
		local Table = string.Explode(";", net.ReadString())
		local victim, gun, attacker = Table[1], Table[2], Table[3]
		
		if attacker == "worldspawn" then attacker = "" end
		GAMEMODE:AddDeathNotice( attacker, -1, "acf_"..gun, victim, 1001 )
	end)
	
	timer.Create("ACF_replacePlayerKilled", 1, 0, function()
		local Hooks = usermessage.GetTable()
		if Hooks["PlayerKilled"] then
			local ACF_PlayerKilled = Hooks["PlayerKilled"].Function
			Hooks["PlayerKilled"].Function = function(msg)
				local victim     = msg:ReadEntity()
				if ( !IsValid( victim ) ) then return end
				local inflictor    = msg:ReadString()
				local attacker     = msg:ReadString()
				if inflictor != "acf_gun" then
					ACF_PlayerKilled(msg)
				end
			end
			timer.Destroy("ACF_replacePlayerKilled")
			Msg("Replaced PlayerKilled\n")
		end
	end)
	timer.Create("ACF_replacePlayerKilledByPlayer", 1, 0, function()
		local Hooks = usermessage.GetTable()
		if Hooks["PlayerKilledByPlayer"] then
			local ACF_PlayerKilledByPlayer = Hooks["PlayerKilledByPlayer"].Function
			Hooks["PlayerKilledByPlayer"].Function = function(msg)
				local victim     = msg:ReadEntity()
				local inflictor    = msg:ReadString()
				local attacker     = msg:ReadEntity()

				if ( !IsValid( attacker ) ) then return end
				if ( !IsValid( victim ) ) then return end
				if inflictor != "acf_gun" then
					ACF_PlayerKilledByPlayer(msg)
				end
			end
			timer.Destroy("ACF_replacePlayerKilledByPlayer")
			Msg("Replaced PlayerKilledByPlayer\n")
		end
	end)
end
