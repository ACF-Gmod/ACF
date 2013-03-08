AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )

include('shared.lua')

function ENT:Initialize()

	self.Throttle = 0
	self.Active = false
	self.IsMaster = true
	self.GearLink = {}
	self.GearRope = {}

	self.LastCheck = 0
	self.LastThink = 0
	self.Mass = 0
	self.PhysMass = 0
	self.MassRatio = 1
	self.Legal = true
	self.CanUpdate = true

	self.Inputs = Wire_CreateInputs( self.Entity, { "Active", "Throttle" } )
	self.Outputs = WireLib.CreateSpecialOutputs( self.Entity, { "RPM", "Torque", "Power", "Entity" , "Mass" , "Physical Mass" }, { "NORMAL" ,"NORMAL" ,"NORMAL" , "ENTITY" , "NORMAL" , "NORMAL" } )
	Wire_TriggerOutput(self.Entity, "Entity", self.Entity)
	self.WireDebugName = "ACF Engine"

end  

function MakeACF_Engine(Owner, Pos, Angle, Id)

	if not Owner:CheckLimit("_acf_misc") then return false end

	local Engine = ents.Create("ACF_Engine")
	local List = list.Get("ACFEnts")
	local Classes = list.Get("ACFClasses")
	if not Engine:IsValid() then return false end
	Engine:SetAngles(Angle)
	Engine:SetPos(Pos)
	Engine:Spawn()

	Engine:SetPlayer(Owner)
	Engine.Owner = Owner
	Engine.Id = Id
	Engine.Model = List["Mobility"][Id]["model"]
	Engine.SoundPath = List["Mobility"][Id]["sound"]
	Engine.Weight = List["Mobility"][Id]["weight"]
	Engine.PeakTorque = List["Mobility"][Id]["torque"]
	Engine.IdleRPM = List["Mobility"][Id]["idlerpm"]
	Engine.PeakMinRPM = List["Mobility"][Id]["peakminrpm"]
	Engine.PeakMaxRPM = List["Mobility"][Id]["peakmaxrpm"]
	Engine.LimitRPM = List["Mobility"][Id]["limitprm"]
	Engine.Inertia = List["Mobility"][Id]["flywheelmass"]*(3.1416)^2
	Engine.iselec = List["Mobility"][Id]["iselec"]
	Engine.elecpower = List["Mobility"][Id]["elecpower"]
	Engine.FlywheelOverride = List["Mobility"][Id]["flywheeloverride"]

	Engine.FlyRPM = 0
	Engine:SetModel( Engine.Model )	
	Engine.Sound = nil
	Engine.RPM = {}

	Engine:PhysicsInit( SOLID_VPHYSICS )      	
	Engine:SetMoveType( MOVETYPE_VPHYSICS )     	
	Engine:SetSolid( SOLID_VPHYSICS )

	Engine.Out = Engine:WorldToLocal(Engine:GetAttachment(Engine:LookupAttachment( "driveshaft" )).Pos)

	local phys = Engine:GetPhysicsObject()  	
	if (phys:IsValid()) then 
		phys:SetMass( Engine.Weight ) 
	end

	Engine:SetNetworkedBeamString("Type",List["Mobility"][Id]["name"])
	Engine:SetNetworkedBeamInt("Torque",Engine.PeakTorque)	
	-- add in the variable to check if its an electric motor
	if (Engine.iselec == true )then
		Engine:SetNetworkedBeamInt("Power",Engine.elecpower) -- add in the value from the elecpower
	else
		Engine:SetNetworkedBeamInt("Power",math.floor(Engine.PeakTorque * Engine.PeakMaxRPM / 9548.8))
	end
	Engine:SetNetworkedBeamInt("MinRPM",Engine.PeakMinRPM)
	Engine:SetNetworkedBeamInt("MaxRPM",Engine.PeakMaxRPM)
	Engine:SetNetworkedBeamInt("LimitRPM",Engine.LimitRPM)

	undo.Create("ACF Engine")
		undo.AddEntity( Engine )
		undo.SetPlayer( Owner )
	undo.Finish()

	Owner:AddCount("_acf_engine", Engine)
	Owner:AddCleanup( "acfmenu", Engine )

	return Engine
end
list.Set( "ACFCvars", "acf_engine" , {"id"} )
duplicator.RegisterEntityClass("acf_engine", MakeACF_Engine, "Pos", "Angle", "Id")

