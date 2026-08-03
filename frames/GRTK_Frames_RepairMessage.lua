function GRTK_CreateFrame_RepairMessage()

    -- create frame for screen message
    GRTK_RepairMessage_FrameName = (GRTK_Text_Options_Category_Title.." - "..GRTK_Text_Options_Category_RepairMessage)
    GRTK_RepairMessage_Frame_ScreenMessage = CreateFrame("Frame", GRTK_RepairMessage_FrameName, UIParent)
    GRTK_RepairMessage_Frame_ScreenMessage:SetAllPoints()
    GRTK_RepairMessage_Frame_ScreenMessage:SetSize(400, 50)
    GRTK_RepairMessage_Frame_ScreenMessage:SetIgnoreParentScale(true)
    GRTK_RepairMessage_Frame_ScreenMessageText = GRTK_RepairMessage_Frame_ScreenMessage:CreateFontString(nil, "OVERLAY", "GRTKRepairReminderFontSize36")
    GRTK_RepairMessage_Frame_ScreenMessageText:SetPoint("LEFT", 0, 0)
    GRTK_RepairMessage_Frame_ScreenMessageText:SetText("")
    GRTK_RepairMessage_Frame_ScreenMessageEditMode = GRTK_RepairMessage_Frame_ScreenMessage:CreateFontString(nil, "OVERLAY", "GRTKRepairReminderFontSize36")
    GRTK_RepairMessage_Frame_ScreenMessageEditMode:SetPoint("LEFT", 0, 0)
    GRTK_RepairMessage_Frame_ScreenMessageEditMode:SetText("")

end