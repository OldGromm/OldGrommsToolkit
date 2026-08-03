-- combat check
function GRTK_General_CombatCheck()
    local GRTKTemp_PlayerIsInCombat = false

	if PlayerIsInCombat() == true then
	    GRTKTemp_PlayerIsInCombat = true
	end

	if C_ChallengeMode.IsChallengeModeActive() == true then
	    GRTKTemp_PlayerIsInCombat = true
	end

    return GRTKTemp_PlayerIsInCombat
end




-- send add-on message in chat
function GRTK_General_SendChatMessage(input_text)
    local GRTKTemp_ChatLockdownIsActive = C_ChatInfo.InChatMessagingLockdown()
	if GRTK_UV("Load", 1, "General_Messages") == true then
        if GRTKTemp_ChatLockdownIsActive == false then

            GRTKTemp_Red = GRTK_UV("Load", 1, "General_Messages_Color_Red")
            GRTKTemp_Green = GRTK_UV("Load", 1, "General_Messages_Color_Green")
            GRTKTemp_Blue = GRTK_UV("Load", 1, "General_Messages_Color_Blue")
            GRTKTemp_Color = CreateColor(GRTKTemp_Red, GRTKTemp_Green, GRTKTemp_Blue)
            GRTKTemp_Color:GenerateHexColor()

		    print(GRTKTemp_Color:WrapTextInColorCode(GRTK_Text_AddonNameAbbreviated).." - "..input_text)
		end
	end
end




-- pick color for chat message
function GRTK_General_ShowColorPicker(r, g, b)
    local function OnColorChanged()
        local newR, newG, newB = ColorPickerFrame:GetColorRGB()
        GRTK_UV("Set", 1, "General_Messages_Color_Red", newR)
		GRTK_UV("Set", 1, "General_Messages_Color_Green", newG)
		GRTK_UV("Set", 1, "General_Messages_Color_Blue", newB)
    end

    local function OnCancel()
        local newR, newG, newB = ColorPickerFrame:GetPreviousValues()
        GRTK_UV("Set", 1, "General_Messages_Color_Red", newR)
		GRTK_UV("Set", 1, "General_Messages_Color_Green", newG)
		GRTK_UV("Set", 1, "General_Messages_Color_Blue", newB)
    end

    local options = {
        swatchFunc = OnColorChanged,
        opacityFunc = OnColorChanged,
        cancelFunc = OnCancel,
        hasOpacity = false,
        opacity = a,
        r = r,
        g = g,
        b = b,
    }

    ColorPickerFrame:SetupColorPickerAndShow(options)
end




-- hotkey function / reload game interface
function GRTK_General_ReloadInterface()
	C_UI.Reload()
end




-- minimap button toggle
function GRTK_General_ToggleMinimapButton()
    if GRTK_UV("Load", 1, "General_MinimapButton", value) == true then
	    GRTK_LibDBIcon:Show("GRTK_Minimap")
	else
	    GRTK_LibDBIcon:Hide("GRTK_Minimap")
	end
end




-- play sound file from either the RepairMessage or Sounds category
function GRTK_General_PlaySoundFile(input_soundID, input_usesoundhandle)
    local GRTKTemp_SoundID = input_soundID
	local GRTKTemp_UseSoundhandle = input_usesoundhandle
	local GRTKTemp_ChannelIndex = GRTK_UV("Load", 4, "Sounds_Channel")
	local GRTKTemp_ChannelName = GRTK_Sounds_ChannelList[GRTKTemp_ChannelIndex]
	
	if GRTKTemp_UseSoundhandle == true then
	    _, GRTK_SoundHandle = PlaySoundFile(GRTKTemp_SoundID, GRTKTemp_ChannelName)
	else
	    PlaySoundFile(GRTKTemp_SoundID, GRTKTemp_ChannelName)
	end
end