function GRTK_Macros_FetchMountName(input_mountID)
    local GRTKTemp_Textstring = ""

    if input_mountID == nil then
        GRTKTemp_Textstring = nil
    elseif input_mountID == "TravelForm" then
	    GRTKTemp_Textstring = C_Spell.GetSpellName(783)
	elseif input_mountID == "Soar" then
	    GRTKTemp_Textstring = C_Spell.GetSpellName(369536)
	elseif input_mountID == "Worgen" then
	    GRTKTemp_Textstring = C_Spell.GetSpellName(87840)
	elseif input_mountID == "Undermine" then
	    GRTKTemp_Textstring = C_Spell.GetSpellName(460013)
	else
        GRTKTemp_Textstring = select(1, C_MountJournal.GetMountInfoByID(input_mountID))
    end
	
	return GRTKTemp_Textstring
end




function GRTK_Macros_FetchMountIcon(input_mountID)
    local GRTKTemp_IconID = 134400

    if input_mountID == nil then
        GRTKTemp_IconID = 134400
    elseif input_mountID == "TravelForm" then
	    GRTKTemp_IconID = 132144
	elseif input_mountID == "Soar" then
	    GRTKTemp_IconID = 4622485
	elseif input_mountID == "Worgen" then
	    GRTKTemp_IconID = 514641
	elseif input_mountID == "Undermine" then
	    GRTKTemp_IconID = 6383558
	else
        GRTKTemp_IconID = select(3, C_MountJournal.GetMountInfoByID(input_mountID))
    end

    if GRTKTemp_IconID == nil then
        GRTKTemp_IconID = 134400
	end

	local GRTKTemp_output = CreateSimpleTextureMarkup(GRTKTemp_IconID, 30, 30, 0, 0)
    return GRTKTemp_output
end




function GRTK_Macros_FetchListEntry(input_type)
    local GRTKTemp_Category = 0
    local GRTKTemp_LoopCount = 0
	local GRTKTemp_VariableName = ""


	if input_type == "Hearthstone" then
	    GRTKTemp_Category = 6
	    GRTKTemp_LoopCount = 1
	elseif input_type == "Mounts" then
	    GRTKTemp_Category = 5
	    GRTKTemp_LoopCount = 3
	else
	end

	for i=1, GRTKTemp_LoopCount do
        if input_type == "Hearthstone" then
		    GRTKTemp_VariableName = "Hearthstone_"
		elseif input_type == "Mounts" then
            GRTKTemp_VariableName = ("Mounts_"..GRTK_Mounts_MountType[i].."_")
	    end


        local GRTKTemp_OrderTypeNumber = GRTK_UV("Load", GRTKTemp_Category, GRTKTemp_VariableName.."OrderType")
        if GRTKTemp_OrderTypeNumber == nil then
		    GRTKTemp_OrderTypeNumber = 1
		end

		
		local GRTKTemp_OrderType = GRTK_Mounts_OrderType[GRTKTemp_OrderTypeNumber]
		local GRTKTemp_Index = 0
		if GRTKTemp_OrderType == "NoRepeats" then
            local GRTKTemp_Table = GRTK_UV("Load", GRTKTemp_Category, GRTKTemp_VariableName.."ListOrder_"..GRTKTemp_OrderType)
			if GRTKTemp_Table == nil then
			GRTKTemp_Table = { 1 }
			end
			GRTKTemp_Index = GRTKTemp_Table[1]
		else
            GRTKTemp_Index = GRTK_UV("Load", GRTKTemp_Category, GRTKTemp_VariableName.."ListOrder_"..GRTKTemp_OrderType)
		end


        -- check if list is empty or not
		if GRTK_UV("NilCheck", GRTKTemp_Category, GRTKTemp_VariableName.."List") == true then
		    GRTK_UV("Reset", GRTKTemp_Category, GRTKTemp_VariableName.."ChoiceCurrent")
		else
		    local GRTKTemp_List = GRTK_UV("Load", GRTKTemp_Category, GRTKTemp_VariableName.."List")
		    local GRTKTemp_MountID = GRTKTemp_List[GRTKTemp_Index]
			local GRTKTemp_MountString = ""

			if input_type == "Mounts" then
                GRTKTemp_MountString = GRTK_Macros_FetchMountName(GRTKTemp_MountID)
			elseif input_type == "Hearthstone" then
                if GRTKTemp_MountID == nil then
				    GRTKTemp_MountString = nil
				else
				    GRTKTemp_MountString = tostring(GRTKTemp_MountID)
				end
				
			else
			end
			
			GRTK_UV("Set", GRTKTemp_Category, GRTKTemp_VariableName.."ChoiceCurrent", GRTKTemp_MountString)
		end

    end
end




function GRTK_Macros_ResetNoRepeatsList(input_number)
    local GRTKTemp_Table = {}
    for i=1, input_number do
        local GRTKTemp_RandomPosition = fastrandom(1, 2)
		if GRTKTemp_RandomPosition == 1 then
			table.insert(GRTKTemp_Table, i)
		else
			table.insert(GRTKTemp_Table, 1, i)
		end
	end
    return GRTKTemp_Table
end