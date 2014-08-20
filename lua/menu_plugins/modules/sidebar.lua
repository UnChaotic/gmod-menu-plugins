local PANEL = {}

local OUT = true
local IN = false

function PANEL:Init()
	self:SetSize(ScrW()*.175, ScrH() *.75)
	self:Center()
	self:SetPos(ScrW() - self:GetWide(), select(2, self:GetPos()))

	self:ShowCloseButton(false)
	self:SetDraggable(false)
	self:SetTitle("")

	self.tree = vgui.Create("DTree", self)
	self.tree:Dock(FILL)

	self.out = false
	self:KillFocus()
end
function PANEL:Moove(outin)
	if outin == OUT and not self.out then
		self:MoveTo(ScrW(), select(2, self:GetPos()), .1, 0, 2)
		self.out = true
	elseif outin == IN and self.out then
		self:MoveTo(ScrW() - self:GetWide(), select(2, self:GetPos()), .1, 0, 2)
		self.out = false
	end
end

function PANEL:Think()
	self.posx, self.posy = self:GetPos()
	self.sizex, self.sizey = self:GetSize()
	local mx, my = gui.MouseX(), gui.MouseY()
	self.hovered = mx > self.posx and (my > self.posy and my < (ScrH() - self.posy))

	if self.hovered then
		self:Moove(IN)
	elseif not self.hovered then
		self:Moove(OUT)
	end
end

derma.DefineControl("menupSidebar", "Sidebar for Menu Plugins", PANEL, "DFrame")

timer.Simple(3, function() vgui.Create("menupSidebar"):MakePopup() end)