function GRTK_Initialization_CreateOptionsMenu()
    -- Category Names
    GRTK_Options_CategoryNames()

	
    -- General
	GRTK_Options_CreateOptionsEntry("UseAccountWide", nil, 1, 1, true)
	GRTK_Options_CreateOptionsEntry("Language", 1, 1, 2, GRTK_UserLanguage_Default, 7)
	GRTK_Options_CreateOptionsEntry("Messages", nil, 1, 1, true)
	GRTK_Options_CreateOptionsEntry("MessageColor", nil, 1, 4)
	GRTK_Options_CreateOptionsEntry("CombatLockdown", 5, 1, 2, 2, 8)
	GRTK_Options_CreateOptionsEntry("MinimapButton", nil, 1, 1, true)
	if GRTK_Compartment_Enable == true then
	    GRTK_Options_CreateOptionsEntry("CompartmentButton", 1, 1, 1, true)
	end


    -- Spec Change
	if GRTK_ExpansionLevel == 3 then
	    GRTK_Options_CreateOptionsEntry("UseAccountWide", nil, 2, 1, true)

        if GRTK_PlayerStats_CurrentClass == 11 then -- Druid
            GRTK_SpecChange_ChoicesTotal = 6
        elseif GRTK_PlayerStats_CurrentClass == 12 then -- Demon Hunter
            if GRTK_SpecChange_UnlockedDevourerSpec == true then
                GRTK_SpecChange_ChoicesTotal = 3
        	else
        	    GRTK_SpecChange_ChoicesTotal = 1
            end
        else
            GRTK_SpecChange_ChoicesTotal = 3
        end

        for i=1, GRTK_SpecChange_ChoicesTotal do
		    local GRTKTemp_DefaultBoolean = false
		    if GRTK_SpecChange_DefaultChoice[GRTK_PlayerStats_CurrentClass] == i then
			    GRTKTemp_DefaultBoolean = true
			end
			GRTK_Options_CreateOptionsEntry("Choice_"..GRTK_PlayerStats_CurrentClassName, nil, 2, 1, GRTKTemp_DefaultBoolean, nil, i)
		end
	end


	-- Repair Message
	GRTK_Options_CreateOptionsEntry("UseAccountWide", nil, 3, 1, true)
	GRTK_Options_CreateOptionsEntry("Enabled", nil, 3, 1, true)
	GRTK_Options_CreateOptionsEntry("Sound", 2, 3, 2, 1, 4)
	

	-- Sounds
	GRTK_Options_CreateOptionsEntry("UseAccountWide", nil, 4, 1, true)
	GRTK_Options_CreateOptionsEntry("Channel", nil, 4, 2, 1, 5)
	GRTK_Options_CreateOptionsEntry("Victory", 2, 4, 2, 1, 6)
	if GRTK_ExpansionLevel == 3 then
	    GRTK_Options_CreateOptionsEntry("TalkingHead", nil, 4, 3, 2)
	end
	
	
	-- Mounts
	if GRTK_ExpansionLevel > 1 then
	    GRTK_Options_CreateOptionsEntry("UseAccountWide", nil, 5, 1, false)
        GRTK_Options_CreateOptionsEntry("Enabled", nil, 5, 1, true)
        GRTK_Options_CreateOptionsEntry("Ground_OrderType", nil, 5, 2, 1, 1)
		GRTK_Options_CreateOptionsEntry("Flying_OrderType", nil, 5, 2, 1, 1)
		GRTK_Options_CreateOptionsEntry("Aquatic_OrderType", nil, 5, 2, 1, 1)
        GRTK_Options_CreateOptionsEntry("ModifierButton_SpecialMount", 3, 5, 2, 2, 2)
        GRTK_Options_CreateOptionsEntry("ModifierMouse_SpecialMount", 4, 5, 2, 6, 3)

    	if GRTK_PlayerStats_CurrentClass == 11 then -- Druid
            GRTK_Options_CreateOptionsEntry("Druid_Ground", nil, 5, 1, true)
            GRTK_Options_CreateOptionsEntry("Druid_Flying", nil, 5, 1, true)
            GRTK_Options_CreateOptionsEntry("Druid_Aquatic", nil, 5, 1, true)
    	end
    	if GRTK_PlayerStats_CurrentRace == 22 then --Worgen
		    if GRTK_Mounts_WorgenDruidCheck() == true then
                GRTK_Options_CreateOptionsEntry("Worgen", nil, 5, 1, false)
			else
                GRTK_Options_CreateOptionsEntry("Worgen", nil, 5, 1, true)
			end
    	end
    	if GRTK_PlayerStats_CurrentRace == 52 then --Dracthyr (Alliance)
            GRTK_Options_CreateOptionsEntry("Dracthyr", nil, 5, 1, true)
    	end
    	if GRTK_PlayerStats_CurrentRace == 70 then --Dracthyr (Horde)
            GRTK_Options_CreateOptionsEntry("Dracthyr", nil, 5, 1, true)
    	end
	end


	-- Hearthstone
	if GRTK_ExpansionLevel == 3 then
	    GRTK_Options_CreateOptionsEntry("UseAccountWide", nil, 6, 1, true)
		GRTK_Options_CreateOptionsEntry("Enabled", nil, 6, 1, true)
		GRTK_Options_CreateOptionsEntry("OrderType", nil, 6, 2, 1, 1)

		if C_QuestLog.IsQuestFlaggedCompleted(44663) == true then -- In the Blink of an Eye
		    GRTK_Options_CreateOptionsEntry("ModifierButton_Dalaran", 3, 6, 2, 1, 2)
			GRTK_Options_CreateOptionsEntry("ModifierMouse_Dalaran", 4, 6, 2, 6, 3)
		end
		if GRTK_Setup_GarrisonUnlocked() == true then
		    GRTK_Options_CreateOptionsEntry("ModifierButton_Garrison", 3, 6, 2, 2, 2)
			GRTK_Options_CreateOptionsEntry("ModifierMouse_Garrison", 4, 6, 2, 6, 3)
		end

        GRTK_Options_CreateOptionsEntry("Missing", nil, 6, 4)

		for i, v in ipairs(GRTK_Hearthstone_List) do
		    if PlayerHasToy(v) == true then
                GRTK_Options_CreateOptionsEntry("ToyID", nil, 6, 1, true, nil, v)
			else
			    GRTK_Hearthstone_Missing_Count = GRTK_Hearthstone_Missing_Count + 1
			    tinsert(GRTK_Hearthstone_Missing_List, v)
		    end
		end

		
    end


	-- Final
    Settings.RegisterAddOnCategory(GRTK_Options_Category_Main)