function ENT:Update( ArgsTable )	--That table is the player data, as sorted in the ACFCvars above, with player who shot, and pos and angle of the tool trace inserted at the start

	local Feedback = "Engine updated"
	if self.Active then
		Feedback = "Please turn off the engine before updating it"
	return Feedback end
	if ( ArgsTable[1] != self.Owner ) then --Argtable[1] is the player that shot the tool
		Feedback = "You don't own that engine !"
	return Feedback end

	local Id = ArgsTable[4]	--Argtable[4] is the engine ID
	local List = list.Get("ACFEnts")

	if ( List["Mobility"][Id]["model"] != self.Model ) then --Make sure the models are the sames before doing a changeover
		Feedback = "The new engine needs to have the same model as the old one !"
	return end

	self.Id = Id
	self.SoundPath = List["Mobility"][Id]["sound"]
	self.Weight = List["Mobility"][Id]["weight"]
	self.PeakTorque = List["Mobility"][Id]["torque"]
	self.IdleRPM = List["Mobility"][Id]["idlerpm"]
	self.PeakMinRPM = List["Mobility"][Id]["peakminrpm"]
	self.PeakMaxRPM = List["Mobility"][Id]["peakmaxrpm"]
	self.LimitRPM = List["Mobility"][Id]["limitprm"]
	self.Inertia = List["Mobility"][Id]["flywheelmass"]*(3.1416)^2
	self.iselec = List["Mobility"][Id]["iselec"] -- is the engine electric?
	self.elecpower = List["Mobility"][Id]["elecpower"] -- how much power does it output
	self.FlywheelOverride = List["Mobility"][Id]["flywheeloverride"] -- how much power does it output

	self:SetModel( self.Model )	
	self:SetSolid( SOLID_VPHYSICS )
	self.Out = self:WorldToLocal(self:GetAttachment(self:LookupAttachment( "driveshaft" )).Pos)

	local phys = self:GetPhysicsObject()  	
	if (phys:IsValid()) then 
		phys:SetMass( self.Weight ) 
	end

	self:SetNetworkedBeamString("Type",List["Mobility"][Id]["name"])
	self:SetNetworkedBeamInt("Torque",self.PeakTorque)
	-- add in the variable to check if its an electric motor
	if (self.iselec == true)  then
		self:SetNetworkedBeamInt("Power",self.elecpower) -- add in the value from the elecpower
	else
		self:SetNetworkedBeamInt("Power",math.floor(self.PeakTorque * self.PeakMaxRPM / 9548.8))
	end

	self:SetNetworkedBeamInt("MinRPM",self.PeakMinRPM)
	self:SetNetworkedBeamInt("MaxRPM",self.PeakMaxRPM)
	self:SetNetworkedBeamInt("LimitRPM",self.LimitRPM)


	return Feedback
end

function ENT:TriggerInput( iname , value )

	if (iname == "Throttle") then
		self.Throttle = math.Clamp(value,0,100)/100
	elseif (iname == "Active") then
		if (value > 0 and not self.Active) then
			self.Active = true
			self.Sound = CreateSound(self, self.SoundPath)
			self.Sound:PlayEx(0.5,100)
			self:ACFInit()
		elseif (value <= 0 and self.Active) then
			self.Active = false
			self.RPM = {}
			self.RPM[1] = self.IdleRPM
			if self.Sound then
				self.Sound:Stop()
			end
			self.Sound = nil
		end
	end		


end

function ENT:Think()

	local Time = CurTime()

	if self.Active then

		if self.Legal then		
			local EngPhys = self:GetPhysicsObject()
			local RPM = self:CalcRPM( EngPhys )
		end

		if self.LastCheck < CurTime() then
			self:CheckRopes()
			if self.Entity:GetPhysicsObject():GetMass() < self.Weight or self.Entity:GetParent():IsValid() then
				self.Legal = false
			else 
				self.Legal = true
			end

			self.LastCheck = Time + math.Rand(5,10)
		end

	end

	self.LastThink = Time
	self.Entity:NextThink(Time)
	return true

end

