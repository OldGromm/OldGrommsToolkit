function GRTK_CreateFrame_LockdownMessage()
    -- message frame
    GRTK_CombatLockdown_FrameName = (GRTK_Text_Options_Category_Title.." - "..GRTK_Text_CombatLockdown_EditMode)
    GRTK_CombatLockdown_Frame_Main = CreateFrame("Frame", GRTK_CombatLockdown_FrameName, UIParent)
    GRTK_CombatLockdown_Frame_Main:SetAllPoints()
    GRTK_CombatLockdown_Frame_Main:SetSize(420, 200)
    GRTK_CombatLockdown_Frame_Main:SetIgnoreParentScale(true)

    GRTK_CombatLockdown_Frame_Message_01 = GRTK_CombatLockdown_Frame_Main:CreateFontString(nil, "OVERLAY", "GRTKLockdownMessageFontSize12")
    GRTK_CombatLockdown_Frame_Message_01:SetPoint("TOPLEFT", 0, 80)
    GRTK_CombatLockdown_Frame_Message_01:SetText("")
    GRTK_CombatLockdown_Frame_Message_02 = GRTK_CombatLockdown_Frame_Main:CreateFontString(nil, "OVERLAY", "GRTKLockdownMessageFontSize12")
    GRTK_CombatLockdown_Frame_Message_02:SetPoint("TOPLEFT", 0, 40)
    GRTK_CombatLockdown_Frame_Message_02:SetText("")
    GRTK_CombatLockdown_Frame_Message_03 = GRTK_CombatLockdown_Frame_Main:CreateFontString(nil, "OVERLAY", "GRTKLockdownMessageFontSize12")
    GRTK_CombatLockdown_Frame_Message_03:SetPoint("TOPLEFT", 0, 0)
    GRTK_CombatLockdown_Frame_Message_03:SetText("")

    GRTK_CombatLockdown_Frame_Message_EditMode = GRTK_CombatLockdown_Frame_Main:CreateFontString(nil, "OVERLAY", "GRTKRepairReminderFontSize36")
    GRTK_CombatLockdown_Frame_Message_EditMode:SetPoint("LEFT", 0, 0)
    GRTK_CombatLockdown_Frame_Message_EditMode:SetText("")

end