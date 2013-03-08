include("shared.lua")

ENT.RenderGroup 		= RENDERGROUP_OPAQUE

function ENT:Draw()
	self:DoNormalDraw()
    Wire_Render(self.Entity)
end

function ENT:DoNormalDraw()
	local e = self.Entity
	if (LocalPlayer():GetEyeTrace().Entity == e and EyePos():Distance(e:GetPos()) < 256) then
		local Tracer = ""
		if self:GetNetworkedInt("Tracer") > 0 then Tracer = "-T" end
		local txt = self:GetNetworkedString("AmmoID").." : " ..self:GetNetworkedString("Ammo").. "\nRound Type : "..self:GetNetworkedString("AmmoType")..Tracer.."\n"
		self.AmmoString = ACF.RoundTypes[self:GetNetworkedString("AmmoType")]["cratetxt"]
		local Ammotxt = self:AmmoString()
		if (not game.SinglePlayer()) then
			local PlayerName = self:GetPlayerName()
			txt = txt .."".. Ammotxt .. "\n(" .. PlayerName .. ")"
		end
		AddWorldTip(e:EntIndex(),txt,0.5,e:GetPos(),e)
	end
	e:DrawModel()
end

function ENT:AmmoString()

	return ""
end

function ENT:Think()
	if (CurTime() >= (self.NextRBUpdate or 0)) then
	    self.NextRBUpdate = CurTime() + math.random(30,100)/10 --update renderbounds every 3 to 10 seconds
		Wire_UpdateRenderBounds(self.Entity)
	end
end
