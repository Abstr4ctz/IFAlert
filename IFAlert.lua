function IFAlert_HasBuff(unit, texturename)
  local id = 1;
  while (UnitBuff(unit, id)) do
    local buffTexture = UnitBuff(unit, id);
    if (string.find(buffTexture, texturename)) then
      return true;
    end
    id = id + 1;
  end
  return nil;
end

function IFAlert_OnLoad()
  -- hook into events
  this:RegisterEvent("PLAYER_REGEN_ENABLED");
  this:RegisterEvent("PLAYER_REGEN_DISABLED");
  this:RegisterEvent("PLAYER_AURAS_CHANGED");

  -- initialize combat tracker
  IFAlert_combat = nil;

  -- define the border as "backdrop"
  local backdrop = {
    edgeFile = "Interface\\AddOns\\IFAlert\\border", edgeSize = 64,
    insets = {left = 64, right = 64, top = 64, bottom = 64},
  }

  -- build the frame
  IFAlert = CreateFrame("Frame")
  IFAlert:SetFrameStrata("BACKGROUND")
  IFAlert:SetWidth(GetScreenWidth() * UIParent:GetEffectiveScale())
  IFAlert:SetHeight(GetScreenHeight() * UIParent:GetEffectiveScale())
  IFAlert:SetBackdrop(backdrop)
  IFAlert:SetPoint("CENTER",0,0)
  IFAlert:Hide()
end

function IFAlert_OnEvent(event)
  if     (event == "PLAYER_REGEN_DISABLED") then IFAlert_combat = true;
  elseif (event == "PLAYER_REGEN_ENABLED")  then IFAlert_combat = nil;
  end

  if IFAlert_combat and (not IFAlert_HasBuff("player", "Spell_Holy_InnerFire")) then
    IFAlert:Show();
  else
    IFAlert:Hide();
  end
end
