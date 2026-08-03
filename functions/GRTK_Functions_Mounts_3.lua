-- check if player is both druid as well as worgen
function GRTK_Mounts_WorgenDruidCheck()
    local GRTKTemp_Confirm = false
    if GRTK_PlayerStats_CurrentClass == 11 then
	    if GRTK_PlayerStats_CurrentRace == 22 then
	        GRTKTemp_Confirm = true
		end
	end
	return GRTKTemp_Confirm
end


-- Make druid ground and worgen option mutually exclusive
function GRTK_Mounts_WorgenDruidOptions(input_variable, input_value)
    local GRTKTemp_Proceed = false
    local GRTKTemp_Druid = GRTK_UV("Load", 5, "Mounts_Druid_Ground")
	local GRTKTemp_Worgen = GRTK_UV("Load", 5, "Mounts_Worgen")
	
	
	-- check if both options are active now, and choose one or the other in this case.
	-- if they're both deactive or only one of them has been selected, do nothing.
	if GRTKTemp_Worgen == true then
	    if GRTKTemp_Druid == true then
		    GRTKTemp_Proceed = true
		end
	end
	
	
	if GRTKTemp_Proceed == true then
        if input_variable == "GRTK_Options_Mounts_Druid_Ground" and input_value == true then
            GRTKTemp_Druid = true
            GRTKTemp_Worgen = false
	    elseif input_variable == "GRTK_Options_Mounts_Worgen" and input_value == true then
            GRTKTemp_Druid = false
            GRTKTemp_Worgen = true
	    else
	    end

	    Settings.SetValue("GRTK_Options_Mounts_Druid_Ground", GRTKTemp_Druid, true)
	    Settings.SetValue("GRTK_Options_Mounts_Worgen", GRTKTemp_Worgen, true)
		GRTK_UV("Set", 5, "Mounts_Druid_Ground", GRTKTemp_Druid)
		GRTK_UV("Set", 5, "Mounts_Worgen", GRTKTemp_Worgen)
	end
end




-- Update mount list
function GRTK_Mounts_ResetSequence(input_type, input_subcategory)
    local GRTKTemp_Type = input_type
	local GRTKTemp_VariableName = ""
	local GRTKTemp_Category = 0
	local GRTKTemp_TableMax = 0
	local GRTKTemp_TableNoRepeats = {}
	
	if GRTKTemp_Type == "Hearthstone" then
	    GRTKTemp_Category = 6
	    GRTKTemp_VariableName = "Hearthstone_"
	elseif GRTKTemp_Type == "Mounts" then
	    GRTKTemp_Category = 5
		GRTKTemp_VariableName = ("Mounts_"..GRTK_Mounts_MountType[input_subcategory].."_")
	else
	end

    GRTKTemp_TableMax = GRTK_UV("MaxTableSize", GRTKTemp_Category, GRTKTemp_VariableName.."List")
		
	-- random
	local GRTKTemp_Random = fastrandom(1, GRTKTemp_TableMax)
	GRTK_UV("Set", GRTKTemp_Category, GRTKTemp_VariableName.."ListOrder_Random", GRTKTemp_Random)
		
	-- sequential
	GRTK_UV("Set", GRTKTemp_Category, GRTKTemp_VariableName.."ListOrder_Sequential", 1)
		
	-- no duplicates
    GRTKTemp_TableNoRepeats = GRTK_Macros_ResetNoRepeatsList(GRTKTemp_TableMax)
	GRTK_UV("Set", GRTKTemp_Category, GRTKTemp_VariableName.."ListOrder_NoRepeats", GRTKTemp_TableNoRepeats)

end




