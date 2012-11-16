TOOL.Category		= "Construction"
TOOL.Name			= "#ACFMenu"
TOOL.Command		= nil
TOOL.ConfigName		= ""

TOOL.ClientConVar[ "type" ] = "gun"
TOOL.ClientConVar[ "id" ] = "12.7mmMG"

TOOL.ClientConVar[ "data1" ] = "12.7mmMG"
TOOL.ClientConVar[ "data2" ] = "AP"
TOOL.ClientConVar[ "data3" ] = 0
TOOL.ClientConVar[ "data4" ] = 0
TOOL.ClientConVar[ "data5" ] = 0
TOOL.ClientConVar[ "data6" ] = 0
TOOL.ClientConVar[ "data7" ] = 0
TOOL.ClientConVar[ "data8" ] = 0
TOOL.ClientConVar[ "data9" ] = 0
TOOL.ClientConVar[ "data10" ] = 0

cleanup.Register( "acfmenu" )

if CLIENT then	
	language.Add( "Tool.acfmenu.name", "Armored Combat Framework" )
	language.Add( "Tool.acfmenu.desc", "Spawn the Armored Combat Framework weapons and ammo" )
	language.Add( "Tool.acfmenu.0", "Left click to spawn the entity of your choice, Right click to link an entity to another (+Use to unlink)" )
	language.Add( "Tool.acfmenu.1", "Right click to link the selected sensor to a pod" )
	
	language.Add( "Undone_ACF Entity", "Undone ACF Entity" )
	language.Add( "SBoxLimit_acf_gun", "You've reached the ACF Guns limit!" )
	language.Add( "SBoxLimit_acf_rack", "You've reached the ACF Launchers limit!" )
	language.Add( "SBoxLimit_acf_ammo", "You've reached the ACF Explosives limit!" )
	language.Add( "SBoxLimit_acf_sensor", "You've reached the ACF Sensors limit!" )

	/*------------------------------------
		BuildCPanel
	------------------------------------*/
	function TOOL.BuildCPanel( CPanel )
	
		local pnldef_ACFmenu = vgui.RegisterFile( "ACF/Client/cl_ACFMenu_gui.lua" )
		
		// create
		local DPanel = vgui.CreateFromTable( pnldef_ACFmenu )
		CPanel:AddPanel( DPanel )
	
	end
	
else

	
end

function TOOL:LeftClick( trace )

	if (CLIENT) then return true end

	if ( !trace.Entity:IsValid() && !trace.Entity:IsWorld() ) then return false end
	
	local ply = self:GetOwner()
	local Type = self:GetClientInfo( "type" )
	local Id = self:GetClientInfo( "id" )
	
	local SpawnPos = trace.HitPos
	local DupeClass = duplicator.FindEntityClass( ACF.Weapons[Type][Id]["ent"] ) 
	if ( DupeClass ) then
		local ArgTable = {}
			ArgTable[2] = trace.HitNormal:Angle():Up():Angle()
			ArgTable[1] = trace.HitPos + trace.HitNormal*32
		local ArgList = list.Get("ACFCvars")
		for Number, Key in pairs( ArgList[ACF.Weapons[Type][Id]["ent"]] ) do 		--Reading the list packaged with the ent to see what client CVar it needs
			ArgTable[ Number+2 ] = self:GetClientInfo( Key )
		end
		
		local Feedback = nil
		if ( trace.Entity:GetClass() == ACF.Weapons[Type][Id]["ent"] and trace.Entity.CanUpdate ) then
			table.insert(ArgTable,1,ply)
			Feedback = trace.Entity:Update( ArgTable )
		else
			local Ent = DupeClass.Func(ply, unpack(ArgTable))		--Using the Duplicator entity register to find the right factory function
			Ent:Activate()
			Ent:GetPhysicsObject():Wake() 
		end
		
		if Feedback != nil then
			self:GetOwner():SendLua( string.format( "GAMEMODE:AddNotify(%q,%s,7)", Feedback, "NOTIFY_ERROR" ) )
		end
			
		return true
	else
		print("Didn't find entity duplicator records")
	end

end

function TOOL:RightClick( trace )

	if !trace.Entity || !trace.Entity:IsValid() then
	return false end

	if (CLIENT) then return true end
	
	if self:GetOwner():KeyDown( IN_USE ) then
	
		if (self:GetStage() == 0) and trace.Entity.IsMaster then
			self.Master = trace.Entity
			self:SetStage(1)
			return true
		elseif self:GetStage() == 1 then
			local Error = self.Master:Unlink( trace.Entity )
			if !Error then
				self:GetOwner():SendLua( "GAMEMODE:AddNotify('Unlink Succesful', NOTIFY_GENERIC, 7);" )
			elseif Error != nil then
				self:GetOwner():SendLua( string.format( "GAMEMODE:AddNotify(%q,%s,7)", Error, "NOTIFY_ERROR" ) )
			else
				self:GetOwner():SendLua( "GAMEMODE:AddNotify('Unlink Failed', NOTIFY_GENERIC, 7);" )
			end
			self:SetStage(0)
			self.Master = nil
			return true
		else
			return false
		end
		
	else
	
		if (self:GetStage() == 0) and trace.Entity.IsMaster then
			self.Master = trace.Entity
			self:SetStage(1)
			return true
		elseif self:GetStage() == 1 then
			local Error = self.Master:Link( trace.Entity )
			if !Error then
				self:GetOwner():SendLua( "GAMEMODE:AddNotify('Link Succesful', NOTIFY_GENERIC, 7);" )
			elseif Error != nil then
				self:GetOwner():SendLua( string.format( "GAMEMODE:AddNotify(%q,%s,7)", Error, "NOTIFY_ERROR" ) )
			else
				self:GetOwner():SendLua( "GAMEMODE:AddNotify('Link Failed', NOTIFY_GENERIC, 7);" )
			end
			self:SetStage(0)
			self.Master = nil
			return true
		else
			return false
		end

	end
	
end

function TOOL:Reload( trace )
	
	
end

function TOOL:Think()
	
	
end


