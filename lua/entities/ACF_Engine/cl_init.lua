include("shared.lua")

ENT.RenderGroup 		= RENDERGROUP_OPAQUE

ENT.AutomaticFrameAdvance = true 

function ENT:Draw()
	self:DoNormalDraw()
	self:DrawModel()
    Wire_Render(self.Entity)
end

function ENT:DoNormalDraw()
	local e = self.Entity
	if (LocalPlayer():GetEyeTrace().Entity == e and EyePos():Distance(e:GetPos()) < 256) then
		if(self:GetOverlayText() ~= "") then
			AddWorldTip(e:EntIndex(),self:GetOverlayText(),0.5,e:GetPos(),e)
		end
	end
end

function ENT:GetOverlayText()
	local name = self.Entity:GetNetworkedString("WireName")
	local Type = self.Entity:GetNetworkedBeamString("Type")
	local Power = self.Entity:GetNetworkedBeamInt("Power")
	local Torque = self.Entity:GetNetworkedBeamInt("Torque")
	local MinRPM = self.Entity:GetNetworkedBeamInt("MinRPM")
	local MaxRPM = self.Entity:GetNetworkedBeamInt("MaxRPM")
	local LimitRPM = self.Entity:GetNetworkedBeamInt("LimitRPM")
	local txt = Type.."\nMax Power : "..Power.."KW / "..math.Round(Power*1.34).."HP \nMax Torque : "..Torque.."N/m / "..math.Round(Torque*0.73).."ft-lb \nPowerband : "..MinRPM.." - "..MaxRPM.."RPM\nRedline : "..LimitRPM.."RPM" or ""
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

function ACFEngineGUICreate( Table )
	
	acfmenupanel:CPanelText("Name", Table.name)
	
	acfmenupanel.CData.DisplayModel = vgui.Create( "DModelPanel", acfmenupanel.CustomDisplay )
		acfmenupanel.CData.DisplayModel:SetModel( Table.model )
		acfmenupanel.CData.DisplayModel:SetCamPos( Vector( 250 , 500 , 250 ) )
		acfmenupanel.CData.DisplayModel:SetLookAt( Vector( 0, 0, 0 ) )
		acfmenupanel.CData.DisplayModel:SetFOV( 20 )
		acfmenupanel.CData.DisplayModel:SetSize(acfmenupanel:GetWide(),acfmenupanel:GetWide())
		acfmenupanel.CData.DisplayModel.LayoutEntity = function( panel , entity ) end
	acfmenupanel.CustomDisplay:AddItem( acfmenupanel.CData.DisplayModel )
		
	acfmenupanel:CPanelText("Desc", Table.desc)
	
	if (Table.iselec == true )then
		acfmenupanel:CPanelText("Power", "Peak Power : "..Table.elecpower.." kW / "..math.Round(Table.elecpower*1.34).." HP @ "..(Table.peakmaxrpm).." RPM")
	else	
		acfmenupanel:CPanelText("Power", "Peak Power : "..(math.floor(Table.torque * Table.peakmaxrpm / 9548.8)).." kW / "..math.Round(math.floor(Table.torque * Table.peakmaxrpm / 9548.8)*1.34).." HP @ "..(Table.peakmaxrpm).." RPM")
	end

	acfmenupanel:CPanelText("Torque", "Peak Torque : "..(Table.torque).." n/m  / "..math.Round(Table.torque*0.73).." ft-lb")
	acfmenupanel:CPanelText("RPM", "Idle : "..(Table.idlerpm).." RPM\nIdeal RPM Range : "..(Table.peakminrpm).."-"..(Table.peakmaxrpm).." RPM\nRedline : "..(Table.limitprm).." RPM")
	acfmenupanel:CPanelText("Weight", "Weight : "..(Table.weight).." kg")
	
	acfmenupanel.CustomDisplay:PerformLayout()
	
end