function ENT:ACFInit()

	if not constraint.HasConstraints(self) then return end

	local Constrained = constraint.GetAllConstrainedEntities(self)
	self.Mass = 0
	self.PhysMass = 0

	for _,Ent in pairs(Constrained) do

		if IsValid(Ent) then
			local Phys = Ent:GetPhysicsObject()

			if Phys and Phys:IsValid() then
				self.Mass = self.Mass + Phys:GetMass()
				local Parent = Ent:GetParent()

				if IsValid(Parent) then

					local Constraints = {}
					table.Add(Constraints,constraint.FindConstraints(Ent, "Weld"))
					table.Add(Constraints,constraint.FindConstraints(Ent, "Axis"))
					table.Add(Constraints,constraint.FindConstraints(Ent, "Ballsocket"))
					table.Add(Constraints,constraint.FindConstraints(Ent, "AdvBallsocket"))

					if Constraints then

						for Key,Const in pairs(Constraints) do

							if Const.Ent1 == Parent or Const.Ent2 == Parent then
								self.PhysMass = self.PhysMass + Phys:GetMass()
							end

						end

					end

				else
					self.PhysMass = self.PhysMass + Phys:GetMass()
				end

			end

		end

	end

	self.MassRatio = self.PhysMass/self.Mass

	Wire_TriggerOutput(self.Entity, "Mass", math.floor(self.Mass))
	Wire_TriggerOutput(self.Entity, "Physical Mass", math.floor(self.PhysMass))

	self.LastThink = CurTime()
	self.Torque = self.PeakTorque
	self.FlyRPM = self.IdleRPM*1.5

end

function ENT:CalcRPM( EngPhys )

	local DeltaTime = (CurTime() - self.LastThink)
		local AutoClutch = math.min(math.max(self.FlyRPM-self.IdleRPM,0)/(self.IdleRPM+self.LimitRPM/10),1)

	//local ClutchRatio = math.min(Clutch/math.max(TorqueDiff,0.05),1)
	self.Torque = self.Throttle * math.max( self.PeakTorque * math.min( self.FlyRPM/self.PeakMinRPM , (self.LimitRPM - self.FlyRPM)/(self.LimitRPM - self.PeakMaxRPM), 1 ),0 ) --Calculate the current torque from flywheel RPM
	--local Drag = self.PeakTorque*(math.max(self.FlyRPM-self.IdleRPM,0)/self.PeakMaxRPM)*(1-self.Throttle) /self.Inertia
	local Drag 
		if (self.iselec == true)  then
		 Drag = self.PeakTorque*(math.max(self.FlyRPM-self.IdleRPM,0)/self.FlywheelOverride)*(1-self.Throttle) /self.Inertia
	else
		 Drag = self.PeakTorque*(math.max(self.FlyRPM-self.IdleRPM,0)/self.PeakMaxRPM)*(1-self.Throttle) /self.Inertia
	end
	self.FlyRPM = math.max(self.FlyRPM + self.Torque/self.Inertia - Drag,1)		--Let's accelerate the flywheel based on that torque	

	local Boxes = table.Count(self.GearLink) --The gearboxes don't think on their own, it's the engine that calls them, to ensure consistent execution order
	local MaxTqTable = {}
	local MaxTq = 0
	for Key, Gearbox in pairs(self.GearLink) do 
		MaxTqTable[Key] = Gearbox:Calc( self.FlyRPM, self.Inertia )		--Get the requirements for torque for the gearboxes (Max clutch rating minus any wheels currently spinning faster than the Flywheel)
		MaxTq = MaxTq + MaxTqTable[Key]
	end

	local TorqueDiff = math.max(self.FlyRPM - self.IdleRPM,0)*self.Inertia		--This is the presently avaliable torque from the engine
	local AvailTq = math.min(TorqueDiff/MaxTq/Boxes,1)		--Calculate the ratio of total requested torque versus what's avaliable

	for Key, Gearbox in pairs(self.GearLink) do
		Gearbox:Act(MaxTqTable[Key]*AvailTq*self.MassRatio,DeltaTime)	--Split the torque fairly between the gearboxes who need it
	end

	self.FlyRPM = self.FlyRPM - (math.min(TorqueDiff,MaxTq)/self.Inertia)

	table.remove( self.RPM, 10 )	--Then we calc a smoothed RPM value for the sound effects
	table.insert( self.RPM, 1, self.FlyRPM )
	local SmoothRPM = 0
	for Key, RPM in pairs(self.RPM) do
		SmoothRPM = SmoothRPM + (RPM or 0)
	end
	SmoothRPM = SmoothRPM/10

	local Power = self.Torque * SmoothRPM / 9548.8
	Wire_TriggerOutput(self.Entity, "Torque", math.floor(self.Torque))
	Wire_TriggerOutput(self.Entity, "Power", math.floor(Power))
	Wire_TriggerOutput(self.Entity, "RPM", self.FlyRPM)
	self.Sound:ChangePitch(math.min(20 + SmoothRPM/50,255),0)
	self.Sound:ChangeVolume(0.25 + self.Throttle/1.5,0)

	return RPM

