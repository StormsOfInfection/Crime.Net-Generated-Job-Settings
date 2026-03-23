_G.CNGJS = _G.CNGJS or {}
CNGJS.mod_path = ModPath
CNGJS.save_path = SavePath .. "CNGJS_options.txt"
CNGJS.main_menu_id = "CNGJS_options_menu"
CNGJS.default_localization_path = CNGJS.mod_path .. "loc/english.json"
CNGJS.settings = {
	active_job_amount = 10,
	active_job_timer = 25,
	normalize_new_job_timers = false
}

-- load settings
function CNGJS:Load()
	local file = io.open(self.save_path, "r")
	if (file) then
		for k, v in pairs(json.decode(file:read("*all"))) do
			self.settings[k] = v
		end
	else
		self:Save()
	end
	return self.settings
end

-- save settings
function CNGJS:Save()
	local file = io.open(self.save_path,"w+")
	if file then
		file:write(json.encode(self.settings))
		file:close()
	end
end

Hooks:Add("LocalizationManagerPostInit","LocalizationManagerPostInit_CNGJS",function(loc)
	loc:load_localization_file(CNGJS.default_localization_path)
end)

Hooks:Add("MenuManagerInitialize", "MenuManagerInitialize_CNGJS", function(menu_manager)

	MenuCallbackHandler.CNGJS_callback_active_job_amount = function(self,item)
		CNGJS.settings.active_job_amount = math.floor(item:value())
		CNGJS:Save()
	end

	MenuCallbackHandler.CNGJS_callback_active_job_timer = function(self,item)
		CNGJS.settings.active_job_timer = math.floor(item:value())
		CNGJS:Save()
	end

	MenuCallbackHandler.CNGJS_callback_normalize_new_job_timers = function(self,item)
		CNGJS.settings.normalize_new_job_timers = item:value() == "on" and true or false
		CNGJS:Save()
	end

	CNGJS:Load()

	MenuHelper:LoadFromJsonFile(CNGJS.mod_path .. "menu/menu_options.json", CNGJS, CNGJS.settings)

end)