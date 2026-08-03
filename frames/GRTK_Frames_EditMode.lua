function GRTK_EditMode_CreateDefaultPositionData(input_x, input_y)
    local GRTKTemp_PositionData = {
	    point = "CENTER",
        x = input_x,
        y = input_y,
	    }
    return GRTKTemp_PositionData
end




function GRTK_EditMode_RegisterFramesForEditMode()
    local GRTKTemp_TableName = ("GRTK_EditMode_FramesList_ExpansionLevel_"..tostring(GRTK_ExpansionLevel))
	local GRTKTemp_FrameTable = _G[GRTKTemp_TableName]

    for i, v in pairs(GRTKTemp_FrameTable) do
	    local GRTKTemp_FrameName = v["framename"]
		local GRTKTemp_Frame = ""
        local GRTKTemp_DefaultPosition = GRTK_EditMode_CreateDefaultPositionData(v["coordinates_x"], v["coordinates_y"])


        if not GRTKDB_EditMode[GRTKTemp_FrameName] then
            GRTKDB_EditMode[GRTKTemp_FrameName] = {}
        end


	    if v["framename"] == "RepairMessage" then
		    GRTKTemp_Frame = GRTK_RepairMessage_Frame_ScreenMessage
		elseif v["framename"] == "Mounts" then
			GRTKTemp_Frame = GRTK_Mounts_Frame_MountMenu
		elseif v["framename"] == "CombatLockdown" then
		    GRTKTemp_Frame = GRTK_CombatLockdown_Frame_Main
		else
		end


    local function onPositionChanged(frame, layoutName, point, x, y)
        GRTKDB_EditMode[GRTKTemp_FrameName][layoutName].point = point
        GRTKDB_EditMode[GRTKTemp_FrameName][layoutName].x = x
        GRTKDB_EditMode[GRTKTemp_FrameName][layoutName].y = y
    end


    GRTK_LibEditMode:RegisterCallback("enter", function()
	    if v["framename"] == "RepairMessage" then
		    GRTK_RepairMessage_Frame_ScreenMessageEditMode:SetText(GRTK_Text_Options_Category_RepairMessage)
		elseif v["framename"] == "Mounts" then
			GRTK_MountsMenu_SavePreviousState()
	        GRTK_Mounts_Frame_MountMenu:Show()
		elseif v["framename"] == "CombatLockdown" then
		    GRTK_CombatLockdown_Frame_Message_EditMode:SetText(GRTK_Text_CombatLockdown_EditMode)
		else
		end
    end)


    GRTK_LibEditMode:RegisterCallback("exit", function()
		if v["framename"] == "RepairMessage" then
		    GRTK_RepairMessage_Frame_ScreenMessageEditMode:SetText(" ")
		elseif v["framename"] == "Mounts" then
			GRTK_MountsMenu_RestorePreviousState()
		elseif v["framename"] == "CombatLockdown" then
		     GRTK_CombatLockdown_Frame_Message_EditMode:SetText(" ")
		else
		end
       
    end)


    GRTK_LibEditMode:RegisterCallback("layout", function(layoutName)
        if not GRTKDB_EditMode[GRTKTemp_FrameName][layoutName] then
            GRTKDB_EditMode[GRTKTemp_FrameName][layoutName] = CopyTable(GRTKTemp_DefaultPosition)
        end

        GRTKTemp_Frame:ClearAllPoints()
        GRTKTemp_Frame:SetPoint(GRTKDB_EditMode[GRTKTemp_FrameName][layoutName].point, GRTKDB_EditMode[GRTKTemp_FrameName][layoutName].x, GRTKDB_EditMode[GRTKTemp_FrameName][layoutName].y)
    end)


    GRTK_LibEditMode:AddFrame(GRTKTemp_Frame, onPositionChanged, GRTKTemp_DefaultPosition)


    GRTK_LibEditMode:AddFrameSettings(GRTKTemp_Frame, {
        {
        name = GRTK_Text_EditMode_MessageScale,
        kind = GRTK_LibEditMode.SettingType.Slider,
        default = 1,
        get = function(layoutName)
            return GRTKDB_EditMode[GRTKTemp_FrameName][layoutName].scale
        end,
        set = function(layoutName, value)
            GRTKDB_EditMode[GRTKTemp_FrameName][layoutName].scale = value
            GRTKTemp_Frame:SetScale(value)
        end,
        minValue = 0.1,
        maxValue = 5,
        valueStep = 0.1,
        formatter = function(value)
            return FormatPercentage(value, true)
        end,
        }
    })

	end

end