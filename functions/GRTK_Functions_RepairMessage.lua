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
	local GRTKTemp_InstanceType = select(2, GetInstanceInfo())

	-- On Retail, we're not displaying the repair message in older dungeons or raids, since
	-- they can be done solo at max level even with broken/no gear at all.
    -- Instead, we're using a custom list that includes both the current expansion instances,
	-- as well as the few older dungeons included in the current mythic+ dungeon pool.
	
	-- First we go through the list.
	-- Next, we check if this is a timewalking instance (where there is always a challenge).
	-- Lastly, we're checking for any scenario or PvP situation.
	
	-- For all other versions of WoW, the repair message will be displayed in any instance.
	if GRTK_WoWVersion == "Retail" then
		local GRTKTemp_CurrentArea = select(8, GetInstanceInfo())
        for i, v in ipairs(GRTK_InstanceList) do
	        if GRTKTemp_CurrentArea == v then
		        GRTKTemp_Proceed = true
		    end
	    end

	    local GRTKTemp_DifficultyID = select(3, GetInstanceInfo())
	    if GRTKTemp_DifficultyID == 24 then
		    GRTKTemp_Proceed = true
		end

		local GRTKTemp_InstanceTypeListRetail = {"scenario", "arena", "pvp"}
		for i, v in ipairs(GRTKTemp_InstanceTypeListRetail) do
		    if GRTKTemp_InstanceType == v then
			    GRTKTemp_Proceed = true
			end
		end
	else
		local GRTKTemp_InstanceTypeList = {"party", "raid", "scenario", "arena", "pvp"}
		for i, v in ipairs(GRTKTemp_InstanceTypeList) do
		    if GRTKTemp_InstanceType == v then
			    GRTKTemp_Proceed = true
			end
		end
	end
	
	if GRTK_UV("Load", 3, "RepairMessage_RestingArea") == true then
	    if IsResting() == true then
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