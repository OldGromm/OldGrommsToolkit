SLASH_GRTKOPTIONS1 = "/GRTKO"
SLASH_GRTKOPTIONS2 = "/OldGrommOptions"
SlashCmdList.GRTKOPTIONS = function()
    GRTK_Other_OpenSettingsMenu()
end




SLASH_GRTKMINIMAP1 = "/GRTKB"
SLASH_GRTKMINIMAP2 = "/OldGrommButton"
SlashCmdList.GRTKMINIMAP = function()
    if GRTK_UV("Load", 1, "General_MinimapButton") == true then
		Settings.SetValue("GRTK_Options_General_MinimapButton", false, true)
	else
		Settings.SetValue("GRTK_Options_General_MinimapButton", true, true)
	end
end




SLASH_GRTKSPEC1 = "/GRTKS"
SLASH_GRTKSPEC2 = "/OldGrommSpec"
SLASH_GRTKSPEC3 = "/GRTKT"
SLASH_GRTKSPEC4 = "/OldGrommTalents"
SlashCmdList.GRTKSPEC = function()
    GRTK_SpecChange_Keybind()
end




SLASH_GRTKMOUNTMENU1 = "/GRTKM"
SLASH_GRTKMOUNTMENU2 = "/OldGrommMount"
SlashCmdList.GRTKMOUNTMENU = function()
    GRTK_Mounts_ToggleMenu_MountList()
end




SLASH_GRTKMOUNTADVANCE1 = "/GRTKMA"
SLASH_GRTKMOUNTADVANCE2 = "/OldGrommMountAdvance"
SlashCmdList.GRTKMOUNTADVANCE = function()
    GRTK_Mounts_CheckForOverrides()
    GRTK_Macros_AdvanceListOrder("Mounts")
    GRTK_Macros_Update("Mounts")
end




SLASH_GRTKHEARTHSTONE1 = "/GRTKHA"
SLASH_GRTKHEARTHSTONE2 = "/OldGrommHearthstoneAdvance"
SlashCmdList.GRTKHEARTHSTONE = function()
    GRTK_Macros_AdvanceListOrder("Hearthstone")
    GRTK_Macros_Update("Hearthstone")
end




SLASH_GRTKREPAIRMESSAGE1 = "/GRTKRM"
SLASH_GRTKREPAIRMESSAGE2 = "/OldGrommRepairMessage"
SlashCmdList.GRTKREPAIRMESSAGE = function()
    GRTK_RepairMessage_SendMessage()
end