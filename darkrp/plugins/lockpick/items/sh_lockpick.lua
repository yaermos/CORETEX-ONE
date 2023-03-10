
-- the code organization has gone awol
ITEM.name = "Отмычка"
ITEM.description = "используется для октрытия замков."
ITEM.price = 20
ITEM.model = "models/weapons/w_crowbar.mdl"
ITEM.functions.Use = {
	OnRun = function(itemTable)
		local chance = math.random(1, 100)
		local client = itemTable.player
		local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector() * 96
			data.filter = client
		local target = util.TraceLine(data).Entity
		for _, v in ipairs(ents.FindByClass("ix_combinelock")) do
			if (target == v.door) then
				chance = 99

				if (IsValid(target) and target:IsDoor()) then
					itemTable.bBeingUsed = true
					client:SetAction("Lock-picking...", 6)

					client:DoStaredAction(target, function()
						client:EmitSound("weapons/357/357_reload3.wav")
						client:Notify("Отмычка сломалась.")
						itemTable:Remove()
					end, 6, function()
						client:SetAction()
						itemTable.bBeingUsed = false
					end)
				else
					itemTable.player:Notify("Это неверная дверь для взлома.")
				end
				return false	
			end
		end
		if (IsValid(target) and target:IsDoor()) then
			itemTable.bBeingUsed = true
			client:SetAction("Взламываю...", 6)

			client:DoStaredAction(target, function()
				target:Fire("open", "", 0)
				target:Fire("setanimation", "open", 0)
				if (target:IsLocked()) then
					target:Fire("unlock", "", 0)
				end
				target:EmitSound("doors/latchunlocked1.wav")
				client:Notify("Вы успешко взломали дверь.")
				
				
				end, 6, function()
					client:SetAction()
					itemTable.bBeingUsed = false
				end)
		else
			itemTable.player:Notify("Это неверная дверь для взлома.")
		end
			

		return false
		end,
	OnCanRun = function(itemTable)
		return !IsValid(itemTable.entity) or itemTable.bBeingUsed
	end
}

function ITEM:CanTransfer(inventory, newInventory)
	return self.bBeingUsed
end
