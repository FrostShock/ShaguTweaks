local _G = _G or getfenv(0)

local module = ShaguTweaks:register({
  title = "Hide Errors",
  description = "Hides and ignores all Lua errors produced by broken addons.",
  enabled = nil,
})

module.enable = function(self)
  error = function() return end
  seterrorhandler(error)
end