end

function ENT:CheckRopes()

	for GearboxKey,Ent in pairs(self.GearLink) do
		local Constraints = constraint.FindConstraints(Ent, "Rope")
		if Constraints then

			local Clean = false
			for Key,Rope in pairs(Constraints) do
				if Rope.Ent1 == self.Entity or Rope.Ent2 == self.Entity then
					if Rope.length + Rope.addlength < self.GearRope[GearboxKey]*1.5 then
						Clean = true
					end
				end
			end

			if not Clean then
				self:Unlink( Ent )
			end

		else
			self:Unlink( Ent )
		end

		local DrvAngle = (self.Entity:LocalToWorld(self.Out) - Ent:LocalToWorld(Ent.In)):GetNormalized():DotProduct( self:GetForward() )
		if ( DrvAngle < 0.7 ) then
			self:Unlink( Ent )
		end

	end

end

function ENT:Link( Target )

	if ( !Target or Target:GetClass() != "acf_gearbox" ) then return ("Can only link to Gearboxes") end

	local Duplicate = false
	for Key,Value in pairs(self.GearLink) do
		if Value == Target then
			Duplicate = true
		end
	end

	if not Duplicate then

		local InPos = Target:LocalToWorld(Target.In)
		local OutPos = self.Entity:LocalToWorld(self.Out)
		local DrvAngle = (OutPos - InPos):GetNormalized():DotProduct((self:GetForward()))
		if ( DrvAngle < 0.7 ) then
			return 'ERROR : Excessive driveshaft angle'
		end

		table.insert(self.GearLink,Target)
		table.insert(Target.Master,self.Entity)
		local RopeL = (OutPos-InPos):Length()
		constraint.Rope( self.Entity, Target, 0, 0, self.Out, Target.In, RopeL, RopeL*0.2, 0, 1, "cable/cable2", false )
		table.insert(self.GearRope,RopeL)

		return false
	else
		return ('ERROR : Gearbox already linked to this Engine')
	end


end

function ENT:Unlink( Target )

	local Success = false
	for Key,Value in pairs(self.GearLink) do
		if Value == Target then

			local Constraints = constraint.FindConstraints(Value, "Rope")
			if Constraints then
				for Key,Rope in pairs(Constraints) do
					if Rope.Ent1 == self.Entity or Rope.Ent2 == self.Entity then
						Rope.Constraint:Remove()
					end
				end
			end

			table.remove(self.GearLink,Key)
			table.remove(self.GearRope,Key)
			Success = true
		end
	end

	if Success then
		return false
	else
		return ('ERROR : Did not find the Gearbox to unlink')
	end

end

function ENT:PreEntityCopy()

	//Link Saving
	local info = {}
	local entids = {}
	for Key, Value in pairs(self.GearLink) do					--First clean the table of any invalid entities
		if not Value:IsValid() then
			table.remove(self.GearLink, Value)
		end
	end
	for Key, Value in pairs(self.GearLink) do					--Then save it
		table.insert(entids, Value:EntIndex())
	end

	info.entities = entids
	if info.entities then
		duplicator.StoreEntityModifier( self.Entity, "GearLink", info )
	end

	//Wire dupe info
	local DupeInfo = WireLib.BuildDupeInfo(self.Entity)
	if(DupeInfo) then
		duplicator.StoreEntityModifier(self.Entity,"WireDupeInfo",DupeInfo)
	end

end

function ENT:PostEntityPaste( Player, Ent, CreatedEntities )

	//Link Pasting
	if (Ent.EntityMods) and (Ent.EntityMods.GearLink) and (Ent.EntityMods.GearLink.entities) then
		local GearLink = Ent.EntityMods.GearLink
		if GearLink.entities and table.Count(GearLink.entities) > 0 then
			for _,ID in pairs(GearLink.entities) do
				local Linked = CreatedEntities[ ID ]
				if Linked and Linked:IsValid() then
					self:Link( Linked )
				end
			end
		end
		Ent.EntityMods.GearLink = nil
	end

	//Wire dupe info
	if(Ent.EntityMods and Ent.EntityMods.WireDupeInfo) then
		WireLib.ApplyDupeInfo(Player, Ent, Ent.EntityMods.WireDupeInfo, function(id) return CreatedEntities[id] end)
	end

end

function ENT:OnRemove()
	if self.Sound then
		self.Sound:Stop()
	end
	Wire_Remove(self.Entity)
end

function ENT:OnRestore()
    Wire_Restored(self.Entity)
end

