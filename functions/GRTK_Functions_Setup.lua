function GRTK_Setup_MissingPlayerDataFallback(input_type)
    local GRTKTemp_UseBackup = false
	local GRTKTemp_Output = nil

	if input_type == "Name" then
	    GRTKTemp_Output = UnitGUID("player")
	elseif input_type == "Class" then
	    _, _, GRTKTemp_Output = C_PlayerInfo.GetClass(GRTK_PlayerStats_CurrentPlayer)
	elseif input_type == "Race" then
	    GRTKTemp_Output = C_PlayerInfo.GetRace(GRTK_PlayerStats_CurrentPlayer)
	elseif input_type == "Faction" then
	    GRTKTemp_Output = select(1, UnitFactionGroup("player"))
	else
	end


	if GRTKTemp_Output == nil then
	    GRTKTemp_UseBackup = true
	end
	if issecretvalue(GRTKTemp_Output) == true then
	    GRTKTemp_UseBackup = true
	end


	if input_type == "Name" then
	    if GRTKTemp_UseBackup == true then
		    GRTKTemp_Output = "TEMP"
		    GRTK_Variables_UseTempProfileName = true
		else
		    GRTKDB_Cache["Name"] = GRTKTemp_Output
		end
	else
        if GRTKTemp_UseBackup == true then
            if GRTKDB_Cache[input_type] == nil then
                GRTK_PlayerDataError = true
            else
                if GRTKDB_Cache["Name"] == GRTK_PlayerStats_PlayerID then
                    GRTKTemp_Output = GRTKDB_Cache[input_type]
                else
                    GRTK_PlayerDataError = true
                end
    		end
    	elseif GRTKTemp_UseBackup == false then
            GRTKDB_Cache[input_type] = GRTKTemp_Output
    	    GRTKDB_Cache["Name"] = GRTK_PlayerStats_PlayerID
		else
    	end
    end

    return GRTKTemp_Output

end




function GRTK_Setup_PlayerStats()
    GRTK_PlayerStats_CurrentPlayer = PlayerLocation:CreateFromUnit("player")

    GRTK_PlayerStats_PlayerID = GRTK_Setup_MissingPlayerDataFallback("Name")
    GRTK_PlayerStats_CurrentClass = GRTK_Setup_MissingPlayerDataFallback("Class")
    GRTK_PlayerStats_CurrentRace = GRTK_Setup_MissingPlayerDataFallback("Race")	
    GRTK_PlayerStats_CurrentFaction = GRTK_Setup_MissingPlayerDataFallback("Faction")

	
	if GRTK_PlayerStats_CurrentClass == nil then
	    GRTK_PlayerStats_CurrentClassName = "ADVENTURER"
	else
	    GRTK_PlayerStats_CurrentClassName = select(2, GetClassInfo(GRTK_PlayerStats_CurrentClass))
	end


	if GRTK_Variables_UseTempProfileName == true then
	    GRTK_General_SendChatMessage(GRTK_Text_MissingCharacterName)
	end
	if GRTK_PlayerDataError == true then
	    GRTK_General_SendChatMessage(GRTK_Text_MissingPlayerData)
	end


	if GRTK_PlayerStats_CurrentFaction == "Alliance" then
	    GRTK_PlayerStats_CurrentFactionNumber = 1
	elseif GRTK_PlayerStats_CurrentFaction == "Horde" then
	    GRTK_PlayerStats_CurrentFactionNumber = 0
	elseif GRTK_PlayerStats_CurrentFaction == "Neutral" then
	    GRTK_PlayerStats_CurrentFactionNumber = 2
	else
	    GRTK_PlayerStats_CurrentFactionNumber = 2
	end
end




function GRTK_Setup_DetectGameVersion()
	if WOW_PROJECT_ID == 1 and LE_EXPANSION_LEVEL_CURRENT == 0 then -- Forever
        GRTK_WoWVersion = "Forever"
    elseif WOW_PROJECT_ID == 1 and LE_EXPANSION_LEVEL_CURRENT == 12 then -- The Last Titan
        GRTK_WoWVersion = "Retail"
    elseif WOW_PROJECT_ID == 1 and LE_EXPANSION_LEVEL_CURRENT == 11 then -- Midnight
        GRTK_WoWVersion = "Retail"
    elseif WOW_PROJECT_ID == 19 and LE_EXPANSION_LEVEL_CURRENT == 4 then -- Mists of Pandaria
        GRTK_WoWVersion = "MoP"
    elseif WOW_PROJECT_ID == 11 and LE_EXPANSION_LEVEL_CURRENT == 2 then -- Wrath of the Lich King (Titan Reforged)
        GRTK_WoWVersion = "Classic"
    elseif WOW_PROJECT_ID == 5 and LE_EXPANSION_LEVEL_CURRENT == 1 then -- The Burning Crusade
        GRTK_WoWVersion = "Classic"
    elseif WOW_PROJECT_ID == 2 and LE_EXPANSION_LEVEL_CURRENT == 0 then -- Classic Era
        GRTK_WoWVersion = "Classic"
    else
    end
