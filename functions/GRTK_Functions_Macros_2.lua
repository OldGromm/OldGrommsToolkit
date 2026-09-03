-- create macro
function GRTK_Macros_GenerateTextstring(input_type)
    local GRTKTemp_Type = input_type
    local GRTKTemp_String_Main = ""
	local GRTKTemp_String = ""
	local GRTKTemp_Start = ""
	local GRTKTemp_End = ""
	local GRTKTemp_Prefix = ""
	local GRTKTemp_Suffix = ""
	local GRTKTemp_PrefixTable = {}
	local GRTKTemp_Count = 0
	
	if GRTKTemp_Type == "Hearthstone" then
	    GRTKTemp_PrefixTable = {"", "", "", ""}
		GRTKTemp_Start = "/use "
	elseif GRTKTemp_Type == "Mounts" then
	    GRTKTemp_PrefixTable = {" [swimming,nomod]", " [flyable,nomod]", " [nomod]", ""}
		GRTKTemp_Start = "/cast"
	    GRTKTemp_End = "\n\n".."/dismount [mounted]"
	end


	for i, v in ipairs(GRTKTemp_PrefixTable) do
	    if GRTK_MacroTextBody[GRTKTemp_Type][i] == nil then
		else
            local GRTKTemp_MacroText = GRTK_MacroTextBody[GRTKTemp_Type][i]
			if v == " [swimming,nomod]" and GRTK_PlayerStats_IsUnderwater == false then
				GRTKTemp_MacroText = GRTK_MacroTextBody[GRTKTemp_Type][2]
				if GRTKTemp_MacroText == nil then
				    GRTKTemp_MacroText = ""
				end
			end

			GRTKTemp_String = (v..GRTKTemp_MacroText)

			if GRTKTemp_Count > 0 then
			    GRTKTemp_String = (";"..GRTKTemp_String)
			end
            GRTKTemp_Count = GRTKTemp_Count + 1

			GRTKTemp_String_Main = (GRTKTemp_String_Main..GRTKTemp_String)
		end
	end
	
	
	if GRTKTemp_Count > 0 then
	    GRTKTemp_String_Main = (GRTKTemp_Start..GRTKTemp_String_Main..GRTKTemp_End)
	end
    return GRTKTemp_String_Main
end




function GRTK_Macros_Create(input_type)
    local GRTKTemp_Type = input_type
	local GRTKTemp_MacroText = GRTK_Macros_GenerateTextstring(input_type)
	local GRTKTemp_MacroIcon = 0
	local GRTKTemp_Category = 0


	if GRTKTemp_Type == "Hearthstone" then
	    GRTKTemp_Category = 6
	    GRTKTemp_MacroIcon = 134414
	elseif GRTKTemp_Type == "Mounts" then
	    GRTKTemp_Category = 5
	    GRTKTemp_MacroIcon = 413588
	else
	end

    if GRTK_UV("Load", GRTKTemp_Category, GRTKTemp_Type.."_Enabled") == true then
        local GRTKTemp_MacroName = ("GRTK_"..GRTKTemp_Type)
        local GRTKTemp_MacroIndex = GetMacroIndexByName(GRTKTemp_MacroName)

        -- Check if macro exists already or not, otherwise update it.
        if GRTKTemp_MacroIndex == 0 then
            CreateMacro(GRTKTemp_MacroName, GRTKTemp_MacroIcon, GRTKTemp_MacroText)
        else
            EditMacro(GRTKTemp_MacroIndex, nil, nil, GRTKTemp_MacroText)
        end
    end

end




-- delete all macros
function GRTK_Macros_Delete(input_type)
    local GRTKTemp_Type = input_type
    local GRTKTemp_MacroName = ("GRTK_"..input_type)
	local GRTKTemp_MacroRange = { 1, 121 }

	if GRTKTemp_Type == "Hearthstone" then
	    GRTKTemp_Category = 6
    elseif GRTKTemp_Type == "Mounts" then
	    GRTKTemp_Category = 5
	else
	end

    if GRTK_UV("Load", GRTKTemp_Category, GRTKTemp_Type.."_Enabled") == false then
		for i=1, 2 do
    	    local GRTKTemp_MacroIndex = select(i, GetNumMacros())
    	    local GRTKTemp_StartingPoint = GRTKTemp_MacroRange[i]
    	    if GRTKTemp_MacroIndex == 0 or nil then

    	    else
    	    	for i=GRTKTemp_StartingPoint, GRTKTemp_MacroIndex do
    	    		local GRTKTemp_MacroName2 = select(1, GetMacroInfo(i))
    	    		if GRTKTemp_MacroName2 == GRTKTemp_MacroName then
    	    			DeleteMacro(i)
    	    		end
    			end
    	    end
    	end
	end

