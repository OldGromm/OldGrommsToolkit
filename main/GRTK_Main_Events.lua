-- Repair Message
GRTK_Event_RepairMessage_ZoneChange = CreateFrame("Frame")
GRTK_Event_RepairMessage_ZoneChange:RegisterEvent("PLAYER_ENTERING_WORLD")
GRTK_Event_RepairMessage_ZoneChange:RegisterEvent("ZONE_CHANGED_NEW_AREA")
GRTK_Event_RepairMessage_ZoneChange:SetScript("OnEvent", function(self, event)
    GRTK_RepairMessage_Begin()
end)




-- Sounds
---- Encounter End
GRTK_Event_Sound_EncounterEnd = CreateFrame("Frame")
GRTK_Event_Sound_EncounterEnd:RegisterEvent("ENCOUNTER_END")
GRTK_Event_Sound_EncounterEnd:SetScript("OnEvent", function(_, event, _, _, difficultyID, _, success)
    if difficultyID == 8 then

    else
        if success == 1 then
            GRTK_PlayVictorySound()
        end
    end
end)

---- Mythic+
GRTK_Event_Sound_ChallengeModeCompleted = CreateFrame("Frame")
GRTK_Event_Sound_ChallengeModeCompleted:RegisterEvent("CHALLENGE_MODE_COMPLETED")
GRTK_Event_Sound_ChallengeModeCompleted:SetScript("OnEvent", function(_, event)
	GRTK_PlayVictorySound()
end)




-- Mounts
---- Check if player is underwater by checking for breath bar.
GRTK_Event_Mounts_PlayerIsUnderwater = CreateFrame("Frame")
GRTK_Event_Mounts_PlayerIsUnderwater:RegisterEvent("MIRROR_TIMER_START")
GRTK_Event_Mounts_PlayerIsUnderwater:SetScript("OnEvent", function(_, event, timerName)
    if timerName == "BREATH" then
    	local GRTKTemp_MirrorTimer = GetMirrorTimerProgress("BREATH")
    	if GRTKTemp_MirrorTimer == 0 then
    	    GRTK_PlayerStats_IsUnderwater = true
    	else
    		if IsFlyableArea() == true then
    	        GRTK_PlayerStats_IsUnderwater = false
    		else
    			GRTK_PlayerStats_IsUnderwater = true
    		end
    	end
        GRTK_Macros_Update("Mounts")
    end
end)

---- Update macro if player is either mounted or dismounted.
GRTK_Event_Mounts_MountSummon = CreateFrame("Frame")
GRTK_Event_Mounts_MountSummon:RegisterEvent("PLAYER_MOUNT_DISPLAY_CHANGED")
GRTK_Event_Mounts_MountSummon:SetScript("OnEvent", function(self, event)
    if not IsMounted() then
	    RunNextFrame(function()
    	GRTK_Macros_AdvanceListOrder("Mounts")
		GRTK_Macros_Update("Mounts")
		end)
    end
end)

---- Update when player changes zones.
GRTK_Event_Mounts_ZoneChange = CreateFrame("Frame")
GRTK_Event_Mounts_ZoneChange:RegisterEvent("PLAYER_ENTERING_WORLD")
GRTK_Event_Mounts_ZoneChange:RegisterEvent("ZONE_CHANGED_NEW_AREA")
GRTK_Event_Mounts_ZoneChange:SetScript("OnEvent", function(self, event)
	GRTK_Mounts_CheckForOverrides()
	GRTK_Macros_Update("Mounts")
end)




-- Hearthstone
---- Update when player changes zones.
GRTK_Event_ToysUpdated = CreateFrame("Frame")
GRTK_Event_ToysUpdated:RegisterEvent("LOADING_SCREEN_DISABLED")
GRTK_Event_ToysUpdated:SetScript("OnEvent", function(self, event)
    GRTK_Hearthstone_CheckCooldown()
end)