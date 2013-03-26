function ACF_Activate ( Entity , Recalc )

	--Density of steel = 7.8g cm3 so 7.8kg for a 1mx1m plate 1m thick
	if Entity.SpecialHealth then
		Entity:ACF_Activate( Recalc )
		return
	end
	local Size = Entity.OBBMaxs(Entity) - Entity.OBBMins(Entity)
	local Aera = ((Size.x * Size.y)+(Size.x * Size.z)+(Size.y * Size.z)) * 6.45 --Converting from square in to square cm, fuck imperial
	local Volume = Size.x * Size.y * Size.z * 16.38
	local Armour = Entity:GetPhysicsObject():GetMass()*1000 / Aera / 0.78 --So we get the equivalent thickness of that prop in mm if all it's weight was a steel plate
	local Health = Aera/ACF.Threshold							--Setting the threshold of the prop aera gone 
	local Percent = 1 
	
	if Recalc then
		Percent = Entity.ACF.Health/Entity.ACF.MaxHealth
	end
	Entity.ACF = {} 
	Entity.ACF.Health = Health * Percent
	Entity.ACF.MaxHealth = Health
	Entity.ACF.Armour = Armour * (0.5 + Percent/2)
	Entity.ACF.MaxArmour = Armour * ACF.ArmorMod
	Entity.ACF.Type = nil
	Entity.ACF.Mass = Entity:GetPhysicsObject():GetMass()
	Entity.ACF.Density = (Entity:GetPhysicsObject():GetMass()*1000)/Volume

	if Entity:IsPlayer() || Entity:IsNPC() then
		Entity.ACF.Type = "Squishy"
	elseif Entity:IsVehicle() then
		Entity.ACF.Type = "Vehicle"
	else
		Entity.ACF.Type = "Prop"
	end
	
end

function ACF_Check ( Entity )
	
	if ( IsValid(Entity) ) then
		if ( Entity:GetPhysicsObject():IsValid() and !Entity:IsWorld() and !Entity:IsWeapon() ) then
			local Class = Entity:GetClass()
			--print(Class)
			if ( Class != "gmod_ghost" and Class != "debris" and Class != "prop_ragdoll" and not string.find( Class , "func_" )  ) then
				if !Entity.ACF then 
					ACF_Activate( Entity )
				elseif Entity.ACF.Mass != Entity:GetPhysicsObject():GetMass() then
					ACF_Activate( Entity , true )
				end
				return Entity.ACF.Type	
			end	
		end
	end
	return false
	
end

function ACF_Damage ( Entity , Energy , FrAera , Angle , Inflictor , Bone, Gun, Ammo ) 
	
	if ACF.safezone then
		if Entity:GetPos():WithinAABox( ACF.safezone[1], ACF.safezone[2] ) then
			ACF_RemoveBullet( Index )			
			return
		end
	end
	
	local Activated = ACF_Check( Entity )
	
	if Entity.SpecialDamage then
		print("Entity.SpecialDamage")
		return Entity:ACF_OnDamage( Entity , Energy , FrAera , Angle , Inflictor , Bone )
	elseif Activated == "Prop" then	
		
		return ACF_PropDamage( Entity , Energy , FrAera , Angle , Inflictor , Bone )
		
	elseif Activated == "Vehicle" then
	
		return ACF_VehicleDamage( Entity , Energy , FrAera , Angle , Inflictor , Bone, Gun, Ammo )
		
	elseif Activated == "Squishy" then
	
		return ACF_SquishyDamage( Entity , Energy , FrAera , Angle , Inflictor , Bone, Gun, Ammo )
		
	end
	
end

