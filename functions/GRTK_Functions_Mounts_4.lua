-- Mount list menu (show/hide toggle)
function GRTK_Mounts_ToggleMenu_MountList()
    if GRTK_ExpansionLevel > 1 then
        if GRTK_Mounts_Frame_MountMenu:IsShown() then
            GRTK_Mounts_Frame_MountMenu:Hide()
        else
		    GRTK_Mounts_RefreshIconList()
            GRTK_Mounts_Frame_MountMenu:Show()
        end
	end
end




-- Save previous menu visibility for edit mode
function GRTK_MountsMenu_SavePreviousState()
    if GRTK_Mounts_Frame_MountMenu:IsVisible() == true then
        GRTK_Mounts_Frame_MountMenu_Visibility = true
	elseif GRTK_Mounts_Frame_MountMenu:IsVisible() == false then
	    GRTK_Mounts_Frame_MountMenu_Visibility = false
    else
    end
end

-- Restore previous menu visibility after edit mode
function GRTK_MountsMenu_RestorePreviousState()
    if GRTK_Mounts_Frame_MountMenu_Visibility == true then
        GRTK_Mounts_Frame_MountMenu:Show()
	elseif GRTK_Mounts_Frame_MountMenu_Visibility == false then
        GRTK_Mounts_Frame_MountMenu:Hide()
    else
    end
end




-- Select function depending on the button pressed
function GRTK_Mounts_ButtonReaction(input_type)
	if GRTK_Mounts_LockButtons == false then
	    GRTK_Mounts_LockButtons = true

        if GRTK_General_CombatCheck() == false then
            if input_type == "add" then
			    GRTK_Mounts_ButtonFunction_UpdateList("add")
			elseif input_type == "remove" then
			    GRTK_Mounts_ButtonFunction_UpdateList("remove")
			elseif input_type == "reset" then
			    GRTK_Mounts_ButtonFunction_ResetList()
			else
			end
	    else
	        GRTK_CombatLockdown_SendMessage("MountMenu")
	    end

		RunNextFrame(function() GRTK_Mounts_LockButtons = false end)

	end
end