end




-- Disable or change a few things depending on what version of WoW this is.
function GRTK_Setup_GameVersionAdjustments()
    local GRTKTemp_ArenaSeason = GetCurrentArenaSeason()


    ---- custon instance list for Retail for the repair message function
	if GRTK_WoWVersion == "Retail" and LE_EXPANSION_LEVEL_CURRENT == 11 then -- Midnight	    
		GRTK_General_MergeTables(GRTK_InstanceList, GRTK_InstanceData["Timeways"])
		GRTK_General_MergeTables(GRTK_InstanceList, GRTK_InstanceData["Midnight_Dungeons"])
	    GRTK_General_MergeTables(GRTK_InstanceList, GRTK_InstanceData["Midnight_Raids"])
	    GRTK_General_MergeTables(GRTK_InstanceList, GRTK_InstanceData["Midnight_Delves"])
	    GRTK_General_MergeTables(GRTK_InstanceList, GRTK_InstanceData["Midnight_Other"])
		if GRTKTemp_ArenaSeason == 41 then -- Midnight Season 1
		    GRTK_General_MergeTables(GRTK_InstanceList, GRTK_InstanceData["Midnight_Season1"])
		elseif GRTKTemp_ArenaSeason == 42 then -- Midnight Season 2
		    GRTK_General_MergeTables(GRTK_InstanceList, GRTK_InstanceData["Midnight_Season2"])
		elseif GRTKTemp_ArenaSeason == 43 then -- Midnight Season 3
		    GRTK_General_MergeTables(GRTK_InstanceList, GRTK_InstanceData["Midnight_Season3"])
		elseif GRTKTemp_ArenaSeason == 0 then -- Midnight Season 3 pre-season
		    GRTK_General_MergeTables(GRTK_InstanceList, GRTK_InstanceData["Midnight_Season2"])
		    GRTK_General_MergeTables(GRTK_InstanceList, GRTK_InstanceData["Midnight_Season3"])
		else
		end
	end


    ---- compartment button
	if GRTK_WoWVersion == "Retail" or GRTK_WoWVersion == "Forever" then
	    GRTK_Compartment_Enable = true
	end



	
	
	---- different combat lockdown messages
	if GRTK_WoWVersion == "Retail" then
	    GRTK_CombatLockdown_MessageType = {"Combat", "Encounter", "MythicPlus", "PvP"}
	else
	    GRTK_CombatLockdown_MessageType = {"Combat", "Encounter", "ChallengeMode", "PvP"}
	end


	---- retrieve the zone names for the Atal'Utek check for the mount macro
	if GRTK_WoWVersion == "Retail" then
	    GRTK_Mounts_AtalUtek_Main = C_Map.GetAreaInfo(16535)
        for i, v in ipairs(GRTK_Mounts_AtalUtek_Sub_List) do
            local GRTKTemp_ZoneName = C_Map.GetAreaInfo(v)
            tinsert(GRTK_Mounts_AtalUtek_Sub, GRTKTemp_ZoneName)
        end
	end
end