end




-- Generate macro modifier string
function GRTK_Macros_CreateModifierString(input_number, input_type)
    local GRTKTemp_Number = input_number
    local GRTKTemp_Type = input_type
	local GRTKTemp_ModifierType = ""
	local GRTKTemp_TextString = ""
	local GRTKTemp_EmptyReturn = false
	
	if GRTKTemp_Type == "mod" then
        if GRTKTemp_Number == nil then
		    GRTKTemp_EmptyReturn = true
		elseif GRTKTemp_Number == 1 then
		    GRTKTemp_ModifierType = "alt"
		elseif GRTKTemp_Number == 2 then
		    GRTKTemp_ModifierType = "ctrl"
		elseif GRTKTemp_Number == 3 then
		    GRTKTemp_ModifierType = "shift"
		elseif GRTKTemp_Number == 4 then
		    GRTKTemp_EmptyReturn = true
		else
		    GRTKTemp_EmptyReturn = true
		end
	elseif GRTKTemp_Type == "btn" then
	    if GRTKTemp_Number == nil then
		    GRTKTemp_EmptyReturn = true
		elseif GRTKTemp_Number == 6 then
		    GRTKTemp_EmptyReturn = true
		else
		    GRTKTemp_ModifierType = tostring(GRTKTemp_Number)
		end
	elseif GRTKTemp_Type == nil then
		GRTKTemp_EmptyReturn = true
	else
	end

	if GRTKTemp_EmptyReturn == true then
	    GRTKTemp_TextString = nil
	else
	    GRTKTemp_TextString = (GRTKTemp_Type..":"..GRTKTemp_ModifierType)
	end

	return GRTKTemp_TextString

end




