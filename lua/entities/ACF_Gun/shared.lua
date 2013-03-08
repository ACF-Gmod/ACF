ENT.Type 			= "anim"
ENT.Base 			= "base_gmodentity"  
ENT.Author			= "Kafouille"
 
ENT.Spawnable		= false
ENT.AdminSpawnable	= false

function ENT:GetOverlayText()
	local name = self.Entity:GetNetworkedString("WireName")
	local GunType = self.Entity:GetNetworkedBeamString("GunType")
	local Ammo = self.Entity:GetNetworkedBeamInt("Ammo")
	local RoundType = self.Entity:GetNetworkedBeamString("Type")
	local Mass = self.Entity:GetNetworkedBeamInt("Mass")/100
	local Filler =self.Entity:GetNetworkedBeamInt("Filler")/100
	local Propellant = self.Entity:GetNetworkedBeamInt("Propellant")/1000
	local txt = GunType.." : "..Ammo.." : \nRound Type : "..RoundType.."\nRound Mass : "..Mass.."\nFiller Mass : "..Filler.."\nPropellant : "..Propellant or ""
	if (not game.SinglePlayer()) then
		local PlayerName = self:GetPlayerName()
		txt = txt .. "\n(" .. PlayerName .. ")"
	end
	if(name and name ~= "") then
	    if (txt == "") then
	        return "- "..name.." -"
	    end
	    return "- "..name.." -\n"..txt
	end
	return txt
end


