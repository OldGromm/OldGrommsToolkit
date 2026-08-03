-- Check if a variable should be loaded/saved onto the account-wide profile or another one.
function GRTK_Variables_AllowAccountSettings(input_category)
    local GRTKTemp_CategoryName = GRTK_Variables_Categories[input_category]
    local GRTKTemp_VariableName = (GRTKTemp_CategoryName.."_UseAccountWide")
	local GRTKTemp_Proceed = false
	
	if GRTKDB_Profiles[GRTK_PlayerStats_PlayerID][GRTKTemp_VariableName] == nil or false then
	    GRTKTemp_Proceed = false
	elseif GRTKDB_Profiles[GRTK_PlayerStats_PlayerID][GRTKTemp_VariableName] == true then
	    GRTKTemp_Proceed = true
	end
	
	return GRTKTemp_Proceed
end




-- Update variable
function GRTK_UV(input_mode, input_category, input_variablename, input_value)
	local GRTKTemp_ProfileName = ""


    if input_mode == "Create" or input_mode == "SetPlayer" then
	
	else
        -- check on whether to use account-wide profile or character profile
	    if GRTK_Variables_AllowAccountSettings(input_category) == true then
	        GRTKTemp_ProfileName = "Account"
	    elseif GRTK_Variables_AllowAccountSettings(input_category) == false then
	        GRTKTemp_ProfileName = GRTK_PlayerStats_PlayerID
	    else
	    end
    end


    if input_mode == "Set" then
        GRTKDB_Profiles[GRTKTemp_ProfileName][input_variablename] = input_value
    elseif input_mode == "SetPlayer" then
        GRTKDB_Profiles[GRTK_PlayerStats_PlayerID][input_variablename] = input_value
    elseif input_mode == "Load" then
		return GRTKDB_Profiles[GRTKTemp_ProfileName][input_variablename]
    elseif input_mode == "Add" then
		tinsert(GRTKDB_Profiles[GRTKTemp_ProfileName][input_variablename], input_value)
    elseif input_mode == "Remove" then
        tremove(GRTKDB_Profiles[GRTKTemp_ProfileName][input_variablename], input_value)
    elseif input_mode == "Reset" then
		if type(GRTKDB_Profiles[GRTKTemp_ProfileName][input_variablename]) == "table" then
		    wipe(GRTKDB_Profiles[GRTKTemp_ProfileName][input_variablename])
		else
		    GRTKDB_Profiles[GRTKTemp_ProfileName][input_variablename] = nil
		end
    elseif input_mode == "MaxTableSize" then
	    local GRTKTemp_Value = next(GRTKDB_Profiles[GRTKTemp_ProfileName][input_variablename])
		local GRTKTemp_TableSize = 0
		if GRTKTemp_Value == nil then
		    GRTKTemp_TableSize = 1
		else
		    GRTKTemp_TableSize = #GRTKDB_Profiles[GRTKTemp_ProfileName][input_variablename]
		end
		return GRTKTemp_TableSize
	elseif input_mode == "NilCheck" then
	    local GRTKTemp_Boolean = false
		local GRTKTemp_Value = GRTKDB_Profiles[GRTKTemp_ProfileName][input_variablename]
		if type(GRTKTemp_Value) == "table" then
		    if next(GRTKDB_Profiles[GRTKTemp_ProfileName][input_variablename]) == nil then
                GRTKTemp_Boolean = true
            end
        elseif GRTKTemp_Value == nil then
		    GRTKTemp_Boolean = true
		end
		return GRTKTemp_Boolean
    elseif input_mode == "Create" then
	    local GRTKTemp_Profiles = { "Account", GRTK_PlayerStats_PlayerID }
	    for i, v in ipairs(GRTKTemp_Profiles) do
		    local GRTKTemp_Value = GRTKDB_Profiles[v][input_variablename]
		    if  type(GRTKTemp_Value) == "table" then
		        GRTKTemp_Value = next(GRTKDB_Profiles[v][input_variablename])
		    end
            if GRTKTemp_Value == nil then
		        GRTKDB_Profiles[v][input_variablename] = input_value
		    end
		end
    else
    end

end




-- Merge two tables
function GRTK_General_MergeTables(input_table1, input_table2)
    for _, v in ipairs(input_table2) do
	    table.insert(input_table1, v)
	end
end