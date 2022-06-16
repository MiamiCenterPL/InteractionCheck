	Hooks:RemovePostHook("check_interaction_obstacles")
	local dir = Vector3()
	local ignored_units = {
		fish = {"Idstring(@ID43dd7534e20f2963@)", "Idstring(@ID165a3c90065493f6@)", "Idstring(@IDffedb8a6e44b1615@)"}, --fish (Yacht Heist) (harddrive, money bundles)
		crojob2 = {"Idstring(@ID4e2b16fa53a8d1f3@)", "Idstring(@IDf1461ef41b1bce71@)", "Idstring(@ID7dc5f755ea3f7d65@)", "Idstring(@ID6964595ea36b2825@)", "Idstring(@ID18a8927023a02105@)", "Idstring(@IDac51bbdbcccdb234@)", "Idstring(@ID815dd21893ac11b5@)"}, --BombHeist (Meth ingridients, bomb parts)
		dah = {"Idstring(@ID0727920b09b4bb19@)", "Idstring(@ID66943d8696d23a80@)", "Idstring(@ID1a7e58366dd21dbb@)", "Idstring(@ID2274fdfb1d14c18f@)", "Idstring(@ID36506b0e7109039a@)", "Idstring(@IDba78978ec6db4407@)", "Idstring(@ID4dd7012fe83e7c95@)", "Idstring(@IDc12bc6ddf09a7a56@)", "Idstring(@ID0c1ea5bfa95cb271@)"}, --Diamond Heist (Loot inside the vault)
		mus = {"Idstring(@IDa163786a6ddb0291@)"}, --The Diamond (bodybag case)
		jewelry_store = {"Idstring(@IDe8088e3bdae0ab9e@)", "Idstring(@ID05956ff396f3c58e@)"}, --Jewelry Store (gage_package)
		kenaz = {"Idstring(@ID963b39ffe1ab38d5@)"}, --Golden Grin Casino (Sleeping gas)
		sah = {"Idstring(@ID4989e002f366b351@)"}, --Schacklethorne Mansion (Black Plate)
		ukrainian_job = {"Idstring(@IDe8088e3bdae0ab9e@)", "Idstring(@ID86a3676e0b178dda@)"}, --UkrainianJob (gage_package, jewelry)
		dark = {"Idstring(@ID29c64eba7ea1bb4f@)", "Idstring(@IDffedb8a6e44b1615@)", "Idstring(@ID9c0e4f7e2193a163@)"}, --Murkystation (termite past, harddrive)
		firestarter_1 = {"Idstring(@ID584bea03f3b5d712@)", "Idstring(@ID34d05ca941b5ebfe@)"}, --Firestarter day 1 (Truck drill and C4)
		bex = {"Idstring(@ID9e05f9d8ca3ef529@)", "Idstring(@ID40c5b07b6561cc1f@)", "Idstring(@ID70cc9cf82e4c87a9@)"}, --San martin bank (Manager safe)
		welcome_to_the_jungle_2 = {"Idstring(@ID641e583b23d2136a@)"}, --Big Oil day 2 jewellery
		mex = {"Idstring(@ID9819a50244591ecf@)", "Idstring(@IDd90bf4a3a96e4d3b@)", "Idstring(@ID919af1f7f773ed60@)"}, --Crates and C4
		nail = {"Idstring(@ID8fa207632e271d4b@)"}, --lab Rats pills
		brb = {"Idstring(@ID75fac870cd2c4062@)", "Idstring(@ID22152b498be8fdbc@)"}, --Brooklyn Bank C4
		hox_2 = {"Idstring(@IDe4b9625bac2807e5@)", "Idstring(@ID9c0e4f7e2193a163@)"}, --Hox Breakout Server and harddrive.
		vit = {"Idstring(@IDc06b518a90138065@)"}, --White House PEOC PC
		pent = {"Idstring(@ID2286ce1b2545957b@)", "Idstring(@IDffedb8a6e44b1615@)", "Idstring(@IDb4d77ec3cc8189f3@)", "Idstring(@IDcc29feaebf2838f4@)"} --Mountain Master (vent, harddrive)
	}
	local last_printed_unit = "none"
	local level_id = Global.game_settings.level_id
	Hooks:PostHook(BaseInteractionExt, 'can_select', 'check_interaction_obstacles', function(self, player)
		if not InteractionCheck.settings["interaction_check"] or
		self._unit:interaction().tweak_data == "corpse_alarm_pager" or
		ignored_units[level_id] and table.contains(ignored_units[level_id], tostring(self._unit:name())) or
		not self._unit:interaction():active() then return end
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
					log(tostring(self._unit:name()))
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
--[[
local units = World:find_units_quick("all")

for _, unit in pairs(units) do
	if alive(unit) and unit:interaction() and unit:interaction():active() then
		local carry_data = unit:carry_data()
		local weapon_case = unit:interaction().tweak_data == "weapon_case"
		local pickup_id = unit:base() and unit:base().small_loot
		local int_data = unit:interaction().tweak_data and tweak_data.interaction[unit:interaction().tweak_data]
		local special = unit:interaction()._special_equipment or int_data and int_data.special_equipment_block
		if carry_data or pickup_id or special or weapon_case and unit:unit_data().unit_id ~= 0 then
			managers.hud:add_waypoint(unit:unit_data().unit_id, {
				distance = true,
				state = "sneak_present",
				present_timer = 0,
				text = "none",
				icon = "pd2_bodybag",
				position = unit:position()
			})
		end
	end
end

Hooks:RemovePostHook("debug_find_units_wp_remove")
Hooks:PostHook(ObjectInteractionManager, "remove_unit", "debug_find_units_wp_remove", function(self, unit)
	if unit:unit_data() and unit:unit_data().unit_id and managers.hud:get_waypoint_data(unit:unit_data().unit_id) then
		log("Removed ID = "..tostring(unit:unit_data().unit_id))
		managers.hud:remove_waypoint(unit:unit_data().unit_id)
	end
end)

--Log unit ID that player is looking at
	local player = managers.player:local_player()
	local result
	if player then 
		result = player:movement():current_state()._fwd_ray
	end
	log(tostring(result.unit:unit_data().unit_id))

local unit = managers.worlddefinition:get_unit(100496)
managers.game_play_central:mission_disable_unit(unit)
]]