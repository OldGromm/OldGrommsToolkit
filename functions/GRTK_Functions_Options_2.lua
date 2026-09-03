function GRTK_Options_OnSettingChanged_Account(setting, value)
	if GRTK_Options_Timeout == false then
        GRTK_Options_Timeout = true
        GRTK_UV("SetPlayer", 0, setting.variableKey, value)
        local GRTKTemp_Category = 0

	    if setting.variableKey == "General_UseAccountWide" then
	        GRTKTemp_Category = 1
        elseif setting.variableKey == "SpecChange_UseAccountWide" then
            GRTKTemp_Category = 2
        elseif setting.variableKey == "RepairMessage_UseAccountWide" then
            GRTKTemp_Category = 3
        elseif setting.variableKey == "Sounds_UseAccountWide" then
            GRTKTemp_Category = 4
        elseif setting.variableKey == "Mounts_UseAccountWide" then
            GRTKTemp_Category = 5
        elseif setting.variableKey == "Hearthstone_UseAccountWide" then
            GRTKTemp_Category = 6
		else
		end
		
        
        GRTK_Options_ApplyProfile(GRTKTemp_Category)


		if setting.variableKey == "Mounts_UseAccountWide" then
		    if GRTK_General_CombatCheck() == false then
                GRTK_Mounts_RefreshIconList()
			    GRTK_Mounts_CheckForOverrides()
                GRTK_Macros_Update("Mounts")
	        else
	            GRTK_CombatLockdown_SendMessage("Settings")
	        end
		elseif setting.variableKey == "Hearthstone_UseAccountWide" then
		    if GRTK_General_CombatCheck() == false then
                GRTK_Hearthstone_GenerateNewList()
                GRTK_Macros_Update("Hearthstone")
	        else
	            GRTK_CombatLockdown_SendMessage("Settings")
	        end
		else
		end


	    RunNextFrame(function() GRTK_Options_Timeout = false end)
	end
end




function GRTK_Options_OnSettingChanged_General(setting, value)
	if GRTK_Options_Timeout == false then
        GRTK_Options_Timeout = true
        GRTK_UV("Set", 1, setting.variableKey, value)

        if setting.variableKey == "General_MinimapButton" then
			GRTK_General_ToggleMinimapButton()
		end 

	    RunNextFrame(function() GRTK_Options_Timeout = false end)
	end
end




function GRTK_Options_OnSettingChanged_SpecChange(setting, value)
	if GRTK_Options_Timeout == false then
        GRTK_Options_Timeout = true

		for i=1, GRTK_SpecChange_ChoicesTotal do
		    local GRTKTemp_VariableName = ("SpecChange_Choice_"..GRTK_PlayerStats_CurrentClassName.."_"..tostring(i))
			if setting.variableKey == GRTKTemp_VariableName then
				GRTK_UV("Set", 2, GRTKTemp_VariableName, true)
			else
			    GRTK_UV("Set", 2, GRTKTemp_VariableName, false)
			end
		end

        GRTK_SpecChange_LoadValuesFromProfile()

		RunNextFrame(function() GRTK_SpecChange_UpdateOptionsCheckboxes() end)
	    RunNextFrame(function() GRTK_Options_Timeout = false end)
	end
end




function GRTK_Options_OnSettingChanged_RepairMessage(setting, value)
	if GRTK_Options_Timeout == false then
        GRTK_Options_Timeout = true
        GRTK_UV("Set", 3, setting.variableKey, value)

		if setting.variableKey == "RepairMessage_Enabled" then
            GRTK_Setup_UpdateEventRegistration()
		elseif setting.variableKey == "RepairMessage_Sound" then
			local GRTKTemp_SoundID = GRTK_RepairMessage_SoundEntries[value]
		    GRTK_PreviewSoundPlayer(GRTKTemp_SoundID)
		else
		end

	    RunNextFrame(function() GRTK_Options_Timeout = false end)
	end
end