-- update macro text
function GRTK_Macros_Update(input_type)
    local GRTKTemp_Type = input_type
	local GRTKTemp_Category = 0
	local GRTKTemp_ModifierType = { "ModifierButton", "ModifierMouse" }
	local GRTKTemp_ModifierButtonType = { "mod", "btn" }
	local GRTKTemp_ModifierObject = ""
	local GRTKTemp_ModifierString = {}
	local GRTKTemp_MacroString = {}
	local GRTKTemp_Comma = ""
	local GRTKTemp_MountOrHearthstoneNumber = 0
	local GRTKTemp_ModifierIndex = 0
	local GRTKTemp_Index = 0

    GRTK_MacroTextBody[input_type] = {}

    GRTK_Macros_FetchListEntry(GRTKTemp_Type)


	-- if this is the hearthstone list, and the next one is the Draenic Hologem,
	-- and this character isn't a draenei, skip this one and use the next stone in the list.
	if GRTK_ExpansionLevel == 3 then
        if GRTKTemp_Type == "Hearthstone" then
    	    local GRTKTemp_CheckForHologem = GRTK_UV("Load", 6, GRTKTemp_Type.."_ChoiceCurrent")
    		if GRTKTemp_CheckForHologem == "210455" then
    	        local GRTKTemp_GetNextToy = true
    	        if GRTK_PlayerStats_CurrentRace == 11 then
    		        GRTKTemp_GetNextToy = false
    		    elseif GRTK_PlayerStats_CurrentRace == 30 then
    		        GRTKTemp_GetNextToy = false
    		    else
    		    end

    		    if GRTKTemp_GetNextToy == true then
                    local GRTKTemp_Message = (GRTK_Text_ChatMessage_Hearthstone_DraenicHologem_PartOne.."\n"..GRTK_Text_ChatMessage_Hearthstone_DraenicHologem_PartTwo.."\n"..GRTK_Text_ChatMessage_Hearthstone_DraenicHologem_PartThree)
    			    GRTK_General_SendChatMessage(GRTKTemp_Message)
    				GRTK_Macros_AdvanceListOrder("Hearthstone")
    			    GRTK_Macros_FetchListEntry(GRTKTemp_Type)
                end
    	    
    	    end
    	end
	end


	if GRTKTemp_Type == "Hearthstone" then
	    GRTKTemp_Category = 6
		GRTKTemp_ModifierIndex = 0
        GRTKTemp_ModifierObject = {"Dalaran", "Garrison", "Arcantina"}
	elseif GRTKTemp_Type == "Mounts" then
	    GRTKTemp_Category = 5
		GRTKTemp_ModifierIndex = 3
        GRTKTemp_ModifierObject = {"SpecialMount"}
	else
	end


    -- check modifier entries
    for _, v in ipairs(GRTKTemp_ModifierObject) do
	    local GRTKTemp_MacroString_Special = ""
	    local GRTKTemp_ModifierSlot = {}
		GRTKTemp_ModifierIndex = GRTKTemp_ModifierIndex + 1
		GRTKTemp_Index = GRTKTemp_Index + 1

		---- check modifier key/mouse button choice
    	for i=1, 2 do
    	    local GRTKTemp_VariableName = (GRTKTemp_Type.."_"..GRTKTemp_ModifierType[i].."_"..GRTKTemp_ModifierObject[GRTKTemp_Index])
			local GRTKTemp_ModifierEntry = GRTK_UV("Load", GRTKTemp_Category, GRTKTemp_VariableName)
			GRTKTemp_ModifierSlot[i] = GRTK_Macros_CreateModifierString(GRTKTemp_ModifierEntry, GRTKTemp_ModifierButtonType[i])
    	end

    	---- fetch special mount name / special hearthstone name
    	if GRTKTemp_Type == "Hearthstone" then
    		GRTKTemp_MountOrHearthstoneNumber = GRTK_Hearthstone_SpecialStoneList[GRTKTemp_Index]
    	elseif GRTKTemp_Type == "Mounts" then
    		local GRTKTemp_MountID = GRTK_UV("Load", GRTKTemp_Category, "Mounts_Other_List")
			GRTKTemp_MountOrHearthstoneNumber = GRTK_Macros_FetchMountName(GRTKTemp_MountID)
    	end

		if GRTKTemp_MountOrHearthstoneNumber == nil then
            GRTK_MacroTextBody[input_type][GRTKTemp_ModifierIndex] = nil
        else
    	    ---- change textstring depending on how many modifiers are active
    	    local GRTKTemp_ModifierSlotCount = 2
			local GRTKTemp_Prefix = ""
			for i=1, 2 do
		        if GRTKTemp_ModifierSlot[i] == nil then
		    	    GRTKTemp_ModifierSlot[i] = ""
					GRTKTemp_ModifierSlotCount = GRTKTemp_ModifierSlotCount - 1
		    	end
		    end
    	    if GRTKTemp_ModifierSlotCount == 2 then
    	    	GRTKTemp_Comma = ","
    	    end

            if GRTKTemp_Type == "Hearthstone" then
			    GRTKTemp_Prefix = "item:"
			end

            if GRTKTemp_ModifierSlotCount > 0 then
        		GRTKTemp_MacroString_Special = ("["..GRTKTemp_ModifierSlot[1]..GRTKTemp_Comma..GRTKTemp_ModifierSlot[2].."]"..GRTKTemp_Prefix..tostring(GRTKTemp_MountOrHearthstoneNumber))
        	else
        		GRTKTemp_MacroString_Special = nil
        	end

            GRTK_MacroTextBody[input_type][GRTKTemp_ModifierIndex] = GRTKTemp_MacroString_Special
		end

    end


	-- check regular entries
	if GRTKTemp_Type == "Hearthstone" then
		local GRTKTemp_Current = GRTK_UV("Load", GRTKTemp_Category, GRTKTemp_Type.."_ChoiceCurrent")
		if GRTKTemp_Current == nil then
		    GRTK_MacroTextBody[input_type][4] = nil
	    else
	        GRTK_MacroTextBody[input_type][4] = ("item:"..tostring(GRTKTemp_Current))
	    end
    elseif GRTKTemp_Type == "Mounts" then
        local GRTKTemp_Index = 4
		for i=1, 3 do
		    GRTKTemp_Index = GRTKTemp_Index - 1
		    local GRTKTemp_MountType = GRTK_Mounts_MountType[i]
			local GRTKTemp_Variable = nil
			local GRTKTemp_Current = GRTK_UV("Load", GRTKTemp_Category, GRTKTemp_Type.."_"..GRTKTemp_MountType.."_ChoiceCurrent")
	        local GRTKTemp_Override = GRTK_UV("Load", GRTKTemp_Category, GRTKTemp_Type.."_"..GRTKTemp_MountType.."_ChoiceOverride")

	    	if GRTKTemp_Override == nil then
	    	    GRTKTemp_Variable = GRTKTemp_Current
	    	elseif GRTKTemp_Current == nil then
			
			else
	    	    GRTKTemp_Variable = GRTKTemp_Override
	    	end
			
			GRTK_MacroTextBody[input_type][GRTKTemp_Index] = GRTKTemp_Variable
	    end
	else
	end


    GRTK_Macros_Create(input_type)

