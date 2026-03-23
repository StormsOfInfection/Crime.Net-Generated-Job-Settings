_G.IncreaseActiveCrimeNetJobs = _G.IncreaseActiveCrimeNetJobs or {}
IncreaseActiveCrimeNetJobs.options_menu = "IncreaseActiveCrimeNetJobs_menu"
IncreaseActiveCrimeNetJobs.ModPath = ModPath
IncreaseActiveCrimeNetJobs.SaveFile = IncreaseActiveCrimeNetJobs.SaveFile or SavePath .. "IncreaseActiveCrimeNetJobs.txt"
IncreaseActiveCrimeNetJobs.ModOptions = IncreaseActiveCrimeNetJobs.ModPath .. "menus/modoptions.txt"
IncreaseActiveCrimeNetJobs.settings = IncreaseActiveCrimeNetJobs.settings or {}

function IncreaseActiveCrimeNetJobs:Reset()
	self.settings = {
		active_job_amount = 10,
		active_job_timer = 25,
		normalize_new_job_timers = false,

	}
	self:Save()
end

function IncreaseActiveCrimeNetJobs:Load()
	local file = io.open(self.SaveFile, "r")
	if file then
		for key, value in pairs(json.decode(file:read("*all"))) do
			self.settings[key] = value
		end
		file:close()
	else
		self:Reset()
	end
end

function IncreaseActiveCrimeNetJobs:Save()
	local file = io.open(self.SaveFile, "w+")
	if file then
		file:write(json.encode(self.settings))
		file:close()
	end
end

IncreaseActiveCrimeNetJobs:Load()

Hooks:Add("LocalizationManagerPostInit", "IncreaseActiveCrimeNetJobs_loc", function(loc)
	LocalizationManager:add_localized_strings({
		["IncreaseActiveCrimeNetJobs_menu_title"] = "Crime.Net Generated Job Settings",
		["IncreaseActiveCrimeNetJobs_menu_desc"] = "Crime.Net Generated Job Settings",
		["IncreaseActiveCrimeNetJobs_menu_active_job_amount_title"] = "Amount of Generated Active Jobs",
		["IncreaseActiveCrimeNetJobs_menu_active_job_amount_desc"] = "Default is 10, minimum can be 1 and maximum can be 40",
		["IncreaseActiveCrimeNetJobs_menu_active_job_timer_title"] = "Set Timer for Active Jobs Expiration",
		["IncreaseActiveCrimeNetJobs_menu_active_job_timer_desc"] = "Default is 25, max you can go is 60",
		["IncreaseActiveCrimeNetJobs_menu_normalize_new_job_timers_title"] = "Normalize New Job Spawning Timer",
		["IncreaseActiveCrimeNetJobs_menu_normalize_new_job_timers_desc"] = "Will remove the randomized new job timer by setting it to 1.5 seconds",
    })
end)

Hooks:Add("MenuManagerSetupCustomMenus", "IncreaseActiveCrimeNetJobsOptions", function( menu_manager, nodes )
	MenuHelper:NewMenu( IncreaseActiveCrimeNetJobs.options_menu )
end)

Hooks:Add("MenuManagerPopulateCustomMenus", "IncreaseActiveCrimeNetJobsOptions", function( menu_manager, nodes )
	
	MenuCallbackHandler.IncreaseActiveCrimeNetJobs_menu_active_job_amount_callback = function(self, item)
		IncreaseActiveCrimeNetJobs.settings.active_job_amount = math.floor(item:value())
		IncreaseActiveCrimeNetJobs:Save()
	end

	MenuHelper:AddSlider({
		id = "IncreaseActiveCrimeNetJobs_menu_active_job_amount_callback",
		title = "IncreaseActiveCrimeNetJobs_menu_active_job_amount_title",
		callback = "IncreaseActiveCrimeNetJobs_menu_active_job_amount_callback",
		value = IncreaseActiveCrimeNetJobs.settings.active_job_amount,
		min = 1,
		max = 40,
		step = 1,
		show_value = true,
		menu_id = IncreaseActiveCrimeNetJobs.options_menu,  
	})

	MenuCallbackHandler.IncreaseActiveCrimeNetJobs_menu_active_job_timer_callback = function(self, item)
		IncreaseActiveCrimeNetJobs.settings.active_job_timer = math.floor(item:value())
		IncreaseActiveCrimeNetJobs:Save()
	end

	MenuHelper:AddSlider({
		id = "IncreaseActiveCrimeNetJobs_menu_active_job_timer_callback",
		title = "IncreaseActiveCrimeNetJobs_menu_active_job_timer_title",
		callback = "IncreaseActiveCrimeNetJobs_menu_active_job_timer_callback",
		value = IncreaseActiveCrimeNetJobs.settings.active_job_timer,
		min = 25,
		max = 60,
		step = 1,
		show_value = true,
		menu_id = IncreaseActiveCrimeNetJobs.options_menu,  
	})

	MenuCallbackHandler.IncreaseActiveCrimeNetJobs_menu_normalize_new_job_timers_callback = function(self, item)
		IncreaseActiveCrimeNetJobs.settings.normalize_new_job_timers = item:value() == "on" and true or false
		IncreaseActiveCrimeNetJobs:Save()
	end
	MenuHelper:AddToggle({
		id = "IncreaseActiveCrimeNetJobs_menu_normalize_new_job_timers_callback",
		title = "IncreaseActiveCrimeNetJobs_menu_normalize_new_job_timers_title",
		callback = "IncreaseActiveCrimeNetJobs_menu_normalize_new_job_timers_callback",
		value = IncreaseActiveCrimeNetJobs.settings.normalize_new_job_timers,
		menu_id = IncreaseActiveCrimeNetJobs.options_menu,  
	})

end)

Hooks:Add("MenuManagerBuildCustomMenus", "IncreaseActiveCrimeNetJobsOptions", function(menu_manager, nodes)
	nodes[IncreaseActiveCrimeNetJobs.options_menu] = MenuHelper:BuildMenu( IncreaseActiveCrimeNetJobs.options_menu )
	MenuHelper:AddMenuItem(nodes["blt_options"], IncreaseActiveCrimeNetJobs.options_menu, "IncreaseActiveCrimeNetJobs_menu_title", "IncreaseActiveCrimeNetJobs_menu_desc")
end)
