local CNGJS = _G.CNGJS or {}

if not CNGJS or not CNGJS.settings then
	return
end

local no_rng_min_time = 1.5
local no_rng_max_time = 1.5

Hooks:PostHook(CrimeNetManager, "_setup_vars", "_setup_vars_new_crimenet_active_job_value", function(self)
   self._MAX_ACTIVE_JOBS = CNGJS.settings.active_job_amount
   self._active_job_time = CNGJS.settings.active_job_timer
  
   if CNGJS.settings.normalize_new_job_timers then
      self._NEW_JOB_MIN_TIME = no_rng_min_time
      self._NEW_JOB_MAX_TIME = no_rng_max_time
   end

end)