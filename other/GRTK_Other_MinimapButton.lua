-- Minimap button setup
function GRTK_Other_CreateMinimapButton()
    local GRTK_LDB = LibStub("LibDataBroker-1.1"):NewDataObject("GRTK_Minimap", {  
    	type = "data source",
    	icon = "Interface\\Addons\\OldGrommsToolkit\\images\\GRTK_Images_Icon.blp",
    	OnClick = function(clickedframe, button)
            if button == "LeftButton" then
                GRTK_SpecChange_Keybind()
            elseif button == "MiddleButton" then
			    GRTK_Other_OpenSettingsMenu()
			elseif button == "RightButton" then
			    GRTK_Mounts_ToggleMenu_MountList()
            else
            end
        end,
        OnTooltipShow = function(tip)
        tip:AddLine(GRTK_Text_Options_Category_Title, 1, 1, 1)
        if GRTK_WoWVersion == "Retail" then
		    tip:AddLine(GRTK_Text_Compartment_Description_PartOne.."\n\n"..GRTK_Text_Compartment_Description_PartTwo.."\n\n"..GRTK_Text_Compartment_Description_PartThree)
		elseif GRTK_WoWVersion == "MoP" then
		    tip:AddLine(GRTK_Text_Compartment_Description_Vanilla_PartOne.."\n\n"..GRTK_Text_Compartment_Description_PartTwo.."\n\n"..GRTK_Text_Compartment_Description_PartThree)
		else
		    tip:AddLine(GRTK_Text_Compartment_Description_Vanilla_PartOne.."\n\n"..GRTK_Text_Compartment_Description_PartThree)
		end
		tip:Show()
        end 
    })

    GRTK_LibDBIcon:Register("GRTK_Minimap", GRTK_LDB, GRTKDB_MinimapButton)
end