function GRTK_Mounts_CheckSpecialGroundMountUnlock(input_type)
    local GRTKTemp_MountList = {}
	local GRTKTemp_UnlockedMounts = {}
	if input_type == "Qiraji" then
	    GRTKTemp_MountList = {117, 118, 119, 120}
	elseif input_type == "Maw" then
	    GRTKTemp_MountList = {1304, 1441, 1442}
	else
	end
	
	for i, v in ipairs(GRTKTemp_MountList) do
	    local GRTKTemp_Unlocked = select(11, C_MountJournal.GetMountInfoByID(v))
        if GRTKTemp_Unlocked == true then
		    tinsert(GRTKTemp_UnlockedMounts, v)
		end
	end

    if not GRTKTemp_UnlockedMounts == nil then
        local GRTKTemp_Index = fastrandom(1, #GRTKTemp_UnlockedMounts)
        local GRTKTemp_MountID = GRTKTemp_UnlockedMounts[GRTKTemp_Index]
        GRTK_UV("Set", 5, "Mounts_Ground_ChoiceOverride", GRTK_Macros_FetchMountName(GRTKTemp_MountID))
	end
end




function GRTK_Mounts_CheckForOverrides()
    -- Check for zone-specific mounts and override the player's mount choice temporarily.
	local GRTKTemp_uiMapID = C_Map.GetBestMapForUnit("player")
	local GRTKTemp_ForceRegularMount = false
	local GRTKTemp_ExilesReach = false
	local GRTKTemp_UnlockedSeahorse = select(11, C_MountJournal.GetMountInfoByID(373))
	local GRTKTemp_UseSeahorse = false
	local GRTKTemp_UnlockedMountsInTheMaw = C_QuestLog.IsQuestFlaggedCompleted(63994)


	for i, v in ipairs(GRTK_Mounts_MountType) do
		GRTK_UV("Reset", 5, "Mounts_"..v.."_ChoiceOverride")
	end


    -- Exile's Reach (Starter Area)
	if GRTKTemp_uiMapID == 1726 then 
	    GRTKTemp_ExilesReach = true
	elseif GRTKTemp_uiMapID == 1727 then
	    GRTKTemp_ExilesReach = true
	elseif GRTKTemp_uiMapID == 1409 then
	    GRTKTemp_ExilesReach = true
	-- Temple of Ahn'Qiraj (Raid)
	elseif GRTKTemp_uiMapID == 319 then
	    GRTK_Mounts_QirajiBattleTanks()GRTK_Mounts_CheckSpecialGroundMountUnlock("Qiraji")
	elseif GRTKTemp_uiMapID == 320 then
	    GRTK_Mounts_QirajiBattleTanks()GRTK_Mounts_CheckSpecialGroundMountUnlock("Qiraji")
	elseif GRTKTemp_uiMapID == 321 then
	    GRTK_Mounts_QirajiBattleTanks()GRTK_Mounts_CheckSpecialGroundMountUnlock("Qiraji")
	-- Vashj'ir (Open-world Zone)
	elseif GRTKTemp_uiMapID == 201 then
        GRTKTemp_UseSeahorse = true
	elseif GRTKTemp_uiMapID == 203 then
        GRTKTemp_UseSeahorse = true
	elseif GRTKTemp_uiMapID == 204 then
        GRTKTemp_UseSeahorse = true
	elseif GRTKTemp_uiMapID == 205 then
        GRTKTemp_UseSeahorse = true
	-- The Maw (Open-world Zone)
	elseif GRTKTemp_uiMapID == 1543 then
	    if not GRTKTemp_UnlockedMountsInTheMaw then -- Check if the player has obtained "The True Maw Walker" on that character.
			GRTK_Mounts_CheckSpecialGroundMountUnlock("Maw")
		end
	-- Manaforge Omega (Raid)
    elseif GRTKTemp_uiMapID == 2460 then
	    GRTKTemp_ForceRegularMount = true
    elseif GRTKTemp_uiMapID == 2461 then
	    GRTKTemp_ForceRegularMount = true
    elseif GRTKTemp_uiMapID == 2462 then
	    GRTKTemp_ForceRegularMount = true
    elseif GRTKTemp_uiMapID == 2464 then
	    GRTKTemp_ForceRegularMount = true
    elseif GRTKTemp_uiMapID == 2465 then
	    GRTKTemp_ForceRegularMount = true
    elseif GRTKTemp_uiMapID == 2466 then
	    GRTKTemp_ForceRegularMount = true
    elseif GRTKTemp_uiMapID == 2467 then
	    GRTKTemp_ForceRegularMount = true
    elseif GRTKTemp_uiMapID == 2468 then
	    GRTKTemp_ForceRegularMount = true
    elseif GRTKTemp_uiMapID == 2469 then
	    GRTKTemp_ForceRegularMount = true
    elseif GRTKTemp_uiMapID == 2470 then
	    GRTKTemp_ForceRegularMount = true
    elseif GRTKTemp_uiMapID == 2471 then
	    GRTKTemp_ForceRegularMount = true
	else
	end


    -- Override mount choice if the character's class is druid, or if the character's race is either worgen or evoker.
	-- However, don't do any overrides for specific locations (currently only Manaforge Omega requires this due to the last boss needing a flying mount).
	if not GRTKTemp_ForceRegularMount then
        if GRTK_PlayerStats_CurrentClass == 11 then --Druid
            for i=1, 3 do
                local GRTKTemp_Type = GRTK_Mounts_MountType[i]
                local GRTKTemp_Option_Druid = GRTK_UV("Load", 5, "Mounts_Druid_"..GRTKTemp_Type)
    			
                if GRTKTemp_Option_Druid == true then
                    if i == 3 and GRTKTemp_UseSeahorse == true then
                    else
                        GRTK_UV("Set", 5, "Mounts_"..GRTKTemp_Type.."_ChoiceOverride", GRTK_Macros_FetchMountName("TravelForm"))
                    end
                end
            end
        elseif GRTK_PlayerStats_CurrentRace == 22 then --Worgen
                local GRTKTemp_Option_Worgen = GRTK_UV("Load", 5, "Mounts_Worgen")
    			
                if GRTKTemp_Option_Worgen == true then
                    GRTK_UV("Set", 5, "Mounts_Ground_ChoiceOverride", GRTK_Macros_FetchMountName("Worgen"))
                end
        elseif GRTK_PlayerStats_CurrentRace == 52 then --Dracthyr (Alliance)
                local GRTKTemp_Option_Dracthyr = GRTK_UV("Load", 5, "Mounts_Dracthyr")
    			
                if GRTKTemp_Option_Dracthyr == true then
                    GRTK_UV("Set", 5, "Mounts_Ground_ChoiceOverride", GRTK_Macros_FetchMountName("Soar"))
                end
        elseif GRTK_PlayerStats_CurrentRace == 70 then --Dracthyr (Horde)
                local GRTKTemp_Option_Dracthyr = GRTK_UV("Load", 5, "Mounts_Dracthyr")
    			
                if GRTKTemp_Option_Dracthyr == true then
                    GRTK_UV("Set", 5, "Mounts_Ground_ChoiceOverride", GRTK_Macros_FetchMountName("Soar"))
                end
        else
        end
    end


    -- Override some settings even if druid travel form is enabled.	
	---- Vashj'ir (Open-world Zone)
    if GRTKTemp_UseSeahorse == true then
	    if GRTKTemp_UnlockedSeahorse == true then
		    GRTK_UV("Set", 5, "Mounts_Aquatic_ChoiceOverride", GRTK_Macros_FetchMountName(373))
	    end
    end


    ---- Undermine (Open-world Zone) & Liberation of Undermine (Raid)
	if GRTKTemp_uiMapID == 2406 then
	    GRTK_UV("Set", 5, "Mounts_Ground_ChoiceOverride", GRTK_Macros_FetchMountName("Undermine"))
	elseif GRTKTemp_uiMapID == 2346 then
	    GRTK_UV("Set", 5, "Mounts_Ground_ChoiceOverride", GRTK_Macros_FetchMountName("Undermine"))
	else
	end


    ---- Use the motorcycle, as it's the only mount that works on Exile's Reach.
    if GRTKTemp_ExilesReach == true then
	    if GRTK_Mounts_CheckMountFactionUnlockStatus(679) == true then
		    GRTK_UV("Set", 5, "Mounts_Ground_ChoiceOverride", GRTK_Macros_FetchMountName(679))
	    elseif GRTK_Mounts_CheckMountFactionUnlockStatus(678) == true then
		    GRTK_UV("Set", 5, "Mounts_Ground_ChoiceOverride", GRTK_Macros_FetchMountName(679))
	    end
    end
end