function GRTK_Options_OnSettingChanged_Sounds(setting, value)
	if GRTK_Options_Timeout == false then
        GRTK_Options_Timeout = true
        GRTK_UV("Set", 4, setting.variableKey, value)

		if setting.variableKey == "Sounds_Victory" then
            local GRTKTemp_SoundID = 0
            local GRTKTemp_Index = value
            local GRTKTemp_MaxRandom = 2

            if GRTK_ExpansionLevel == 3 then
                GRTKTemp_MaxRandom = #GRTK_Sounds_Victory_RandomList_Retail
            elseif GRTK_ExpansionLevel == 2 then
                GRTKTemp_MaxRandom = #GRTK_Sounds_Victory_RandomList_MoP
            elseif GRTK_ExpansionLevel == 1 then
                GRTKTemp_MaxRandom = #GRTK_Sounds_Victory_RandomList_Classic
            else
            end

            if GRTKTemp_Index == 21 then
                GRTK_DefaultVictorySoundToggle(false)
                if GRTK_SoundHandle_PlayedSomeMusicBefore == false then
                else
                    StopSound(GRTK_SoundHandle, 0.0)	
                end
            else
                if GRTKTemp_Index == 20 then
                    GRTKTemp_Index = fastrandom(1, GRTKTemp_MaxRandom)
                end
                GRTK_DefaultVictorySoundToggle(true)
                GRTKTemp_SoundID = GRTK_Sounds_Victory_Entries[GRTKTemp_Index]
                GRTK_PreviewSoundPlayer(GRTKTemp_SoundID)
				GRTK_SoundHandle_PlayedSomeMusicBefore = true
			end
			GRTK_Setup_UpdateEventRegistration()
	    end

	    RunNextFrame(function() GRTK_Options_Timeout = false end)
	end
end




function GRTK_Options_OnSettingChanged_Mounts(setting, value)
	if GRTK_Options_Timeout == false then
        GRTK_Options_Timeout = true
        GRTK_UV("Set", 5, setting.variableKey, value)

        if setting.variableKey == "Mounts_Enabled" then
            GRTK_Setup_UpdateEventRegistration()
        end

		local GRTKTemp_MountsEnabled = GRTK_UV("Load", 5, "Mounts_Enabled")
		if GRTKTemp_MountsEnabled == false then
		    if GRTK_General_CombatCheck() == false then
			    GRTK_Macros_Delete("Mounts")
	        else
	            GRTK_CombatLockdown_SendMessage("Settings")
	        end
		elseif GRTKTemp_MountsEnabled == true then
		    if GRTK_General_CombatCheck() == false then
			    GRTK_Mounts_CheckForOverrides()
                GRTK_Macros_Update("Mounts")
	        else
	            GRTK_CombatLockdown_SendMessage("Settings")
	        end


		    if GRTK_Mounts_WorgenDruidCheck() == true then
                GRTK_Mounts_WorgenDruidOptions(setting.variable, value)
            end
		else
		end

	    RunNextFrame(function() GRTK_Options_Timeout = false end)
	end
end




function GRTK_Options_OnSettingChanged_Hearthstone(setting, value)
	if GRTK_Options_Timeout == false then
        GRTK_Options_Timeout = true
        GRTK_UV("Set", 6, setting.variableKey, value)

        if setting.variableKey == "Hearthstone_Enabled" then
		    GRTK_Setup_UpdateEventRegistration()
		    if value == false then
		        if GRTK_General_CombatCheck() == false then
                    GRTK_Macros_Delete("Hearthstone")
	            else
	                GRTK_CombatLockdown_SendMessage("Settings")
	            end
			end
		end

        -- only generate a new hearthstone list if the player removed or added a specific hearthstone.
		-- (due to the options menu entries being generated dynamically, checking for every
		--  options variable name manually will cause an error.
		--  Instead, each variable name will be temporarily-generated for this scenario.)
        for i, v in ipairs(GRTK_Hearthstone_List) do
		    local GRTKTemp_VariableName = ("Hearthstone_ToyID_"..tostring(v))
		    if GRTKTemp_VariableName == setting.variableKey then
			    GRTK_Hearthstone_GenerateNewList()
			end
		end

        -- check special hearthstones modifier keys and prevent identical keybinds.
		local HearthstoneList = {"Dalaran", "Garrison", "Arcantina"}
		for i, v in ipairs(HearthstoneList) do
		    local HearthstoneVariable = ("Hearthstone_ModifierButton_"..v)
			if setting.variableKey == HearthstoneVariable then
			    GRTK_Hearthstone_CheckSpecialHearthstones("ModifierButton", 4, setting.variableKey, value)
			end
		end
		for i, v in ipairs(HearthstoneList) do
		    local HearthstoneVariable = ("Hearthstone_ModifierMouse_"..v)
			if setting.variableKey == HearthstoneVariable then
			    GRTK_Hearthstone_CheckSpecialHearthstones("ModifierMouse", 6, setting.variableKey, value)
			end
		end

		if GRTK_General_CombatCheck() == false then
            GRTK_Macros_Update("Hearthstone")
	    else
	        GRTK_CombatLockdown_SendMessage("Settings")
	    end

	    RunNextFrame(function() GRTK_Options_Timeout = false end)
	end
end