end




-- Data such as player character information isn't available during the initial add-on loading phase.
-- For that reason, the entire add-on's setup is beind done at the "PLAYER_LOGIN" event instead.
-- This has the nice side-effect of being able to have different language versions for the options menu,
-- which otherwise only accepts static text via the default process.
GRTK_Event_Setup_PlayerLogin = CreateFrame("Frame")
GRTK_Event_Setup_PlayerLogin:RegisterEvent("PLAYER_LOGIN")
GRTK_Event_Setup_PlayerLogin:SetScript("OnEvent", function(_, event)
	    if GRTK_SetupComplete == false then
            GRTK_Options_Timeout = true


            -- pre-options menu setup
			GRTK_Setup_PlayerStats()
			GRTK_Setup_GameClientVersion()
			GRTK_Setup_CreateDefaultProfiles()
            GRTK_Setup_LoadLanguage()
            GRTK_Setup_DevourerUnlock()
            GRTK_Setup_VendorMountsObtained()


            -- create options menu
            GRTK_Initialization_CreateOptionsMenu()
            GRTK_Setup_ApplyProfileDataToOptionsMenu()


            -- post-options menu setup
			if GRTK_ExpansionLevel == 3 then
                GRTK_SpecChange_LoadValuesFromProfile()
            end

            -- create frames
            GRTK_CreateFrame_LockdownMessage()
            GRTK_CreateFrame_RepairMessage()
			if GRTK_ExpansionLevel > 1 then
                GRTK_CreateFrame_Mounts()
			end
			GRTK_EditMode_RegisterFramesForEditMode()


            -- create macros
            if GRTK_General_CombatCheck() == false then
			    if GRTK_ExpansionLevel > 1 then
			        GRTK_Macros_Delete("Mounts")
			    end


			    if GRTK_ExpansionLevel == 3 then
			        GRTK_Macros_Delete("Hearthstone")
                    if GRTK_UV("NilCheck", 6, "Hearthstone_List") == true then
                        GRTK_Hearthstone_GenerateNewList()
                    end
			        GRTK_Macros_Update("Hearthstone")
			    end
	        else
	            GRTK_CombatLockdown_SendMessage("Startup")
	        end
			



            -- disable certain events for older versions of the game
            GRTK_Setup_DisableEvents()


            -- create minimap button
            GRTK_Other_CreateMinimapButton()
            GRTK_General_ToggleMinimapButton()


            -- create compartment button
            if GRTK_Compartment_Enable == true then
                GRTK_CreateCompartmentButton()
            end


			RunNextFrame(function()
			    GRTK_SetupComplete = true
				GRTK_Options_Timeout = false
			end)
		end

end)