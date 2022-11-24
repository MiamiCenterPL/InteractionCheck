_G.InteractionCheck = _G.InteractionCheck or {}
InteractionCheck.mod_path = ModPath
InteractionCheck.loc_path = ModPath.."/loc/english.txt"
InteractionCheck.save_path = SavePath .. 'InteractionCheck.txt'
InteractionCheck.options_path = ModPath .. 'menu/options.txt'
InteractionCheck.settings = InteractionCheck.settings or {interaction_check = true, interaction_check_debug = false}
function InteractionCheck:load()
	local file = io.open(self.save_path, 'r')
	if file then
		for k, v in pairs(json.decode(file:read('*all'))) do
			self.settings[k] = v
		end
		file:close()
	else
		InteractionCheck:save()
	end
end

function InteractionCheck:save()
	local file = io.open(self.save_path, 'w+')
	if file then
		file:write(json.encode(self.settings))
		file:close()
	end
end

Hooks:Add("LocalizationManagerPostInit", "InteractionCheck_LocalizationManagerPostInit", function( loc )
	loc:load_localization_file(InteractionCheck.loc_path)
end)

Hooks:Add( "MenuManagerInitialize", "InteractionCheck_MenuManagerInitialize", function(menu_manager)
	MenuCallbackHandler.InteractionCheck_check_clbk = function(this, item)
		InteractionCheck.settings[item:name()] = item:value() == "on" and true or false
	end

	MenuCallbackHandler.InteractionCheck_callback_options_closed = function(self)
		InteractionCheck:save()
	end

	InteractionCheck:load()
	MenuHelper:LoadFromJsonFile(InteractionCheck.options_path, InteractionCheck, InteractionCheck.settings)
end)