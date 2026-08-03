---- add-on lockdown message
function GRTK_SendAddonLockdownMessage(input_type)
    local GRTKTemp_Type = input_type
    local GRTKTemp_Message = ""
    local GRTKTemp_ChatLockdownIsActive = C_ChatInfo.InChatMessagingLockdown()

	if GRTKTemp_Type == "Minimap" then
	    GRTKTemp_Message = GRTK_Text_CombatLockdown_MinimapButton
	elseif GRTKTemp_Type == "Mounts" then
	    GRTKTemp_Message = (GRTK_Text_CombatLockdown_Mounts.."\n"..GRTK_Text_CombatLockdown_TryAgain)
	elseif GRTKTemp_Type == "Hearthstone" then
	    GRTKTemp_Message = (GRTK_Text_CombatLockdown_Hearthstone.."\n"..GRTK_Text_CombatLockdown_TryAgain)
	else
	end


	GRTK_General_PlaySoundFile(567415, false)


	if GRTK_CombatLockdown_Message_Cooldown == false then
	    GRTK_CombatLockdown_Message_Cooldown = true
        
		if GRTK_UV("Load", 1, "General_Messages") == true then
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
		end

		C_Timer.After(1.0, function() GRTK_CombatLockdown_Message_Cooldown = false end)
	end

end