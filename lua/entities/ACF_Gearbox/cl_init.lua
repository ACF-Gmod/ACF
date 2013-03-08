include("shared.lua")

ENT.RenderGroup 		= RENDERGROUP_OPAQUE
local maxtorque = 0  -- this is for the max torque output on the tooltip - Wrex
function ENT:Draw()
	self:DoNormalDraw()
    Wire_Render(self.Entity)
end

function ENT:DoNormalDraw()
	local e = self.Entity
	if (LocalPlayer():GetEyeTrace().Entity == e and EyePos():Distance(e:GetPos()) < 256) then
		if not self.DisplayString then self.DisplayString = "" end
		AddWorldTip(e:EntIndex(),self.DisplayString,0.5,e:GetPos(),e)
	end
	e:DrawModel()
end

function ACFGearboxCreateDisplayString( data, Timer )
	
	local Ent = data:ReadEntity()
	local Id = data:ReadString()
	local List = list.Get("ACFEnts")
	local FinalGear = data:ReadShort()/100
	
	Ent.DisplayString = List["Mobility"][Id]["name"].."\n"
	for I = 1,List["Mobility"][Id]["gears"] do
		Ent.DisplayString = Ent.DisplayString.."Gear "..I.." : "..tostring(data:ReadShort()/100).."\n"
	end
	Ent.DisplayString = Ent.DisplayString.."Final Gear : "..tostring(FinalGear).."\n Maximum Torque Rating: "..(maxtorque).."n-m / "..math.Round(maxtorque*0.73).."ft-lb"
	if data:ReadBool() then
		Ent:SetBodygroup(1,1)
	else
		Ent:SetBodygroup(1,0)
	end
	
	if (not game.SinglePlayer()) then
		local PlayerName = Ent:GetPlayerName()
		Ent.DisplayString = Ent.DisplayString .."(" .. PlayerName .. ")"
	end
 
end
usermessage.Hook( "ACFGearbox_SendRatios", ACFGearboxCreateDisplayString )

function ACFGearboxGUICreate( Table )

	if not acfmenupanel.GearboxData then
		acfmenupanel.GearboxData = {}
	end
	if not acfmenupanel.GearboxData[Table.id] then
		acfmenupanel.GearboxData[Table.id] = {}
		acfmenupanel.GearboxData[Table.id]["GearTable"] = Table.geartable
	end
		
	acfmenupanel:CPanelText("Name", Table.name)
	
	acfmenupanel.CData.DisplayModel = vgui.Create( "DModelPanel", acfmenupanel.CustomDisplay )
		acfmenupanel.CData.DisplayModel:SetModel( Table.model )
		acfmenupanel.CData.DisplayModel:SetCamPos( Vector( 250 , 500 , 250 ) )
		acfmenupanel.CData.DisplayModel:SetLookAt( Vector( 0, 0, 0 ) )
		acfmenupanel.CData.DisplayModel:SetFOV( 20 )
		acfmenupanel.CData.DisplayModel:SetSize(acfmenupanel:GetWide(),acfmenupanel:GetWide())
		acfmenupanel.CData.DisplayModel.LayoutEntity = function( panel , entity ) end
	acfmenupanel.CustomDisplay:AddItem( acfmenupanel.CData.DisplayModel )
	
	acfmenupanel:CPanelText("Desc", Table.desc)	--Description (Name, Desc)
	
	for ID,Value in pairs(acfmenupanel.GearboxData[Table.id]["GearTable"]) do
		if ID > 0 then
			ACF_GearsSlider(ID, Value, Table.id)
		elseif ID == -1 then
			ACF_GearsSlider(10, Value, Table.id, "Final Drive")
		end
	end
	
	acfmenupanel:CPanelText("Desc", Table.desc)
	acfmenupanel:CPanelText("MaxTorque", "Clutch Maximum Torque Rating : "..(Table.maxtq).."n-m / "..math.Round(Table.maxtq*0.73).."ft-lb")
	acfmenupanel:CPanelText("Weight", "Weight : "..Table.weight.."kg")
	
	acfmenupanel.CustomDisplay:PerformLayout()
	maxtorque = Table.maxtq
end

function ACF_GearsSlider(Gear, Value, ID, Desc)

	if Gear and not acfmenupanel["CData"][Gear] then	
		acfmenupanel["CData"][Gear] = vgui.Create( "DNumSlider", acfmenupanel.CustomDisplay )
			acfmenupanel["CData"][Gear]:SetText( Desc or "Gear "..Gear )
			acfmenupanel["CData"][Gear]:SetMin( -1 )
			acfmenupanel["CData"][Gear]:SetMax( 1 )
			acfmenupanel["CData"][Gear]:SetDecimals( 2 )
			acfmenupanel["CData"][Gear]["Gear"] = Gear
			acfmenupanel["CData"][Gear]["ID"] = ID
			acfmenupanel["CData"][Gear]:SetValue(Value)
			RunConsoleCommand( "acfmenu_data"..Gear, Value )
			acfmenupanel["CData"][Gear].OnValueChanged = function( slider, val )
				acfmenupanel.GearboxData[slider.ID]["GearTable"][slider.Gear] = val
				RunConsoleCommand( "acfmenu_data"..Gear, val )
			end
		acfmenupanel.CustomDisplay:AddItem( acfmenupanel["CData"][Gear] )
	end

end