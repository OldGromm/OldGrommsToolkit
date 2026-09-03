function GRTK_RepairMessage_PlaySoundeffect()
    local GRTKTemp_SoundIndex = GRTK_UV("Load", 3, "RepairMessage_Sound")
    local GRTKTemp_SoundID = GRTK_RepairMessage_SoundEntries[GRTKTemp_SoundIndex]
    GRTK_General_PlaySoundFile(GRTKTemp_SoundID, false)
end




function GRTK_RepairMessage_SendMessage()
	if GRTK_General_CombatCheck() == false then
        GRTK_RepairMessage_PlaySoundeffect()

        GRTK_RepairMessage_Frame_ScreenMessageText:SetText(GRTK_Text_Options_RepairMessage_Message)
        C_Timer.After(7.0, function()
            GRTK_RepairMessage_Frame_ScreenMessageText:SetText("")
			GRTK_RepairMessage_OneProcessAlreadyRunning = false
        end)
    end
end




function GRTK_RepairMessage_CheckDurability()
    local GRTKTemp_SendWarning = false
    for i=1, 18 do
	    local GRTKTemp_InventoryStatus = GetInventoryAlertStatus(i)

		if GRTKTemp_InventoryStatus > 0 then
		    GRTKTemp_SendWarning = true
		end
	end

	-- send message if any of the gear pieces are critical or broken state
	if GRTKTemp_SendWarning == true then
	    C_Timer.After(3.0, function() GRTK_RepairMessage_SendMessage() end)
	else
	    C_Timer.After(5.0, function() GRTK_RepairMessage_OneProcessAlreadyRunning = false end)
	end
end




function GRTK_RepairMessage_CheckCurrentLocation()
    local GRTKTemp_Proceed = false
	local GRTKTemp_CurrentArea = select(8, GetInstanceInfo())
    for i, v in ipairs(GRTK_InstanceList) do
	    if GRTKTemp_CurrentArea == v then
		    GRTKTemp_Proceed = true
		end
	end

	if GRTK_ExpansionLevel == 3 then
	    local GRTKTemp_DifficultyID = select(3, GetInstanceInfo())
	    if GRTKTemp_DifficultyID == 24 then
		    GRTKTemp_Proceed = true
		end
	end

	if GRTKTemp_Proceed == true then
	    GRTK_RepairMessage_CheckDurability()
	else
	    C_Timer.After(5.0, function() GRTK_RepairMessage_OneProcessAlreadyRunning = false end)
	end
end




function GRTK_RepairMessage_Begin(input_type)
    if GRTK_UV("Load", 3, "RepairMessage_Enabled") == true then
        if GRTK_RepairMessage_OneProcessAlreadyRunning == false then
	        GRTK_RepairMessage_OneProcessAlreadyRunning = true
		    if input_type == "newzone" then
                GRTK_RepairMessage_CheckCurrentLocation()
			elseif input_type == "playerrevive" then
                GRTK_RepairMessage_CheckDurability()
			else
			end
	    end
	end
end