function GRTK_Mounts_ButtonFunction_UpdateList(input_type, input_ID, input_specialmount)
    local GRTKTemp_Proceed = false
    local GRTKTemp_SkipAddingMount = false
	local GRTKTemp_InputType = input_type
	local GRTKTemp_VariableName = ""
	local GRTKTemp_MountType_Number = 0
    local GRTKTemp_MountType_Ignore = false
    local GRTKTemp_MountType_Special = false
	local GRTKTemp_MountType_PaladinHorse = false
	local GRTKTemp_SteadyFlightOnly = false

    local GRTKTemp_MountType = 0
    local GRTKTemp_Cursor_InfoType, GRTKTemp_MountID, _ = GetCursorInfo()


    -- override if the input comes from the special mount dropdown menu
	if input_specialmount == true then
	    GRTKTemp_InputType = "add"
	    GRTKTemp_Cursor_InfoType = "mount"
		GRTKTemp_MountID = input_ID
	end

    if GRTKTemp_Cursor_InfoType == "mount" then
        local GRTKTemp_Obtained = select(11, C_MountJournal.GetMountInfoByID(GRTKTemp_MountID))
		GRTKTemp_SteadyFlightOnly = select(13, C_MountJournal.GetMountInfoByID(GRTKTemp_MountID))
		GRTKTemp_MountType = select(5, C_MountJournal.GetMountInfoExtraByID(GRTKTemp_MountID))

		if not GRTKTemp_Obtained then
            GRTK_General_SendChatMessage(GRTK_Text_Mounts_NotUnlocked)
		else
            GRTKTemp_Proceed = true
		end
    else
        GRTK_General_SendChatMessage(GRTK_Text_Mounts_NotaMount)
    end


    if GRTKTemp_Proceed == true then
		if GRTKTemp_MountType == 230 then -- Regular ground mounts.
		    GRTKTemp_MountType_Number = 1
		elseif GRTKTemp_MountType == 231 then --Turtles. They have increased swim speed but not increased ground speed.
		    GRTKTemp_MountType_Number = 3
		elseif GRTKTemp_MountType == 232 then -- Vashj'ir Seahorse. The add-on will use it automatically if the player has unlocked it previously.
		    GRTKTemp_MountType_Ignore = true
		elseif GRTKTemp_MountType == 241 then -- Ahn'Qiraj Battle Tanks.
		    GRTKTemp_MountType_Ignore = true
		elseif GRTKTemp_MountType == 242 then -- Swift Spectral mounts. Used when the player is dead. Cannot be used in the living world.
		    GRTKTemp_MountType_Ignore = true
		elseif GRTKTemp_MountType == 247 then -- Test Mount.
		    GRTKTemp_MountType_Ignore = true
		elseif GRTKTemp_MountType == 254 then -- Aquatic mounts.
		    GRTKTemp_MountType_Number = 3
		elseif GRTKTemp_MountType == 284 then -- Chauffeur.
		    GRTKTemp_MountType_Number = 1
		elseif GRTKTemp_MountType == 291 then -- Paladin mounts. Cannot be used with macros.
		    GRTKTemp_MountType_PaladinHorse = true
		elseif GRTKTemp_MountType == 402 then -- Original dragonriding mounts from Dragonflight expansion.
		    GRTKTemp_MountType_Number = 2
		elseif GRTKTemp_MountType == 407 then -- Otterworldly Ottuk Carrier. He has increased ground speed but no skyriding.
		    GRTKTemp_MountType_Number = 2
		elseif GRTKTemp_MountType == 408 then -- Unsuccessful Prototype Fleetpod. Has slower movement speed than other mounts.
		    GRTKTemp_MountType_Ignore = true
		elseif GRTKTemp_MountType == 409 then  -- Darcthyr's "Soar" ability.
			GRTKTemp_MountType_Number = 2
			GRTKTemp_MountType_Special = true
		elseif GRTKTemp_MountType == 411 then -- Whelpling. Used for the Dayare questline from patch 10.1.5.
		    GRTKTemp_MountType_Ignore = true
		elseif GRTKTemp_MountType == 412 then -- Ottuks.
		    GRTKTemp_MountType_Number = 3
		elseif GRTKTemp_MountType == 424 then -- Regular flying mounts.
		    GRTKTemp_MountType_Number = 2
		elseif GRTKTemp_MountType == 426 then -- Original dragonriding mounts from Dragonflight expansion.
		    GRTKTemp_MountType_Number = 2
		elseif GRTKTemp_MountType == 430 then -- Whelpling. Used for the Dayare questline from patch 10.1.5.
		    GRTKTemp_MountType_Ignore = true
		elseif GRTKTemp_MountType == 409 then  -- Darcthyr's "Soar" ability.
		    GRTKTemp_MountType_Number = 2
			GRTKTemp_MountType_Special = true
		elseif GRTKTemp_MountType == 436 then -- Aurelids.
		    GRTKTemp_MountType_Number = 2
		elseif GRTKTemp_MountType == 437 then -- Flying discs and goblin shredders.
		    GRTKTemp_MountType_Number = 2
		elseif GRTKTemp_MountType == 442 then -- Darcthyr's "Soar" ability.
		    GRTKTemp_MountType_Number = 2
			GRTKTemp_MountType_Special = true
		elseif GRTKTemp_MountType == 444 then -- Charming Courier.
		    GRTKTemp_MountType_Number = 2
		elseif GRTKTemp_MountType == 445 then -- Voyaging Wilderling.
		    GRTKTemp_MountType_Number = 2
		elseif GRTKTemp_MountType == 446 then -- Unstable Rocket.
		    GRTKTemp_MountType_Number = 2
		elseif GRTKTemp_MountType == 447 then -- Unstable Rocket.
		    GRTKTemp_MountType_Number = 2
	    else
		end


		-- Check for any of the paladin mounts
		for i, v in ipairs(GRTK_Mounts_PaladinHorseList) do
		    if GRTKTemp_MountID == v then
			    GRTKTemp_MountType_PaladinHorse = true
			end
		end

		-- Assign a Flying mount to the Ground list if any of the modifier keys are being pressed.
		if GRTKTemp_MountType_Number == 2 and IsModifierKeyDown() == true and GRTKTemp_MountType_Special == false then
		    GRTKTemp_MountType_Number = 1
		end

        -- Check for unique mounts with vendor NPCs (Yak, Brutosaur etc.)
		for i, v in ipairs(GRTK_Mounts_SpecialMountList) do
		    if v == GRTKTemp_MountID then
			    GRTKTemp_MountType_Number = 4
			end
		end


        GRTKTemp_VariableName = GRTK_Mounts_MountType[GRTKTemp_MountType_Number]


		if GRTKTemp_MountType_Ignore == true then
            GRTK_General_SendChatMessage(GRTK_Text_Mounts_ImpossibleMount)
		else
		    local GRTKTemp_Table = GRTK_UV("Load", 5, "Mounts_"..GRTKTemp_VariableName.."_List")
			if GRTKTemp_InputType == "add" then
			    if GRTKTemp_MountType_PaladinHorse == true then -- Paladin mounts
				    GRTK_General_SendChatMessage(GRTK_Text_Mounts_PaladinHorse)
					GRTKTemp_SkipAddingMount = true
		        elseif GRTKTemp_MountID == 1727 then -- Tarecgosa's Visage
                    GRTK_General_SendChatMessage(GRTK_Text_Mounts_Tarecgosa)
					GRTKTemp_SkipAddingMount = true
				else
				    --Don't add the mount if it's already on a list.
				    if GRTKTemp_Table == nil then
					
					elseif GRTKTemp_MountType_Number == 4 then
					
					else
						for i, v in ipairs(GRTKTemp_Table) do
			                if v == GRTKTemp_MountID then
                                GRTK_General_SendChatMessage(GRTK_Text_Mounts_AlreadyontheList)
					            GRTKTemp_SkipAddingMount = true
				            end
			            end
					end

			        if not GRTKTemp_SkipAddingMount then
					    if GRTKTemp_MountType_Number == 4 then
						    GRTK_UV("Set", 5, "Mounts_"..GRTKTemp_VariableName.."_List", GRTKTemp_MountID)
						else
						    GRTK_UV("Add", 5, "Mounts_"..GRTKTemp_VariableName.."_List", GRTKTemp_MountID)
					    end
						
						local GRTKTemp_Message_Add = (GRTK_Text_Mounts_MountAdded.." ("..GRTK_Macros_FetchMountName(GRTKTemp_MountID)..")")
                        GRTK_General_SendChatMessage(GRTKTemp_Message_Add)

						if GRTKTemp_MountType_Number == 2 and GRTKTemp_SteadyFlightOnly == true then -- Steady Flight-only flying mount
                            GRTK_General_SendChatMessage(GRTK_Text_Mounts_SteadyFlightOnly)
						end
						
						if GRTKTemp_MountType_Number < 4 then
						    GRTK_Mounts_ResetSequence("Mounts", GRTKTemp_MountType_Number)
						end
						GRTK_Mounts_RefreshIconList()
			        end
				end
            elseif GRTKTemp_InputType == "remove" then
			    if GRTKTemp_Table == nil then
				    GRTK_General_SendChatMessage(GRTK_Text_Mounts_ListRemove)
					GRTKTemp_SkipAddingMount = true
				else
					for i, v in ipairs(GRTKTemp_Table) do
			            if v == GRTKTemp_MountID then
						    if GRTKTemp_MountType_Number == 4 then
						        GRTK_UV("Reset", 5, "Mounts_"..GRTKTemp_VariableName.."_List")
						    else
						        GRTK_UV("Remove", 5, "Mounts_"..GRTKTemp_VariableName.."_List", i)
					        end
					        
							local GRTKTemp_Message_Remove = (GRTK_Text_Mounts_MountRemoved.." ("..GRTK_Macros_FetchMountName(GRTKTemp_MountID)..")")
                            
							GRTK_General_SendChatMessage(GRTKTemp_Message_Remove)
				            
							if GRTKTemp_MountType_Number < 4 then
							    GRTK_Mounts_ResetSequence("Mounts", GRTKTemp_MountType_Number)
						    end
							GRTK_Mounts_RefreshIconList()
					    end
			        end
				end

			else
			end
		end


		if not GRTKTemp_SkipAddingMount then
            GRTK_Macros_Update("Mounts")
		end			
	end