-- Enable/disable certain events from triggering. 
function GRTK_Setup_UpdateEventRegistration()

    -- Repair Message
    if GRTK_UV("Load", 3, "RepairMessage_Enabled") == true then
	    GRTK_Event_RepairMessage_ZoneChange:RegisterEvent("PLAYER_ENTERING_WORLD")
        GRTK_Event_RepairMessage_ZoneChange:RegisterEvent("ZONE_CHANGED_NEW_AREA")
		GRTK_Event_RepairMessage_PlayerUnghost:RegisterEvent("PLAYER_UNGHOST")
    else
	    GRTK_Event_RepairMessage_ZoneChange:UnregisterEvent("PLAYER_ENTERING_WORLD")
        GRTK_Event_RepairMessage_ZoneChange:UnregisterEvent("ZONE_CHANGED_NEW_AREA")
		GRTK_Event_RepairMessage_PlayerUnghost:UnregisterEvent("PLAYER_UNGHOST")
	end

    -- Sounds (Victory)
    if GRTK_UV("Load", 4, "Sounds_Victory") == 21 then
	    GRTK_Event_Sound_EncounterEnd:UnregisterEvent("ENCOUNTER_END")
		if GRTK_WoWVersion == "Retail" then
		    GRTK_Event_Sound_ChallengeModeCompleted:UnregisterEvent("CHALLENGE_MODE_COMPLETED")
		end
    else
	    GRTK_Event_Sound_EncounterEnd:RegisterEvent("ENCOUNTER_END")
		if GRTK_WoWVersion == "Retail" then
		    GRTK_Event_Sound_ChallengeModeCompleted:RegisterEvent("CHALLENGE_MODE_COMPLETED")
		end
	end

    -- Sounds (Talking Head)
	if GRTK_WoWVersion == "Retail" then
	    if GRTK_UV("Load", 4, "Sounds_TalkingHeadEnabled") == true then
	        GRTK_Event_TalkingHead_Requested:RegisterEvent("TALKINGHEAD_REQUESTED")
		else
		    GRTK_Event_TalkingHead_Requested:UnregisterEvent("TALKINGHEAD_REQUESTED")
		end
	end

    -- Mounts
	if GRTK_WoWVersion == "Retail" or GRTK_WoWVersion == "MoP" then
        if GRTK_UV("Load", 5, "Mounts_Enabled") == true then
	        GRTK_Event_Mounts_PlayerIsUnderwater:RegisterEvent("MIRROR_TIMER_START")
			GRTK_Event_Mounts_MountSummon:RegisterEvent("PLAYER_MOUNT_DISPLAY_CHANGED")
			GRTK_Event_Mounts_ZoneChange:RegisterEvent("PLAYER_ENTERING_WORLD")
			GRTK_Event_Mounts_ZoneChange:RegisterEvent("ZONE_CHANGED")
            GRTK_Event_Mounts_ZoneChange:RegisterEvent("ZONE_CHANGED_NEW_AREA")
			GRTK_Event_Mounts_ZoneChange:RegisterEvent("ZONE_CHANGED_INDOORS")
        else
	        GRTK_Event_Mounts_PlayerIsUnderwater:UnregisterEvent("MIRROR_TIMER_START")
			GRTK_Event_Mounts_MountSummon:UnregisterEvent("PLAYER_MOUNT_DISPLAY_CHANGED")
			GRTK_Event_Mounts_ZoneChange:UnregisterEvent("PLAYER_ENTERING_WORLD")
			GRTK_Event_Mounts_ZoneChange:UnregisterEvent("ZONE_CHANGED")
            GRTK_Event_Mounts_ZoneChange:UnregisterEvent("ZONE_CHANGED_NEW_AREA")
			GRTK_Event_Mounts_ZoneChange:UnregisterEvent("ZONE_CHANGED_INDOORS")
	    end
	end

    -- Hearthstone
	if GRTK_WoWVersion == "Retail" then
        if GRTK_UV("Load", 6, "Hearthstone_Enabled") == true then
	        GRTK_Event_ToysUpdated:RegisterEvent("LOADING_SCREEN_DISABLED")
        else
	        GRTK_Event_ToysUpdated:UnregisterEvent("LOADING_SCREEN_DISABLED")
	    end
	end
end




function GRTK_Setup_CreateDefaultProfiles()
    if not GRTKDB_Profiles["Account"] then
        GRTKDB_Profiles["Account"] = {}
    end
    if not GRTKDB_Profiles[GRTK_PlayerStats_PlayerID] then
        GRTKDB_Profiles[GRTK_PlayerStats_PlayerID] = {}
    end

	GRTK_UV("Create", 1, "General_Messages_Color_Red", 0.902)
	GRTK_UV("Create", 1, "General_Messages_Color_Green", 0.827)
	GRTK_UV("Create", 1, "General_Messages_Color_Blue", 0.039)

    GRTK_UV("Create", 5, "Mounts_Ground_List", {})
    GRTK_UV("Create", 5, "Mounts_Flying_List", {})
    GRTK_UV("Create", 5, "Mounts_Aquatic_List", {})
    GRTK_UV("Create", 5, "Mounts_Other_List")
    GRTK_UV("Create", 6, "Hearthstone_List", {})

	for _, v in ipairs(GRTK_Variables_NonStandardEntries) do
		local GRTKTemp_Entry = v
		local GRTKTemp_VariableName_Hearthstone = ("Hearthstone_"..GRTKTemp_Entry)
		GRTK_UV("Create", 6, GRTKTemp_VariableName_Hearthstone)

		for i=1, 4 do
		    local GRTKTemp_VariableName_Mounts = ("Mounts_"..GRTK_Mounts_MountType[i].."_"..GRTKTemp_Entry)
		    GRTK_UV("Create", 5, GRTKTemp_VariableName_Mounts)
		end
	end

    -- initialize the language variable now as opposed to when the options menu will be created later.
	-- This is being done to avoid issues with the "GRTK_Setup_LoadLanguage" function.
    GRTK_UV("Create", 1, "General_Language")
