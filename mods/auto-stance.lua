local _G = _G or getfenv(0)
local strsplit = ShaguTweaks.strsplit
local GetExpansion = ShaguTweaks.GetExpansion

-- It's not possible to achieve it like that in TBC
if GetExpansion() == "tbc" then return end

local module = ShaguTweaks:register({
  title = "Auto Stance",
  description = "Automatically switch to the required warrior or druid stance on spell cast.",
  enabled = nil,
})

module.enable = function(self)
  local stancedance = CreateFrame("Frame")
  stancedance:RegisterEvent("UI_ERROR_MESSAGE")
  stancedance:SetScript("OnEvent", function() stancedance.lastError = arg1 end)

  stancedance.lastError = ""
  stancedance.scanString = string.gsub(SPELL_FAILED_ONLY_SHAPESHIFT, "%%s", "(.+)")
  stancedance.CastSpell = CastSpell
  stancedance.CastSpellByName = CastSpellByName
  stancedance.UseAction = UseAction

  stancedance.SwitchStance = function()
    for stance in string.gfind(stancedance.lastError, stancedance.scanString) do
      for _, stance in pairs({ strsplit(",", stance)}) do
        stancedance.CastSpellByName(string.gsub(stance,"^%s*(.-)%s*$", "%1"))
      end
    end
    stancedance.lastError = ""
  end

  function CastSpell(spellId, spellbookTabNum)
    stancedance:SwitchStance()
    stancedance.CastSpell(spellId, spellbookTabNum)
  end

  function CastSpellByName(spellName, onSelf)
    stancedance:SwitchStance()
    stancedance.CastSpellByName(spellName, onSelf)
  end

  function UseAction(slot, checkCursor, onSelf)
    stancedance:SwitchStance()
    stancedance.UseAction(slot, checkCursor, onSelf)
  end
end
