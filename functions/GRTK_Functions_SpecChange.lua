-- Assign new spec setup after a new options checkbox was being clicked
function GRTK_SpecChange_LoadValuesFromProfile()
    for i=1, GRTK_SpecChange_ChoicesTotal do
	    local GRTKTemp_VariableName = ("SpecChange_Choice_"..GRTK_PlayerStats_CurrentClassName.."_"..tostring(i))
		if GRTK_UV("Load", 2, GRTKTemp_VariableName) == true then
            GRTK_SpecChange_ChoiceOne = GRTK_SpecChange_List[i][1]
            GRTK_SpecChange_ChoiceTwo = GRTK_SpecChange_List[i][2]
        end
	end
end




-- Update chechmarks in options menu after player choice
function GRTK_SpecChange_UpdateOptionsCheckboxes()
	for i=1, GRTK_SpecChange_ChoicesTotal do
	    local GRTKTemp_VariableName = ("Choice_"..GRTK_PlayerStats_CurrentClassName.."_"..tostring(i))
		local GRTKTemp_OptionsVariableName = ("GRTK_Options_SpecChange_"..GRTKTemp_VariableName)
		local GRTKTemp_OptionsValue = GRTK_UV("Load", 2, "SpecChange_"..GRTKTemp_VariableName)
        Settings.SetValue(GRTKTemp_OptionsVariableName, GRTKTemp_OptionsValue, true)
	end
end




-- Changing specialization (use a different function depending on the expansion)
function GRTK_SpecChange_Midnight()
    local GRTKTemp_CurrentSpec = C_SpecializationInfo.GetSpecialization()
    if GRTKTemp_CurrentSpec == GRTK_SpecChange_ChoiceOne then
	    C_SpecializationInfo.SetSpecialization(GRTK_SpecChange_ChoiceTwo)
	elseif GRTKTemp_CurrentSpec == GRTK_SpecChange_ChoiceTwo then
	    C_SpecializationInfo.SetSpecialization(GRTK_SpecChange_ChoiceOne)
	else
	    C_SpecializationInfo.SetSpecialization(GRTK_SpecChange_ChoiceTwo)
	end
end

function GRTK_SpecChange_Mists() -- unused
    local GRTKTemp_CurrentSpec = C_SpecializationInfo.GetSpecialization()
    if GRTKTemp_CurrentSpec == GRTK_SpecChange_ChoiceOne then
	    SetSpecialization(GRTK_SpecChange_ChoiceTwo)
	elseif GRTKTemp_CurrentSpec == GRTK_SpecChange_ChoiceTwo then
	    SetSpecialization(GRTK_SpecChange_ChoiceOne)
	else
	    SetSpecialization(GRTK_SpecChange_ChoiceTwo)
	end
end

function GRTK_SpecChange_Vanilla()
    local GRTKTemp_CurrentTalentGroup = GetActiveTalentGroup()
	if not GRTKTemp_CurrentTalentGroup == nil then
		if GRTKTemp_CurrentTalentGroup == 1 then
	        SetActiveTalentGroup(2)
	    else
	        SetActiveTalentGroup(1)
	    end
	else
	end
end

function GRTK_SpecChange_Keybind()
    if GRTK_ExpansionLevel == 3 then
	    GRTK_SpecChange_Midnight()
	elseif GRTK_ExpansionLevel == 2 then
	    GRTK_SpecChange_Vanilla()
	elseif GRTK_ExpansionLevel == 1 then
	    GRTK_SpecChange_Vanilla()
	else
	end
end




---- Generating spec icon string for options menu
function GRTK_SpecChange_CreateIconTextString(input_slot)
    local GRTKTemp_Index1 = GRTK_SpecChange_List[input_slot][1]
	local GRTKTemp_Index2 = GRTK_SpecChange_List[input_slot][2]
	local GRTKTemp_Icon1 = GRTK_SpecChange_Icons[GRTK_PlayerStats_CurrentClass][GRTKTemp_Index1]
	local GRTKTemp_Icon2 = GRTK_SpecChange_Icons[GRTK_PlayerStats_CurrentClass][GRTKTemp_Index2]
	local GRTKTemp_Textstring = (CreateSimpleTextureMarkup(GRTKTemp_Icon1, 35, 35, 0, 0).."  /  "..CreateSimpleTextureMarkup(GRTKTemp_Icon2, 35, 35, 0, 0))
	return GRTKTemp_Textstring
end