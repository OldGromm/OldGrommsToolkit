function GRTK_Options_CreateOptionsEntry(input_name, input_extratooltip, input_category, input_optionstype, input_default, input_dropdownID, input_iconID)
    local GRTKTemp_Category = GRTK_Variables_Categories[input_category]
    local GRTKTemp_VariableKey = (GRTKTemp_Category.."_"..input_name)
    local GRTKTemp_Variable = ("GRTK_Options_"..GRTKTemp_VariableKey)
    local GRTKTemp_LocaleVariableName = _G["GRTK_Text_Options_"..GRTKTemp_VariableKey.."_Title"]
    local GRTKTemp_LocaleVariableDescription = _G["GRTK_Text_Options_"..GRTKTemp_VariableKey.."_Description"]
    local GRTKTemp_LocaleVariableExtraButton = _G["GRTK_Text_Options_"..GRTKTemp_VariableKey.."_Extra"]
	local GRTKTemp_OptionsCategory = _G["GRTK_Options_Category_Sub_"..GRTKTemp_Category]
	local GRTKTemp_OptionsLayout = _G["GRTK_Options_Layout_Sub_"..GRTKTemp_Category]
    local GRTKTemp_OnSettingsChangedName = ("GRTK_Options_OnSettingChanged_"..GRTKTemp_Category)
	local GRTKTemp_OnButtonClick = ("GRTK_Options_OnButtonClick_"..GRTKTemp_VariableKey)

    -- perform special actions if this is either a SpecChange list or Hearthstone list.
    if input_iconID == nil then
	else
	    GRTKTemp_VariableKey = (GRTKTemp_Category.."_"..input_name.."_"..tostring(input_iconID))
        GRTKTemp_Variable = ("GRTK_Options_"..GRTKTemp_Category.."_"..input_name.."_"..tostring(input_iconID))
        GRTKTemp_LocaleVariableDescription = ""

        local GRTKTemp_SpecChangeName = ("Choice_"..GRTK_PlayerStats_CurrentClassName)
		if input_name == GRTKTemp_SpecChangeName and input_category == 2 then
		    GRTKTemp_LocaleVariableName = GRTK_SpecChange_CreateIconTextString(input_iconID)
		elseif input_name == "ToyID" and input_category == 6 then
		    local GRTKTemp_IconID = GRTK_Hearthstone_Icon[input_iconID]
		    GRTKTemp_LocaleVariableName = CreateSimpleTextureMarkup(GRTKTemp_IconID, 35, 35, 0, 0)
		else
		end
    end


    -- add additional lines to the tooltip depending on the type
    if input_extratooltip == 1 then
        GRTKTemp_LocaleVariableDescription = (GRTKTemp_LocaleVariableDescription.."\n\n".."("..GRTK_Text_RequiresReload..")")
    elseif input_extratooltip == 2 then
        GRTKTemp_LocaleVariableDescription = (GRTKTemp_LocaleVariableDescription.."\n\n".."("..GRTK_Text_Options_Preview..")")
    elseif input_extratooltip == 3 then
        GRTKTemp_LocaleVariableDescription = (GRTKTemp_LocaleVariableDescription.."\n\n".."("..GRTK_Text_Options_ModifierNote_Below..")".."\n\n".."("..GRTK_Text_Options_ModifierNote_Disable..")")
    elseif input_extratooltip == 4 then
        GRTKTemp_LocaleVariableDescription = (GRTKTemp_LocaleVariableDescription.."\n\n".."("..GRTK_Text_Options_ModifierNote_Above..")".."\n\n".."("..GRTK_Text_Options_ModifierNote_Disable..")")
    elseif input_extratooltip == 5 then
        GRTKTemp_LocaleVariableDescription = (GRTKTemp_LocaleVariableDescription.."\n\n".."("..GRTK_Text_Options_General_CombatLockdown_Description_PartTwo..")")
	else
    end


    -- use the same textstring if this is the same option (but different categories)
    if input_name == "UseAccountWide" then
        GRTKTemp_LocaleVariableName = _G["GRTK_Text_Options_All_UseAccountWide_Title"]
        GRTKTemp_LocaleVariableDescription = _G["GRTK_Text_Options_All_UseAccountWide_Description"]
		GRTKTemp_OnSettingsChangedName = ("GRTK_Options_OnSettingChanged_Account")
	end


	    local function GetOptions()
            local container = Settings.CreateControlTextContainer()

            if input_dropdownID == 1 then
                container:Add(1, GRTK_Text_Options_SelectionType1)
                container:Add(2, GRTK_Text_Options_SelectionType2)
                container:Add(3, GRTK_Text_Options_SelectionType3)
            elseif input_dropdownID == 2 then
                container:Add(1, GRTK_Text_Options_SelectionTypeKey1)
                container:Add(2, GRTK_Text_Options_SelectionTypeKey2)
                container:Add(3, GRTK_Text_Options_SelectionTypeKey3)
                container:Add(4, GRTK_Text_Options_Nothing)
            elseif input_dropdownID == 3 then
                container:Add(1, GRTK_Text_Options_SelectionTypeMouse1)
                container:Add(2, GRTK_Text_Options_SelectionTypeMouse2)
                container:Add(3, GRTK_Text_Options_SelectionTypeMouse3)
                container:Add(4, GRTK_Text_Options_SelectionTypeMouse4)
                container:Add(5, GRTK_Text_Options_SelectionTypeMouse5)
                container:Add(6, GRTK_Text_Options_Nothing)
            elseif input_dropdownID == 4 then
                container:Add(1, GRTK_Text_Options_RepairMessage_Entry_Alarm)
                container:Add(2, GRTK_Text_Options_RepairMessage_Entry_HarborBell)
                if GRTK_ExpansionLevel == 3 then
                    container:Add(3, GRTK_Text_Options_RepairMessage_Entry_ChurchBell)
                end
                if GRTK_ExpansionLevel > 1 then
                    container:Add(4, GRTK_Text_Options_RepairMessage_Entry_Siren)
                end
            elseif input_dropdownID == 5 then
                container:Add(1, GRTK_Text_Options_Sounds_ChannelName_Master)
                container:Add(2, GRTK_Text_Options_Sounds_ChannelName_Music)
                container:Add(3, GRTK_Text_Options_Sounds_ChannelName_SXF)
                container:Add(4, GRTK_Text_Options_Sounds_ChannelName_Ambience)
                container:Add(5, GRTK_Text_Options_Sounds_ChannelName_Dialog)
            elseif input_dropdownID == 6 then
                container:Add(1, GRTK_Text_Options_Sounds_Victory_Entry_PvP.." ("..GRTK_Text_Options_Sounds_Victory_Entry_Alliance..")")
                container:Add(2, GRTK_Text_Options_Sounds_Victory_Entry_PvP.." ("..GRTK_Text_Options_Sounds_Victory_Entry_Horde..")")
                if GRTK_ExpansionLevel > 1 then
                    container:Add(3, GRTK_Text_Options_Sounds_Victory_Entry_SoA.." ("..GRTK_Text_Options_Sounds_Victory_Entry_Alliance..")")
                    container:Add(4, GRTK_Text_Options_Sounds_Victory_Entry_SoA.." ("..GRTK_Text_Options_Sounds_Victory_Entry_Horde..")")
                    container:Add(5, GRTK_Text_Options_Sounds_Victory_Entry_Brawler.." ("..GRTK_Text_Options_Sounds_Victory_Entry_Alliance..")")
                    container:Add(6, GRTK_Text_Options_Sounds_Victory_Entry_Brawler.." ("..GRTK_Text_Options_Sounds_Victory_Entry_Horde..")")
                    container:Add(7, GRTK_Text_Options_Sounds_Victory_Entry_PetBattles.." ("..GRTK_Text_Options_Sounds_Victory_Entry_Alliance..")")
                    container:Add(8, GRTK_Text_Options_Sounds_Victory_Entry_PetBattles.." ("..GRTK_Text_Options_Sounds_Victory_Entry_Horde..")")
                end
                if GRTK_ExpansionLevel == 3 then
                    container:Add(9, GRTK_Text_Options_Sounds_Victory_Entry_Islands.." ("..GRTK_Text_Options_Sounds_Victory_Entry_Alliance..")")
                    container:Add(10, GRTK_Text_Options_Sounds_Victory_Entry_Islands.." ("..GRTK_Text_Options_Sounds_Victory_Entry_Horde..")")
                    container:Add(11, GRTK_Text_Options_Sounds_Victory_Entry_Islands.." ("..GRTK_Text_Options_Sounds_Victory_Entry_Mystical..")")
                    container:Add(12, GRTK_Text_Options_Sounds_Victory_Entry_Islands.." ("..GRTK_Text_Options_Sounds_Victory_Entry_Winter..")")
                    container:Add(13, GRTK_Text_Options_Sounds_Victory_Entry_Islands.." ("..GRTK_Text_Options_Sounds_Victory_Entry_Jorundall..")")
                    container:Add(14, GRTK_Text_Options_Sounds_Victory_Entry_Darkshore.." ("..GRTK_Text_Options_Sounds_Victory_Entry_Alliance..")")
                    container:Add(15, GRTK_Text_Options_Sounds_Victory_Entry_Darkshore.." ("..GRTK_Text_Options_Sounds_Victory_Entry_Horde..")")
                end
                if GRTK_ExpansionLevel == 3 then
                    container:Add(16, GRTK_Text_Options_Sounds_Victory_Entry_Hearthstone)
                    container:Add(17, GRTK_Text_Options_Sounds_Victory_Entry_Darkmoon.." ("..GRTK_Text_Options_Sounds_Victory_Entry_CalltoArms..")")
                    container:Add(18, GRTK_Text_Options_Sounds_Victory_Entry_Darkmoon.." ("..GRTK_Text_Options_Sounds_Victory_Entry_LionsPride..")")
                    container:Add(19, GRTK_Text_Options_Sounds_Victory_Entry_Darkmoon.." ("..GRTK_Text_Options_Sounds_Victory_Entry_PrideoftheSeas..")")
                end
                container:Add(20, GRTK_Text_Options_Sounds_Victory_Entry_Random)
                container:Add(21, GRTK_Text_Options_Sounds_Victory_Entry_None)
            elseif input_dropdownID == 7 then
			    for i, v in ipairs(GRTK_UserLanguage_Full) do
                    container:Add(i, v)
			    end
            elseif input_dropdownID == 8 then
                container:Add(1, GRTK_Text_Options_General_CombatLockdown_Never)
                container:Add(2, GRTK_Text_Options_General_CombatLockdown_Once)
                container:Add(3, GRTK_Text_Options_General_CombatLockdown_Always)
			else
			end

            return container:GetData()
        end


    -- create a different options type depending on the type (checkbox, dropdown, checkbox with button)
	if input_optionstype == 1 then
	    local GRTKTemp_OnSettingChanged = _G[GRTKTemp_OnSettingsChangedName]
	    local GRTKTemp_Setting = Settings.RegisterAddOnSetting(GRTKTemp_OptionsCategory, GRTKTemp_Variable, GRTKTemp_VariableKey, GRTKDB_Options, Settings.VarType.Boolean, GRTKTemp_LocaleVariableName, input_default)
	    GRTKTemp_Setting:SetValueChangedCallback(GRTKTemp_OnSettingChanged)
	    Settings.CreateCheckbox(GRTKTemp_OptionsCategory, GRTKTemp_Setting, GRTKTemp_LocaleVariableDescription)
	elseif input_optionstype == 2 then
	    local GRTKTemp_OnSettingChanged = _G[GRTKTemp_OnSettingsChangedName]
	    local GRTKTemp_Setting = Settings.RegisterAddOnSetting(GRTKTemp_OptionsCategory, GRTKTemp_Variable, GRTKTemp_VariableKey, GRTKDB_Options, Settings.VarType.Number, GRTKTemp_LocaleVariableName, input_default)
	    GRTKTemp_Setting:SetValueChangedCallback(GRTKTemp_OnSettingChanged)
	    Settings.CreateDropdown(GRTKTemp_OptionsCategory, GRTKTemp_Setting, GetOptions, GRTKTemp_LocaleVariableDescription)
    elseif input_optionstype == 3 then
		local GRTKTemp_MinimumValue = 0
		local GRTKTemp_MaximumValue = 10
		local GRTKTemp_Step = 1
	    local GRTKTemp_OnSettingChanged = _G[GRTKTemp_OnSettingsChangedName]
		local GRTKTemp_Setting = Settings.RegisterAddOnSetting(GRTKTemp_OptionsCategory, GRTKTemp_Variable, GRTKTemp_VariableKey, GRTKDB_Options, Settings.VarType.Number, GRTKTemp_LocaleVariableName, input_default)
		GRTKTemp_Setting:SetValueChangedCallback(GRTKTemp_OnSettingChanged)
		local GRTKTemp_Options = Settings.CreateSliderOptions(GRTKTemp_MinimumValue, GRTKTemp_MaximumValue, GRTKTemp_Step)
		GRTKTemp_Options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right)
		Settings.CreateSlider(GRTKTemp_OptionsCategory, GRTKTemp_Setting, GRTKTemp_Options, GRTKTemp_LocaleVariableDescription)
	elseif input_optionstype == 4 then
	    local GRTKTemp_ButtonReaction = _G[GRTKTemp_OnButtonClick]
        local GRTKTemp_Initializer = CreateSettingsButtonInitializer(GRTKTemp_LocaleVariableName, GRTKTemp_LocaleVariableExtraButton, GRTKTemp_ButtonReaction, GRTKTemp_LocaleVariableDescription, false, newTagID, gameDataFunc)
        GRTKTemp_OptionsLayout:AddInitializer(GRTKTemp_Initializer)
	else
	end


    if input_optionstype < 4 then
        -- Mirror options entry to profiles (create entries if they don't already exist).
        GRTK_UV("Create", input_category, GRTKTemp_VariableKey, input_default)

		if input_name == "UseAccountWide" then

		else
            -- Add options variable to a list (required for profile change).
	        GRTK_AddOptionsVariableNameToList(input_category, GRTKTemp_VariableKey)
		end
	end
end