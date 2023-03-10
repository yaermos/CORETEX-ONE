function touse(self,activator)
	if team.GetName(activator:Team()) == STORAGE.CFG.HackFactions then
		if !self:GetNetVar("crate_timer") then
			self:SetNetVar("crate_timer",60 * STORAGE.CFG.HackTime)

			self.console = ents.Create("crate_console")
			self.console:SetPos(self:GetPos() + Vector(0,10,16.5))
			self.console:Spawn()
			self.console:GetPhysicsObject():EnableMotion(false)	

			timer.Create("crate_timer01", 1, 0, function()
				self:SetNetVar("crate_timer", self:GetNetVar("crate_timer",0) - 1)
				
				if self:GetNetVar("crate_timer") == 0 then
					self.console:Remove()
					self:ResetSequence("open")
					for i = 1, math.random(STORAGE.CFG.ItemMin, STORAGE.CFG.ItemMax) do
						self.ixInventory:Add(STORAGE.CFG.ItemList[math.random( 1, #STORAGE.CFG.ItemList )])
					end
					self:SetNetVar("crate_timer","open")
					timer.Remove("crate_timer01")
				end
			end)
		elseif self:GetNetVar("crate_timer") == "open" then
			ix.storage.Open(activator, self.ixInventory, {
				entity = self,
				name = "Ящик",
				searchText = "Обыскиваю ящик...",
				searchTime = 1
			})
		end
	elseif team.GetName(activator:Team()) == STORAGE.CFG.SecurityFaction and self:GetNetVar("crate_timer") != "open" then 
		timer.Remove("crate_timer01")
		self:SetNetVar("crate_timer",nil)
		SafeRemoveEntity(self.console)
		for k,v in pairs(player.GetAll()) do
			if team.GetName(v:Team()) == STORAGE.CFG.HackFactions then
				v:Notify("Процесс взлома ящика прерван")
			end
		end
	end
end