end




-- Add-on language
function GRTK_Setup_LoadLanguage()
    local GRTKTemp_GameClientLocale = GetLocale()
	
    ---- check if variable is empty
    if GRTK_UV("NilCheck", 1, "General_Language") == true then
        ---- check if the player's game client locale is supported by the add-on.
        for i, v in ipairs(GRTK_UserLanguage_SupportedLanguage) do
            if GRTKTemp_GameClientLocale == v then
				GRTK_UserLanguage_Default = i
	        end
        end
	else
	    GRTK_UserLanguage_Default = GRTK_UV("Load", 1, "General_Language")
	end
	
	
	-- load language file
	if GRTK_UserLanguage_Default == 1 then
        GRTK_LoadLanguage_enUS()
    elseif GRTK_UserLanguage_Default == 2 then
        GRTK_LoadLanguage_deDE()
    else
    end
	
end




-- Check whether the Devourer specialization has been unlocked or not
function GRTK_Setup_DevourerUnlock()
    local GRTKTemp_ExpansionLevel = GetClientDisplayExpansionLevel()
    if GRTKTemp_ExpansionLevel >= 11 then
        if GRTK_PlayerStats_CurrentClass == 12 then
            GRTK_SpecChange_UnlockedDevourerSpec = select(4, GetAchievementInfo(61916))
        end
    end
end




-- Check the number of available mounts with a vendor before creating the mount menu proper.
-- (dropdown menues cannot be updated afterwards, so this has to be done first) 
function GRTK_Setup_VendorMountsObtained()
    for _, v in ipairs(GRTK_Mounts_SpecialMountList) do
	    local GRTKTemp_MountName = GRTK_Macros_FetchMountName(v)
	    if GRTK_Mounts_CheckMountFactionUnlockStatus(v) == true then
			GRTK_Mounts_SpecialMountList_PlayerHasNone = true
			table.insert(GRTK_Mounts_SpecialMountList_Names, GRTKTemp_MountName)
			table.insert(GRTK_Mounts_SpecialMountList_Final, v)
		end
	end
end




-- Check if garrison has been unlocked on that character
function GRTK_Setup_GarrisonUnlocked()
    local GRTKTemp_Unlocked = false
	if C_QuestLog.IsQuestFlaggedCompleted(34378) == true then -- Establish Your Garrison (Horde)
		GRTKTemp_Unlocked = true
	end
	if C_QuestLog.IsQuestFlaggedCompleted(34586) == true then -- Establish Your Garrison (Alliance)
		GRTKTemp_Unlocked = true
	end
    return GRTKTemp_Unlocked
end




-- Update the settings with the player's profile data (if profile data exists).
function GRTK_Setup_ApplyProfileDataToOptionsMenu()
    -- check both the Account profile as well as the player character profile.
    for i, v in ipairs(GRTK_Variables_Categories) do
	    GRTK_Options_ApplyProfile(i)
    end
	
	-- check for the "UseAccountWide" variables separately since only the player character profile version of it matters.
	for i, v in ipairs(GRTK_Variables_Categories) do
	    local GRTKTemp_VariableName = (v.."_UseAccountWide")
	    local GRTKTemp_SettingsName = ("GRTK_Options_"..GRTKTemp_VariableName)
		local GRTKTemp_SettingsValue = GRTKDB_Profiles[GRTK_PlayerStats_PlayerID][GRTKTemp_VariableName]
		
		if GRTKTemp_SettingsValue == nil then
		
		else
		    Settings.SetValue(GRTKTemp_SettingsName, GRTKTemp_SettingsValue, true)
		end
	end

end