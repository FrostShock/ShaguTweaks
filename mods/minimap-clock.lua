local _G = _G or getfenv(0)
local GetExpansion = ShaguTweaks.GetExpansion

-- tbc already has a clock
if GetExpansion() ~= "vanilla" then return end

local module = ShaguTweaks:register({
  title = "MiniMap Clock",
  description = "Adds a small 24h clock to the mini map.",
  enabled = nil,
})

MinimapClock = CreateFrame("Frame", "Clock", Minimap)
MinimapClock:Hide()
MinimapClock:SetFrameStrata("MEDIUM")
MinimapClock:SetPoint("BOTTOM", MinimapCluster, "BOTTOM", 8, 15)
MinimapClock:SetWidth(50)
MinimapClock:SetHeight(25)
MinimapClock:SetBackdrop({
  bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
  edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
  tile = true, tileSize = 8, edgeSize = 16,
  insets = { left = 3, right = 3, top = 3, bottom = 3 }
})
MinimapClock:SetBackdropBorderColor(.9,.8,.5,1)
MinimapClock:SetBackdropColor(.4,.4,.4,1)

module.enable = function(self)
  MinimapClock:Show()
  MinimapClock.text = MinimapClock:CreateFontString("Status", "LOW", "GameFontNormal")
  MinimapClock.text:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
  MinimapClock.text:SetAllPoints(MinimapClock)
  MinimapClock.text:SetFontObject(GameFontWhite)
  MinimapClock:SetScript("OnUpdate", function()
    this.text:SetText(date("%H:%M"))
  end)
end
