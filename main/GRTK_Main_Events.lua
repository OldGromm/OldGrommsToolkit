-- Repair Message
GRTK_Event_RepairMessage_ZoneChange = CreateFrame("Frame")
GRTK_Event_RepairMessage_ZoneChange:SetScript("OnEvent", function(self, event)
    GRTK_RepairMessage_Begin("newzone")
end)

GRTK_Event_RepairMessage_PlayerUnghost = CreateFrame("Frame")
GRTK_Event_RepairMessage_PlayerUnghost:SetScript("OnEvent", function(self, event)
    GRTK_RepairMessage_Begin("playerrevive")
end)





-- Sounds
---- Encounter End
GRTK_Event_Sound_EncounterEnd = CreateFrame("Frame")
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
GRTK_Event_Sound_ChallengeModeCompleted:SetScript("OnEvent", function(_, event)
	GRTK_PlayVictorySound()
end)




-- Mounts
---- Check if player is underwater by checking for breath bar.
GRTK_Event_Mounts_PlayerIsUnderwater = CreateFrame("Frame")
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
		if GRTK_General_CombatCheck() == false then
            GRTK_Macros_Update("Mounts")
	    else
	        GRTK_CombatLockdown_SendMessage("Mounts")
	    end 
    end
end)

---- Update macro if player is either mounted or dismounted.
GRTK_Event_Mounts_MountSummon = CreateFrame("Frame")
GRTK_Event_Mounts_MountSummon:SetScript("OnEvent", function(self, event)
    RunNextFrame(function()
        if not IsMounted() then
        	GRTK_Macros_AdvanceListOrder("Mounts")
        else
			if GRTK_General_CombatCheck() == false then
			    GRTK_Macros_Update("Mounts")
			else
    	        GRTK_CombatLockdown_SendMessage("Mounts")
    	    end
		end
    end)
end)

---- Update when player changes zones.
GRTK_Event_Mounts_ZoneChange = CreateFrame("Frame")
GRTK_Event_Mounts_ZoneChange:SetScript("OnEvent", function(self, event)
    if GRTK_General_CombatCheck() == false then
	    GRTK_Mounts_CheckForOverrides()
	    GRTK_Macros_Update("Mounts")
	else
	    GRTK_CombatLockdown_SendMessage("Mounts")
	end
end)




-- Hearthstone
---- Update when player changes zones.
GRTK_Event_ToysUpdated = CreateFrame("Frame")
GRTK_Event_ToysUpdated:SetScript("OnEvent", function(self, event)
    GRTK_Hearthstone_CheckCooldown()
end)




-- Combat Lockdown
GRTK_Event_CombatLockdown_PlayerEnteringWorld = CreateFrame("Frame")
GRTK_Event_CombatLockdown_PlayerEnteringWorld:RegisterEvent("PLAYER_ENTERING_WORLD")
GRTK_Event_CombatLockdown_PlayerEnteringWorld:SetScript("OnEvent", function(self, event, isLogin, isReload)
    if isLogin == true then
	    GRTKDB_Cache["CombatLockdown"] = {}
	end
end)




-- Talking Head
GRTK_Event_TalkingHead_Requested = CreateFrame("Frame")
GRTK_Event_TalkingHead_Requested:SetScript("OnEvent", function(self, event)
    local SoundID = select(3, C_TalkingHead.GetCurrentLineInfo())
	local DifficultyID = select(3, GetInstanceInfo())
	local InstanceType = select(2, GetInstanceInfo())

	GRTK_Sounds_UpdateTalkingHeadRecords(SoundID)
    if GRTK_Sounds_CheckTalkingHeadSoundID(SoundID, DifficultyID, InstanceType) == true then
	    TalkingHeadFrame:CloseImmediately()
	end
end)