function ACF_CalcDamage( Entity , Energy , FrAera , Angle )

	local Armour = Entity.ACF.Armour/math.abs( math.cos(math.rad(Angle)) ) --Calculate Line Of Sight thickness of the armour
	local Structure = Entity.ACF.Density --Structural strengh of the material, derived from prop density, denser stuff is more vulnerable (Density is different than armour, calculated off real volume)
	
	local MaxPenetration = (Energy.Penetration / FrAera) * ACF.KEtoRHA							--Let's see how deep the projectile penetrates ( Energy = Kinetic Energy, FrAera = Frontal aera in cm2 )
	--print(MaxPenetration)
	local Penetration = math.min( MaxPenetration , Armour )			--Clamp penetration to the armour thickness
	
	local HitRes = {}
	--BNK Stuff
	local dmul = 1
	if (ISBNK) then
		local cvar = GetConVarNumber("sbox_godmode")
	
		if (cvar == 1) then
			dmul = 0
		end
	end
	--SITP Stuff
	local var = 1
	if (ISSITP) then
		if(!Entity.sitp_spacetype) then
			Entity.sitp_spacetype = "space"
		end
		if(Entity.sitp_spacetype != "space" and Entity.sitp_spacetype != "planet") then
			var = 0
		end
	end
	
	HitRes.Damage = var * dmul * (Penetration/Armour)^2 * FrAera	-- This is the volume of the hole caused by our projectile 
	--print(HitRes.Damage)
	HitRes.Overkill = (MaxPenetration - Penetration)
	HitRes.Loss = Penetration/MaxPenetration
	
	return HitRes
end

function ACF_PropDamage( Entity , Energy , FrAera , Angle , Inflictor , Bone )

	local HitRes = ACF_CalcDamage( Entity , Energy , FrAera , Angle )
	
	HitRes.Kill = false
	if HitRes.Damage >= Entity.ACF.Health then
		HitRes.Kill = true 
	else
		Entity.ACF.Health = Entity.ACF.Health - HitRes.Damage
		Entity.ACF.Armour = Entity.ACF.MaxArmour * (0.5 + Entity.ACF.Health/Entity.ACF.MaxHealth/2) --Simulating the plate weakening after a hit
	end
		
	return HitRes
	
end

function ACF_VehicleDamage( Entity , Energy , FrAera , Angle , Inflictor , Bone, Gun, Ammo )

	local HitRes = ACF_CalcDamage( Entity , Energy , FrAera , Angle )
	
	local Driver = Entity:GetDriver()
	if Driver:IsValid() then
		if Ammo == true then
			Entity.KilledByAmmo = true
		end
		Driver:TakeDamage( HitRes.Damage*40, Gun, Inflictor )
		if Ammo == true then
			Entity.KilledByAmmo = false
		end
		
	end

	HitRes.Kill = false
	if HitRes.Damage >= Entity.ACF.Health then
		HitRes.Kill = true 
	else
		Entity.ACF.Health = Entity.ACF.Health - HitRes.Damage
		Entity.ACF.Armour = Entity.ACF.Armour * (0.5 + Entity.ACF.Health/Entity.ACF.MaxHealth/2) --Simulating the plate weakening after a hit
	end
		
	return HitRes
end

