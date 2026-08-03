-- send chat message to show the player which hearthstone toys are still missing.
-- (uses the source information from the toys' tooltips)
function GRTK_Hearthstone_NotUnlockedYet()
    local GRTKTemp_VariableType = " "
	if GRTK_Hearthstone_Missing_Count == 0 then
        GRTK_General_SendChatMessage(GRTK_Text_ChatMessage_Hearthstone_EverythingUnlocked)
	else
        GRTK_General_SendChatMessage(GRTK_Text_ChatMessage_Hearthstone_Missing)
        for i, v in ipairs(GRTK_Hearthstone_Missing_List) do
		    local GRTKTemp_Message = ""
			local GRTKTemp_Source_Final = ""
            local GRTKTemp_ToyID = v
			local GRTKTemp_IconID = select(3, C_ToyBox.GetToyInfo(GRTKTemp_ToyID))
            local GRTKTemp_Icon = CreateSimpleTextureMarkup(GRTKTemp_IconID, 12, 12, 0, 0)
            local GRTKTemp_Name = select(2, C_ToyBox.GetToyInfo(GRTKTemp_ToyID))
            local GRTKTemp_Source = ""
			local GRTKTemp_TooltipData = C_TooltipInfo.GetToyByItemID(GRTKTemp_ToyID)
			for _, tooltipvar in ipairs(GRTKTemp_TooltipData.lines) do
			    if tooltipvar.type == 29 then
				    GRTKTemp_Source = tooltipvar.leftText
				end
			end

            if GRTKTemp_Source == nil then
                GRTKTemp_Source_Final = GRTK_Text_Options_Hearthstone_Missing_SourceUnknown
            else
                GRTKTemp_Source_Final = GRTKTemp_Source
            end

			GRTKTemp_Message = ("\n"..GRTKTemp_Icon.." "..GRTKTemp_Name.."\n"..GRTK_Text_Options_Hearthstone_Missing_Source.."\n"..GRTKTemp_Source_Final)
			GRTK_General_SendChatMessage(GRTKTemp_Message)
        end
	end
end




-- create new list when changing profiles
function GRTK_Hearthstone_GenerateNewList()
    GRTK_UV("Reset", 6, "Hearthstone_List")
    for i, v in ipairs(GRTK_Hearthstone_List) do
        local GRTKTemp_ToyID = v
        local GRTKTemp_VariableName = ("Hearthstone_ToyID_"..tostring(GRTKTemp_ToyID))
        if GRTK_UV("Load", 6, GRTKTemp_VariableName) == true then
            GRTK_UV("Add", 6, "Hearthstone_List", GRTKTemp_ToyID)
        end
    end
	GRTK_Mounts_ResetSequence("Hearthstone", 0)
end




-- check if hearthstone is on cooldown
function GRTK_Hearthstone_CheckCooldown()
    RunNextFrame(function()
    	local GRTKTemp_SpellCooldownInfo = C_Spell.GetSpellCooldown(8690)
    	local GRTKTemp_Proceed = false

    	if GRTKTemp_SpellCooldownInfo.isActive == true then
    		---- proceed if hearthstone was never used before this session,
    		---- or if the player entered a loading screen after the cooldown recovered.
    		if GRTK_Hearthstone_Cooldown == 0 then
                GRTKTemp_Proceed = true
    		---- proceed if the previously-saved cooldown value is lower than the curent one
    		---- (which can only be the case if this is a new hearthstone).
    		elseif GRTK_Hearthstone_Cooldown <= GRTKTemp_SpellCooldownInfo.timeUntilEndOfStartRecovery then
    		    GRTKTemp_Proceed = true
    		else
    		end

    		if GRTKTemp_Proceed == true then
                GRTK_Macros_AdvanceListOrder("Hearthstone")
    		    GRTK_Macros_Update("Hearthstone")
    		end
    	end

    	if GRTKTemp_SpellCooldownInfo.timeUntilEndOfStartRecovery == nil then
    	    GRTK_Hearthstone_Cooldown = 0
    	else
    	    GRTK_Hearthstone_Cooldown = GRTKTemp_SpellCooldownInfo.timeUntilEndOfStartRecovery
    	end
    end)
end