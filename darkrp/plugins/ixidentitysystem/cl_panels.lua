--[[-------------------------------------------------------------------------
					CID VIEW
				---------------------------------------------------------------------------]]
surface.CreateFont("BudgetLabelSmall", {
	font = "BudgetLabel",
	size = 15,
	extended = true,
	weight = 500
})

local PANEL = {}

function PANEL:Init()
	ix.gui.cidview = self
	self:SetSize(ScrW() / 2, ScrH() / 2)
	self:Center()
	self:MakePopup()
	self:SetBackgroundBlur(true)
	self.SidePanel = self:Add("DPanel")
	self.SidePanel:Dock(LEFT)
	self:SetTitle("")
	--Panel Title
	self.SidePanelTextTitle = self.SidePanel:Add("DLabel")
	self.SidePanelTextTitle:SetContentAlignment(1)
	self.SidePanelTextTitle:SetFont("ixBigFont")
	self.SidePanelTextTitle:SetText("Информация:")
	self.SidePanelTextTitle:Dock(TOP)
	self.SidePanelTextTitle:SizeToContents()
	--Panel Information about Citizen
	self.SidePanelTextName = self.SidePanel:Add("DLabel")
	self.SidePanelTextName:SetContentAlignment(5)
	self.SidePanelTextName:SetFont("ixSmallFont")
	self.SidePanelTextName:SetText("Citizen Name: John Doe\nCitizen ID: 11111\nIssue Date: 10/28/18\nIssuing Officer: MPF-GAY.10100")
	self.SidePanelTextName:Dock(TOP)
	self.SidePanelTextName:SizeToContents()
	local w, h = self.SidePanel:GetSize()
	self.SidePanel:SetSize(300, h)
	self.AddRecordButton = self:Add("DButton")
	self.AddRecordButton:SetText("Добавить запись")
	self.AddRecordButton:Dock(BOTTOM)

	function self.AddRecordButton:DoClick()
		local ui = vgui.Create("DFrame")
		ui:SetSize(ScrW() / 3, ScrH() / 7)
		ui:Center()
		ui:SetTitle("")
		ui:MakePopup()
		local titlebox = ui:Add("DTextEntry")
		titlebox:Dock(TOP)
		titlebox:SetText("Название записи")
		local reasonbox = ui:Add("DTextEntry")
		reasonbox:Dock(TOP)
		reasonbox:SetText("Причина записи")
		reasonbox:SetTall(50)
		reasonbox:SetMultiline(true)
		local submitbutton = ui:Add("DButton")
		submitbutton:Dock(BOTTOM)
		submitbutton:SetText("Подтвердить")
		local numberwang = ui:Add("DNumberWang")
		numberwang:Dock(BOTTOM)

		function submitbutton:DoClick()
			ix.gui.cidview:AddRecord(titlebox:GetText(), reasonbox:GetText(), LocalPlayer():Name(), numberwang:GetValue())
			ui:Close()
		end
	end

	self.ListView = self:Add("DListView")
	self.ListView:Dock(FILL)
	self.ListView:AddColumn("Запись")
	self.ListView:AddColumn("Причина")
	self.ListView:AddColumn("Сотрудник по выдаче")
	self.ListView:AddColumn("Очки")
end

function PANEL:SetItem(item)
	ix.gui.cidview.item = item
	ix.gui.cidview.itemid = item.id
	self.SidePanelTextName:SetText("Имя: " .. item:GetData("citizen_name", "Unissued") .. "\n" .. "ID: " .. item:GetData("cid", "000000") .. "\n" .. "Дата выпуска: " .. item:GetData("issue_date", "Unissued") .. "\n" .. "Сотрудник по выдаче: " .. item:GetData("officer", "Неизвестно") .. "\nОчки лояльности: " .. item:GetData("points", 0))
	self.SidePanelTextName:SizeToContents()

	for k, v in pairs(item:GetData("record", {})) do
		local line = self.ListView:AddLine(v[1], v[2], v[3], v[4])

		if v[4] > 0 then
			function line.Paint(this, w, h)
				surface.SetDrawColor(Color(0, 255, 0, 50))
				surface.DrawRect(0, 0, w, h)
			end
		elseif v[4] < 0 then
			function line.Paint(this, w, h)
				surface.SetDrawColor(Color(255, 0, 0, 50))
				surface.DrawRect(0, 0, w, h)
			end
		else
			function line.Paint(this, w, h)
				surface.SetDrawColor(Color(50, 50, 50, 50))
				surface.DrawRect(0, 0, w, h)
			end
		end

		line.id = k
	end