function ACF_SquishyDamage( Entity , Energy , FrAera , Angle , Inflictor , Bone, Gun, Ammo )
	
	local Size = Entity:BoundingRadius()
	local Mass = Entity:GetPhysicsObject():GetMass()
	local HitRes = {}
	local Damage = 0
	local Target = {ACF = {Armour = 0.1}}		--We create a dummy table to pass armour values to the calc function
	if (Bone) then
		
		if ( Bone == 1 ) then		--This means we hit the head
			Target.ACF.Armour = Mass*0.02	--Set the skull thickness as a percentage of Squishy weight, this gives us 2mm for a player, about 22mm for an Antlion Guard. Seems about right
			HitRes = ACF_CalcDamage( Target , Energy , FrAera , Angle )		--This is hard bone, so still sensitive to impact angle
			Damage = HitRes.Damage*20
			if HitRes.Overkill > 0 then									--If we manage to penetrate the skull, then MASSIVE DAMAGE
				Target.ACF.Armour = Size*0.25*0.01						--A quarter the bounding radius seems about right for most critters head size
				HitRes = ACF_CalcDamage( Target , Energy , FrAera , 0 )
				Damage = Damage + HitRes.Damage*100
			end
			Target.ACF.Armour = Mass*0.065	--Then to check if we can get out of the other side, 2x skull + 1x brains
			HitRes = ACF_CalcDamage( Target , Energy , FrAera , Angle )	
			Damage = Damage + HitRes.Damage*20				
			
		elseif ( Bone == 0 or Bone == 2 or Bone == 3 ) then		--This means we hit the torso. We are assuming body armour/tough exoskeleton/zombie don't give fuck here, so it's tough
			Target.ACF.Armour = Mass*0.08	--Set the armour thickness as a percentage of Squishy weight, this gives us 8mm for a player, about 90mm for an Antlion Guard. Seems about right
			HitRes = ACF_CalcDamage( Target , Energy , FrAera , Angle )		--Armour plate,, so sensitive to impact angle
			Damage = HitRes.Damage*5
			if HitRes.Overkill > 0 then
				Target.ACF.Armour = Size*0.5*0.02							--Half the bounding radius seems about right for most critters torso size
				HitRes = ACF_CalcDamage( Target , Energy , FrAera , 0 )		
				Damage = Damage + HitRes.Damage*50							--If we penetrate the armour then we get into the important bits inside, so DAMAGE
			end
			Target.ACF.Armour = Mass*0.185	--Then to check if we can get out of the other side, 2x armour + 1x guts
			HitRes = ACF_CalcDamage( Target , Energy , FrAera , Angle )
			
		elseif ( Bone == 4 or Bone == 5 ) then 		--This means we hit an arm or appendage, so ormal damage, no armour
		
			Target.ACF.Armour = Size*0.2*0.02							--A fitht the bounding radius seems about right for most critters appendages
			HitRes = ACF_CalcDamage( Target , Energy , FrAera , 0 )		--This is flesh, angle doesn't matter
			Damage = HitRes.Damage*30							--Limbs are somewhat less important
		
		elseif ( Bone == 6 or Bone == 7 ) then
		
			Target.ACF.Armour = Size*0.2*0.02							--A fitht the bounding radius seems about right for most critters appendages
			HitRes = ACF_CalcDamage( Target , Energy , FrAera , 0 )		--This is flesh, angle doesn't matter
			Damage = HitRes.Damage*30							--Limbs are somewhat less important
			
		elseif ( Bone == 10 ) then					--This means we hit a backpack or something
		
			Target.ACF.Armour = Size*0.1*0.02							--Arbitrary size, most of the gear carried is pretty small
			HitRes = ACF_CalcDamage( Target , Energy , FrAera , 0 )		--This is random junk, angle doesn't matter
			Damage = HitRes.Damage*2								--Damage is going to be fright and shrapnel, nothing much		

		else 										--Just in case we hit something not standard
		
			Target.ACF.Armour = Size*0.2*0.02						
			HitRes = ACF_CalcDamage( Target , Energy , FrAera , 0 )
			Damage = HitRes.Damage*30	
			
		end
		
	else 										--Just in case we hit something not standard
	
		Target.ACF.Armour = Size*0.2*0.02						
		HitRes = ACF_CalcDamage( Target , Energy , FrAera , 0 )
		Damage = HitRes.Damage*10	
	
	end
	
	local dmul = 2.5
	
	--BNK stuff
	if (ISBNK) then
		if(Entity.freq and Inflictor.freq) then
			if (Entity != Inflictor) and (Entity.freq == Inflictor.freq) then
				dmul = 0
			end
		end
	end
	
	--SITP stuff
	local var = 1
	if(!Entity.sitp_spacetype) then
		Entity.sitp_spacetype = "space"
	end
	if(Entity.sitp_spacetype == "homeworld") then
		var = 0
	end
	
	if Ammo == true then
		Entity.KilledByAmmo = true
	end
	Entity:TakeDamage( Damage * dmul * var, Inflictor, Gun )
	if Ammo == true then
		Entity.KilledByAmmo = false
	end
	
	HitRes.Kill = false
	--print(Damage)
	--print(Bone)
		
	return HitRes
end
