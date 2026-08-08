function GRTK_Other_OpenSettingsMenu()
    if GRTK_General_CombatCheck() == false then
	    -- create link for opening the options menu.
	    local GRTKTemp_SettingsLink = GRTK_Options_Category_Main:GetID()
        Settings.OpenToCategory(GRTKTemp_SettingsLink)
	else
	    GRTK_CombatLockdown_SendMessage("MinimapButton")
	end
end




-- Compartment
function GRTK_CreateCompartmentButton()
    if GRTK_UV("Load", 1, "General_CompartmentButton") == true then
        AddonCompartmentFrame:RegisterAddon({
            text = GRTK_Text_Options_Category_Title,
            icon = "Interface\\Addons\\OldGrommsToolkit\\images\\GRTK_Images_Icon.blp",
            notCheckable = true,
            func = function(button, menuInputData, menu)
                local MouseButtonType = menuInputData.buttonName
				if MouseButtonType == "LeftButton" then
                    GRTK_SpecChange_Keybind()
                elseif MouseButtonType == "MiddleButton" then
			        GRTK_Other_OpenSettingsMenu()
				elseif MouseButtonType == "RightButton" then
				    GRTK_Mounts_ToggleMenu_MountList()
                else
                end
            end,
            funcOnEnter = function(button)
                MenuUtil.ShowTooltip(button, function(tooltip)
                    tooltip:SetText(GRTK_Text_Compartment_Description_PartOne.."\n\n"..GRTK_Text_Compartment_Description_PartTwo.."\n\n"..GRTK_Text_Compartment_Description_PartThree)
                end)
            end,
            funcOnLeave = function(button)
                MenuUtil.HideTooltip(button)
            end,
        })
   	end
end