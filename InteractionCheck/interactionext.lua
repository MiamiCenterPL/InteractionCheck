	Hooks:RemovePostHook("check_interaction_obstacles")
	local dir = Vector3()
	local ignored_units = {
		fish = {"Idstring(@ID43dd7534e20f2963@)", "Idstring(@ID165a3c90065493f6@)", "Idstring(@IDffedb8a6e44b1615@)"},
		crojob2 = {"Idstring(@ID4e2b16fa53a8d1f3@)", "Idstring(@IDf1461ef41b1bce71@)", "Idstring(@ID7dc5f755ea3f7d65@)", "Idstring(@ID6964595ea36b2825@)", "Idstring(@ID18a8927023a02105@)", "Idstring(@IDac51bbdbcccdb234@)", "Idstring(@ID815dd21893ac11b5@)", "Idstring(@IDdafe5d9d6094c914@)", "Idstring(@ID4111102f51e6d1d3@)", "Idstring(@ID498cdfa14f8cde16@)"},
		dah = {"Idstring(@ID0727920b09b4bb19@)", "Idstring(@ID66943d8696d23a80@)", "Idstring(@ID1a7e58366dd21dbb@)", "Idstring(@ID2274fdfb1d14c18f@)", "Idstring(@ID36506b0e7109039a@)", "Idstring(@IDba78978ec6db4407@)", "Idstring(@ID4dd7012fe83e7c95@)", "Idstring(@IDc12bc6ddf09a7a56@)", "Idstring(@ID0c1ea5bfa95cb271@)"},
		mus = {"Idstring(@IDa163786a6ddb0291@)"},
		jewelry_store = {"Idstring(@IDe8088e3bdae0ab9e@)", "Idstring(@ID05956ff396f3c58e@)"},
		kenaz = {"Idstring(@ID963b39ffe1ab38d5@)"},
		sah = {"Idstring(@ID4989e002f366b351@)"},
		ukrainian_job = {"Idstring(@IDe8088e3bdae0ab9e@)", "Idstring(@ID86a3676e0b178dda@)"},
		dark = {"Idstring(@ID29c64eba7ea1bb4f@)", "Idstring(@IDffedb8a6e44b1615@)", "Idstring(@ID9c0e4f7e2193a163@)"},
		firestarter_1 = {"Idstring(@ID584bea03f3b5d712@)", "Idstring(@ID34d05ca941b5ebfe@)", "Idstring(@IDa7b371bf0e3fd30a@)"},
		bex = {"Idstring(@ID9e05f9d8ca3ef529@)", "Idstring(@ID40c5b07b6561cc1f@)", "Idstring(@ID70cc9cf82e4c87a9@)"},
		welcome_to_the_jungle_2 = {"Idstring(@ID641e583b23d2136a@)"},
		mex = {"Idstring(@ID9819a50244591ecf@)", "Idstring(@IDd90bf4a3a96e4d3b@)", "Idstring(@ID919af1f7f773ed60@)"},
		nail = {"Idstring(@ID8fa207632e271d4b@)"},
		brb = {"Idstring(@ID75fac870cd2c4062@)", "Idstring(@ID22152b498be8fdbc@)"},
		hox_2 = {"Idstring(@IDe4b9625bac2807e5@)", "Idstring(@ID9c0e4f7e2193a163@)"},
		vit = {"Idstring(@IDc06b518a90138065@)"},
		pent = {"Idstring(@ID2286ce1b2545957b@)", "Idstring(@IDffedb8a6e44b1615@)", "Idstring(@IDb4d77ec3cc8189f3@)", "Idstring(@IDcc29feaebf2838f4@)"},
		flat = {"Idstring(@ID90b388e6fe8c6416@)", "Idstring(@ID7601731dfdabdf2c@)"},
		rat = {"Idstring(@ID8f59e19e1e45a05e@)", "Idstring(@ID43ed278b1faf89b3@)"},
		alex_3 = {"Idstring(@ID8f59e19e1e45a05e@)", "Idstring(@ID43ed278b1faf89b3@)"},
		peta = {"Idstring(@ID4a630856a90f762d@)"},
		man = {"Idstring(@ID6d7760b41bd418ac@)"},
		ranc = {"Idstring(@ID2cf4f276ce7ba6f5@)", "Idstring(@IDb6e2863ad1e03290@)", "Idstring(@IDa48d01d5a543161e@)"},
		funbank = {"Idstring(@IDda87b024ba345e4d@)"},
		chas = {"Idstring(@ID5422d8b99c7c1b57@)"},
		chca = {"Idstring(@ID2b13736a279f2781@)", "Idstring(@ID7d94e1448303d814@)"},
		sand = {"Idstring(@ID7d3e0296e9345c9c@)"},
		fex = {"Idstring(@IDe56c87bfeaf69aa5@)", "Idstring(@ID85baf322c23157ce@)"},
		glace = {"Idstring(@IDa254a980229502df@)", "Idstring(@IDe6c00dc8c332fa84@)"},
		framing_frame_3 = {"Idstring(@ID9ed5ee9a1ebb1f55@)", "Idstring(@ID9c3047f8cc5c3d14@)", "Idstring(@IDc9b068ac7994ad04@)", "Idstring(@IDd904ebd1e81458a8@)", "Idstring(@ID24118b6b9d2f5f81@)"},
		arena = {"Idstring(@ID5ba31f3f40c8846b@)", "Idstring(@IDce8836fa50916e6f@)"},
		wwh = {"Idstring(@ID0f427be00fb8aacc@)", "Idstring(@IDebdaaafc8f3286e5@)", "Idstring(@ID9552e37e64f33dda@)", "Idstring(@IDc8acf340498b2a2d@)"},
		alex_3 = {"Idstring(@IDb8e23b1e26c4d187@)", "Idstring(@IDa096513e0125488a@)", "Idstring(@ID4ba585b14822a676@)"},
		crojob_3 = {"Idstring(@IDb2f4e7c443be83bc@)", "Idstring(@ID6964595ea36b2825@)", "Idstring(@ID18a8927023a02105@)", "Idstring(@IDac51bbdbcccdb234@)", "Idstring(@ID815dd21893ac11b5@)"},
		crojob_3_night = {"Idstring(@IDb2f4e7c443be83bc@)", "Idstring(@ID6964595ea36b2825@)", "Idstring(@ID18a8927023a02105@)", "Idstring(@IDac51bbdbcccdb234@)", "Idstring(@ID815dd21893ac11b5@)"}
	}
	local ignore_packages = {"jewelry_store", "ukrainian_job", "branchbank", "firestarter_3", "des", "tag", "escape_cafe_day", "chas", "chca", "fex", "pex"}
	local last_printed_unit = "none"
	local level_id = Global.game_settings.level_id
	Hooks:PostHook(BaseInteractionExt, 'can_select', 'check_interaction_obstacles', function(self, player)
		if not InteractionCheck.settings["interaction_check"] or
		self._unit:interaction().tweak_data == "corpse_alarm_pager" or
		ignored_units[level_id] and table.contains(ignored_units[level_id], tostring(self._unit:name())) or
		not self._unit:interaction():active() or
		self._unit:interaction().tweak_data == "gage_assignment" and table.contains(ignore_packages, level_id) then return end
		if not alive(managers.player:player_unit()) then return end
		local from = self:interact_position()
		local to = managers.player:player_unit():camera():position()
		local check_objects = self._unit:ray_objects()
		if check_objects then return end
		mvector3.direction(dir, from, to)
		mvector3.multiply(dir, 15)
		mvector3.add(dir, from)
		local obstructed = World:raycast("ray", dir, to, "ray_type", "bag body", "slot_mask", managers.slot:get_mask("interaction_obstruction"), "ignore_unit", {self._unit, self._unit:parent()}, "report")
		if InteractionCheck.settings["interaction_check_debug"] then
			if obstructed then
				Application:draw_line(dir, to, 1, 0, 0)
				if tostring(self._unit:name()) ~= last_printed_unit then
					log(tostring("[InteractionCheck] Can't interact with: "..tostring(self._unit:name())))
					last_printed_unit = tostring(self._unit:name())
				end
			else
				Application:draw_line(dir, to, 0, 1, 0)
			end
		end
		if obstructed then
			return false
		end
	end)