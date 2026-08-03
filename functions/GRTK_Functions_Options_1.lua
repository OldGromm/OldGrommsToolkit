-- Color Picker
function GRTK_Options_OnButtonClick_General_MessageColor()
    GRTKTemp_Red = GRTK_UV("Load", 1, "General_Messages_Color_Red")
    GRTKTemp_Green = GRTK_UV("Load", 1, "General_Messages_Color_Green")
    GRTKTemp_Blue = GRTK_UV("Load", 1, "General_Messages_Color_Blue")

	GRTK_General_ShowColorPicker(GRTKTemp_Red, GRTKTemp_Green, GRTKTemp_Blue)
end




-- Missing hearthstones
function GRTK_Options_OnButtonClick_Hearthstone_Missing()
    GRTK_Hearthstone_NotUnlockedYet()
end




-- Add variable created during options creation to a list.
function GRTK_AddOptionsVariableNameToList(input_category, input_value)
    local GRTKTemp_CategoryName = GRTK_Variables_Categories[input_category]
	local GRTKTemp_VariableName = _G["GRTK_Options_FullList_"..GRTKTemp_CategoryName]
    tinsert(GRTKTemp_VariableName, input_value)
end




-- Apply different profile to all settings.
function GRTK_Options_ApplyProfile(input_category)
	local GRTKTemp_CategoryName = GRTK_Variables_Categories[input_category]
	local GRTKTemp_ListName = ("GRTK_Options_FullList_"..GRTKTemp_CategoryName)
	local GRTKTemp_List = _G[GRTKTemp_ListName]

	for i, v in ipairs(GRTKTemp_List) do
	    local GRTKTemp_VariableName = v
	    local GRTKTemp_SettingsName = ("GRTK_Options_"..GRTKTemp_VariableName)
		local GRTKTemp_SettingsValue = GRTK_UV("Load", input_category, GRTKTemp_VariableName)

		if GRTKTemp_SettingsValue == nil then
		
		else
		    Settings.SetValue(GRTKTemp_SettingsName, GRTKTemp_SettingsValue, true)
		end

	end
end




-- Category Names
function GRTK_Options_CategoryNames()
    GRTK_Options_Category_Main, GRTK_Options_Layout_Main = Settings.RegisterVerticalLayoutCategory(GRTK_Text_Options_Category_Title)
    GRTK_Options_Category_Sub_General, GRTK_Options_Layout_Sub_General = Settings.RegisterVerticalLayoutSubcategory(GRTK_Options_Category_Main, GRTK_Text_Options_Category_General)
    if GRTK_ExpansionLevel == 3 then
	    GRTK_Options_Category_Sub_SpecChange, GRTK_Options_Layout_Sub_SpecChange = Settings.RegisterVerticalLayoutSubcategory(GRTK_Options_Category_Main, GRTK_Text_Options_Category_SpecChange)
    end
	GRTK_Options_Category_Sub_RepairMessage, GRTK_Options_Layout_Sub_RepairMessage = Settings.RegisterVerticalLayoutSubcategory(GRTK_Options_Category_Main, GRTK_Text_Options_Category_RepairMessage)
    GRTK_Options_Category_Sub_Sounds, GRTK_Options_Layout_Sub_Sounds = Settings.RegisterVerticalLayoutSubcategory(GRTK_Options_Category_Main, GRTK_Text_Options_Category_Sounds)
	if GRTK_ExpansionLevel > 1 then
	    GRTK_Options_Category_Sub_Mounts, GRTK_Options_Layout_Sub_Mounts = Settings.RegisterVerticalLayoutSubcategory(GRTK_Options_Category_Main, GRTK_Text_Options_Category_Mounts)
    end
	if GRTK_ExpansionLevel == 3 then
        GRTK_Options_Category_Sub_Hearthstone, GRTK_Options_Layout_Sub_Hearthstone = Settings.RegisterVerticalLayoutSubcategory(GRTK_Options_Category_Main, GRTK_Text_Options_Category_Hearthstone)
	end
end