end




function GRTK_Macros_AdvanceListOrder(input_type)
    local GRTKTemp_Type = input_type
	local GRTKTemp_Category = 0
	local GRTKTemp_VariableName = ""
	local GRTKTemp_Table = {}
	local GRTKTemp_TableMax = 0
	local GRTKTemp_Variable_Sequential = 0
	local GRTKTemp_Variable_NoRepeats = {}

    if GRTKTemp_Type == "Hearthstone" then
	    GRTKTemp_Category = 6
	    GRTKTemp_VariableName = "Hearthstone_"
	elseif GRTKTemp_Type == "Mounts" then
	    GRTKTemp_Category = 5
        if GRTK_PlayerStats_IsUnderwater == true then
            GRTKTemp_VariableName = ( "Mounts_"..GRTK_Mounts_MountType[3].."_")
        elseif IsFlyableArea() == true then
            GRTKTemp_VariableName = ( "Mounts_"..GRTK_Mounts_MountType[2].."_")
        else
            GRTKTemp_VariableName = ( "Mounts_"..GRTK_Mounts_MountType[1].."_")
        end
	end

	GRTKTemp_Variable_Sequential = GRTK_UV("Load", GRTKTemp_Category, GRTKTemp_VariableName.."ListOrder_Sequential")
	GRTKTemp_Variable_NoRepeats = GRTK_UV("Load", GRTKTemp_Category, GRTKTemp_VariableName.."ListOrder_NoRepeats")

	GRTKTemp_TableMax = GRTK_UV("MaxTableSize", GRTKTemp_Category, GRTKTemp_VariableName.."List")

	GRTKTemp_OrderType = GRTK_UV("Load", GRTKTemp_Category, GRTKTemp_VariableName.."OrderType")

	if GRTKTemp_OrderType == 1 then -- Random
	    local GRTKTemp_Random = fastrandom(1, GRTKTemp_TableMax)
		GRTK_UV("Set", GRTKTemp_Category, GRTKTemp_VariableName.."ListOrder_Random", GRTKTemp_Random)
	
	elseif GRTKTemp_OrderType == 2 then --Sequential
		GRTKTemp_Variable_Sequential = GRTKTemp_Variable_Sequential + 1
		
		if GRTKTemp_Variable_Sequential > GRTKTemp_TableMax then
			GRTKTemp_Variable_Sequential = 1
		end

        GRTK_UV("Set", GRTKTemp_Category, GRTKTemp_VariableName.."ListOrder_Sequential", GRTKTemp_Variable_Sequential)

	elseif GRTKTemp_OrderType == 3 then --Random No Repeats
	    GRTK_UV("Remove", GRTKTemp_Category, GRTKTemp_VariableName.."ListOrder_NoRepeats", 1)

	    if GRTK_UV("NilCheck", GRTKTemp_Category, GRTKTemp_VariableName.."ListOrder_NoRepeats") == true then
		    GRTKTemp_Variable_NoRepeats = GRTK_Macros_ResetNoRepeatsList(GRTKTemp_TableMax)
		else
		end

		GRTK_UV("Set", GRTKTemp_Category, GRTKTemp_VariableName.."ListOrder_NoRepeats", GRTKTemp_Variable_NoRepeats)

    else
	end
	
end