end




-- Reset player mount lists
function GRTK_Mounts_ButtonFunction_ResetList()
    local GRTKTemp_MountType = ""
	local GRTKTemp_Message = ""

    if IsModifierKeyDown() == true then
	    if IsAltKeyDown() == true then
		    GRTKTemp_MountType = GRTK_Mounts_MountType[1]
		elseif IsControlKeyDown() == true then
		    GRTKTemp_MountType = GRTK_Mounts_MountType[2]
		elseif IsShiftKeyDown() == true then
		    GRTKTemp_MountType = GRTK_Mounts_MountType[3]
		else
		end
		
		if GRTK_UV("NilCheck", 5, "Mounts_"..GRTKTemp_MountType.."_List") == true then
            GRTKTemp_Message = _G["GRTK_Text_Mounts_ListEmpty_"..GRTKTemp_MountType]
		else
            GRTKTemp_Message = _G["GRTK_Text_Mounts_ListReset_"..GRTKTemp_MountType]
		    GRTK_UV("Reset", 5, "Mounts_"..GRTKTemp_MountType.."_List")
		end
		
	else
	    GRTKTemp_Message = _G["GRTK_Text_Mounts_ListReset_Everything"]
	    for i, v in ipairs(GRTK_Mounts_MountType) do
		    GRTK_UV("Reset", 5, "Mounts_"..v.."_List")
		end
	end

    GRTK_Mounts_RefreshIconList()
    GRTK_Macros_Update("Mounts")
    GRTK_General_SendChatMessage(GRTKTemp_Message)
end