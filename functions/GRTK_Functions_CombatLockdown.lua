function GRTK_CombatLockdown_CheckIfPlayerHasChanged()
    if GRTKDB_Cache["Name"] == GRTK_PlayerStats_PlayerID then
        
    else
        GRTKDB_Cache["CombatLockdown"] = {}
    end
end




function GRTK_CombatLockdown_SendMessage(input_type)
    local GRTKTemp_Type = input_type
	local GRTKTemp_Message = _G["GRTK_Text_CombatLockdown_"..GRTKTemp_Type]
	local GRTKTemp_Reason = ""
    local GRTKTemp_ChatLockdownIsActive = C_ChatInfo.InChatMessagingLockdown()
	local GRTKTemp_LockdownIndex = -1
	local GRTKTemp_Proceed = false


    GRTK_CombatLockdown_CheckIfPlayerHasChanged()

    ---- determine error type (also check for how often the current error type has been triggered)
    for i, v in ipairs(GRTK_CombatLockdown_MessageType) do
	    GRTKTemp_LockdownIndex = GRTKTemp_LockdownIndex + 1
		if C_RestrictedActions.IsAddOnRestrictionActive(GRTKTemp_LockdownIndex) == true then
		    GRTKTemp_Reason = _G["GRTK_Text_CombatLockdown_"..v]

			if GRTKDB_Cache["CombatLockdown"][v] == nil then
			    GRTKDB_Cache["CombatLockdown"][v] = 0
				GRTKTemp_Proceed = true
			else
			    GRTKDB_Cache["CombatLockdown"][v] = GRTKDB_Cache["CombatLockdown"][v] + 1
			end

		end
	end


    ---- prepare text message
    if GRTKTemp_Reason == "" then
	
	else
	    GRTKTemp_Message = (GRTKTemp_Message.."\n"..GRTK_Text_CombatLockdown_Reason..": "..GRTKTemp_Reason)
	end

	if GRTKTemp_Type == "Settings" then
	    GRTKTemp_Message = (GRTKTemp_Message.."\n"..GRTK_Text_CombatLockdown_TryAgain)
	end


    ---- only show message once, or never, or all the time (depending on the player setting)
	if GRTK_UV("Load", 1, "General_CombatLockdown") == 1 then
        GRTKTemp_Proceed = false
	elseif GRTK_UV("Load", 1, "General_CombatLockdown") == 2 then
	
	elseif GRTK_UV("Load", 1, "General_CombatLockdown") == 3 then
	    GRTKTemp_Proceed = true
	else
	end


    ---- run the actual message
    if GRTKTemp_Proceed == false then
	
	else

	    GRTK_General_PlaySoundFile(567415, false)

        if GRTK_CombatLockdown_Message_Cooldown == false then
	        GRTK_CombatLockdown_Message_Cooldown = true

            if GRTKTemp_ChatLockdownIsActive == false then
                GRTK_General_SendChatMessage(GRTKTemp_Message)
            elseif GRTKTemp_ChatLockdownIsActive == true then
                if GRTK_CombatLockdown_Message_Count == 0 then
                    GRTK_CombatLockdown_Message_Count = GRTK_CombatLockdown_Message_Count + 1
                    GRTK_CombatLockdown_Frame_Message_01:SetText(GRTKTemp_Message)
                    C_Timer.After(7.0, function()
                        GRTK_CombatLockdown_Frame_Message_01:SetText("")
                        GRTK_CombatLockdown_Message_Count = GRTK_CombatLockdown_Message_Count - 1
                    end)
                elseif GRTK_CombatLockdown_Message_Count == 1 then
                    GRTK_CombatLockdown_Message_Count = GRTK_CombatLockdown_Message_Count + 1
                    GRTK_CombatLockdown_Frame_Message_02:SetText(GRTKTemp_Message)
                    C_Timer.After(7.0, function()
                        GRTK_CombatLockdown_Frame_Message_02:SetText("")
                        GRTK_CombatLockdown_Message_Count = GRTK_CombatLockdown_Message_Count - 1
                    end)
                elseif GRTK_CombatLockdown_Message_Count == 2 then
                    GRTK_CombatLockdown_Message_Count = GRTK_CombatLockdown_Message_Count + 1
                    GRTK_CombatLockdown_Frame_Message_03:SetText(GRTKTemp_Message)
                    C_Timer.After(7.0, function()
                        GRTK_CombatLockdown_Frame_Message_03:SetText("")
                        GRTK_CombatLockdown_Message_Count = GRTK_CombatLockdown_Message_Count - 1
                    end)
                else
                end
            else
            end
    
    		C_Timer.After(1.0, function() GRTK_CombatLockdown_Message_Cooldown = false end)
    	end
	
	end

end