end

function PANEL:AddRecord(title, reason, ply, points)
	local line = self.ListView:AddLine(title, reason, ply, points)

	if points > 0 then
		function line.Paint(this, w, h)
			surface.SetDrawColor(Color(0, 255, 0, 150))
			surface.DrawRect(0, 0, w, h)
		end
	elseif points < 0 then
		function line.Paint(this, w, h)
			surface.SetDrawColor(Color(255, 0, 0, 150))
			surface.DrawRect(0, 0, w, h)
		end
	else
		function line.Paint(this, w, h)
			surface.SetDrawColor(Color(50, 50, 50, 150))
			surface.DrawRect(0, 0, w, h)
		end
	end

	--Add additional logic for sending a net message to the server to add it to item data.
	netstream.Start("IDAddRecord", {title, reason, ply, ix.gui.cidview.itemid, points})
end

function PANEL:RemoveRecord()
	local selLine = self.ListView:GetSelectedLine()
	local panLine = self.ListView:GetLine(selLine)
	--Add additional logic for sending a net message to the server to add it to item data.
	netstream.Start("IDRemoveRecord", {title, reason, ply, ix.gui.cidview.itemid, panLine.id})
	panLine:Remove()
end

vgui.Register("ixRecordPanel", PANEL, "DFrame")
--[[-------------------------------------------------------------------------
			CID CREATOR
		---------------------------------------------------------------------------]]
local PANEL = {}

function PANEL:Init()
	ix.gui.cidcreator = self
	self:SetSize(ScrW() / 4, ScrH() / 7)
	self:Center()
	self:MakePopup()
	self:SetBackgroundBlur(true)
	self:SetTitle("")
	self.toptext = self:Add("DLabel")
	self.toptext:SetContentAlignment(5)
	self.toptext:Dock(TOP)
	self.toptext:SetText("Центр автоматической регистрации")
	self.toptext:SetExpensiveShadow(2)
	self.toptext:SetFont("ixSmallFont")
	self.toptext:SetTall(32)
	self.nametext = self:Add("DLabel")
	self.nametext:SetContentAlignment(5)
	self.nametext:Dock(TOP)
	self.nametext:SetText("Имя ввода")
	self.nametext:SetExpensiveShadow(2)
	self.nametext:SetFont("ixSmallFont")
	self.nameinput = self:Add("DTextEntry")
	self.nameinput:Dock(TOP)
	self.itemswang = self:Add("DComboBox")
	self.itemswang:Dock(BOTTOM)
	self.itemswang:SetValue("Или выберите миграционный билет.")

	self.itemswang.OnSelect = function()
		self.nameinput:SetDisabled(true)
		self.nameinput:SetText("")
	end

	self.submitbutton = self:Add("DButton")
	self.submitbutton:Dock(BOTTOM)
	self.submitbutton:SetText("Подтвердить")

	for k, v in pairs(LocalPlayer():GetCharacter():GetInventory():GetItems()) do
		if v.uniqueID == "transfer_papers" then
			self.itemswang:AddChoice(v:GetData("citizen_name", "Без имени?"))
		end
	end

	function self.submitbutton:DoClick()
		if string.len(ix.gui.cidcreator.nameinput:GetText()) == 0 and not ix.gui.cidcreator.itemswang:GetSelected() then
			return
		end

		if string.len(ix.gui.cidcreator.nameinput:GetText()) > 1 then
			netstream.Start("SubmitNewCID", {ix.gui.cidcreator.nameinput:GetText()})
			ix.gui.cidcreator:Close()
		elseif ix.gui.cidcreator.itemswang:GetSelected() ~= "Or select a transfer card." then
			netstream.Start("SubmitNewCID", {ix.gui.cidcreator.itemswang:GetSelected()})
			ix.gui.cidcreator:Close()
		else
			LocalPlayer():Notify("You need to input a name or select a transfer card!")
		end
	end
end

vgui.Register("ixCIDCreater", PANEL, "DFrame")
