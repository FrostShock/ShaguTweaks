local _G = _G or getfenv(0)
local GetExpansion = ShaguTweaks.GetExpansion

local module = ShaguTweaks:register({
  title = "MiniMap Tweaks",
  description = "Hides unnecessary mini map buttons and allows to zoom using the mouse wheel.",
  enabled = nil,
})

module.enable = function(self)
  -- hide daytime circle
  GameTimeFrame:Hide()
  GameTimeFrame:SetScript("OnShow", function() this:Hide() end)

  -- hide minimap zone background
  MinimapBorderTop:Hide()
  MinimapToggleButton:Hide()
  MinimapZoneTextButton:SetPoint("CENTER", 7, 85)

  -- hide zoom buttons and enable mousewheel
  MinimapZoomIn:Hide()
  MinimapZoomOut:Hide()
  Minimap:EnableMouseWheel(true)
  Minimap:SetScript("OnMouseWheel", function()
    if(arg1 > 0) then Minimap_ZoomIn() else Minimap_ZoomOut() end
  end)
end
