function GRTK_CreateFrame_Mounts()
    -- Mount list menu (frame)
    GRTK_Mounts_Frame_MountMenu = CreateFrame("Frame", "GRTK_MountMenu_Frame_Main", UIParent, "BasicFrameTemplate")
    GRTK_Mounts_Frame_MountMenu:SetAllPoints()
    GRTK_Mounts_Frame_MountMenu:SetSize(550, 220)
    GRTK_Mounts_Frame_MountMenu:SetIgnoreParentScale(true)
    GRTK_Mounts_Frame_MountMenu:EnableMouse(true)
	GRTK_Mounts_Frame_MountMenu:SetMovable(true)
	GRTK_Mounts_Frame_MountMenu:RegisterForDrag("LeftButton")
	GRTK_Mounts_Frame_MountMenu:SetScript("OnDragStart", function(self, button)
	    self:StartMoving()
    end)
    GRTK_Mounts_Frame_MountMenu:SetScript("OnDragStop", function(self)
	    self:StopMovingOrSizing()
		local GRTKTemp_LayoutName = GRTK_LibEditMode:GetActiveLayoutName()
		local GRTKTemp_Point, _, _, GRTKTemp_OffsetX, GRTKTemp_OffsetY = GRTK_Mounts_Frame_MountMenu:GetPoint()
		GRTKDB_EditMode["Mounts"][GRTKTemp_LayoutName].point = GRTKTemp_Point
        GRTKDB_EditMode["Mounts"][GRTKTemp_LayoutName].x = GRTKTemp_OffsetX
        GRTKDB_EditMode["Mounts"][GRTKTemp_LayoutName].y = GRTKTemp_OffsetY
    end)
    GRTK_Mounts_Frame_MountMenu:Hide()
    tinsert(UISpecialFrames, GRTK_Mounts_Frame_MountMenu:GetName())

    -- Add Mount
    GRTK_Mounts_Frame_MountMenu_Add = CreateFrame("Button", nil, GRTK_MountMenu_Frame_Main, "GRTKMountsButtonTemplate")
    GRTK_Mounts_Frame_MountMenu_Add:SetPoint("TOPLEFT", GRTK_MountMenu_Frame_Main, "TOPLEFT", 5, -30)
    GRTK_Mounts_Frame_MountMenu_Add:SetSize(120, 30)
    GRTK_Mounts_Frame_MountMenu_Add:SetText(GRTK_Text_Mounts_AddMount)


    -- Remove Mount
    GRTK_Mounts_Frame_MountMenu_Remove = CreateFrame("Button", nil, GRTK_MountMenu_Frame_Main, "GRTKMountsButtonTemplate")
    GRTK_Mounts_Frame_MountMenu_Remove:SetPoint("TOPLEFT", GRTK_MountMenu_Frame_Main, "TOPLEFT", 130, -30)
    GRTK_Mounts_Frame_MountMenu_Remove:SetSize(120, 30)
    GRTK_Mounts_Frame_MountMenu_Remove:SetText(GRTK_Text_Mounts_RemoveMount)


    -- Reset Lists
    GRTK_Mounts_Frame_MountMenu_Reset = CreateFrame("Button", nil, GRTK_MountMenu_Frame_Main, "GRTKMountsButtonTemplate")
    GRTK_Mounts_Frame_MountMenu_Reset:SetPoint("TOPLEFT", GRTK_MountMenu_Frame_Main, "TOPLEFT", 255, -30)
    GRTK_Mounts_Frame_MountMenu_Reset:SetSize(120, 30)
    GRTK_Mounts_Frame_MountMenu_Reset:SetText(GRTK_Text_Mounts_ResetList)


    -- Info Button
    GRTK_Mounts_Frame_MountMenu_Info = CreateFrame("Button", nil, GRTK_MountMenu_Frame_Main, "UIPanelButtonTemplate")
    GRTK_Mounts_Frame_MountMenu_Info:SetPoint("TOPRIGHT", GRTK_MountMenu_Frame_Main, "TOPRIGHT", -20, 0)
    GRTK_Mounts_Frame_MountMenu_Info:SetSize(24, 24)
    GRTK_Mounts_Frame_MountMenu_Info:SetText(CreateSimpleTextureMarkup(374216, 20, 20, 0, 0))


    -- Mount List Icons
    GRTK_Mounts_Frame_MountMenu_String_Ground = GRTK_Mounts_Frame_MountMenu:CreateFontString(nil, "OVERLAY", "GameTooltipText")
    GRTK_Mounts_Frame_MountMenu_String_Ground:SetPoint("TOPLEFT", GRTK_MountMenu_Frame_Main, "TOPLEFT", 5, -71)
    GRTK_Mounts_Frame_MountMenu_String_Ground:SetText(" ")
    GRTK_Mounts_Frame_MountMenu_String_Flying = GRTK_Mounts_Frame_MountMenu:CreateFontString(nil, "OVERLAY", "GameTooltipText")
    GRTK_Mounts_Frame_MountMenu_String_Flying:SetPoint("TOPLEFT", GRTK_MountMenu_Frame_Main, "TOPLEFT", 5, -107)
    GRTK_Mounts_Frame_MountMenu_String_Flying:SetText(" ")
    GRTK_Mounts_Frame_MountMenu_String_Aquatic = GRTK_Mounts_Frame_MountMenu:CreateFontString(nil, "OVERLAY", "GameTooltipText")
    GRTK_Mounts_Frame_MountMenu_String_Aquatic:SetPoint("TOPLEFT", GRTK_MountMenu_Frame_Main, "TOPLEFT", 5, -143)
    GRTK_Mounts_Frame_MountMenu_String_Aquatic:SetText(" ")
    GRTK_Mounts_Frame_MountMenu_String_Other = GRTK_Mounts_Frame_MountMenu:CreateFontString(nil, "OVERLAY", "GameTooltipText")
    GRTK_Mounts_Frame_MountMenu_String_Other:SetPoint("TOPLEFT", GRTK_MountMenu_Frame_Main, "TOPLEFT", 5, -179)
    GRTK_Mounts_Frame_MountMenu_String_Other:SetText(" ")


    --Create dropdown menu for vendor mount
	if GRTK_Mounts_SpecialMountList_PlayerHasNone == true then
        GRTK_Mounts_DropdownMenu_VendorMount = CreateFrame("DropdownButton", nil, GRTK_MountMenu_Frame_Main, "GRTKMountsDropdownShortTemplate")
        GRTK_Mounts_DropdownMenu_VendorMount:SetDefaultText(GRTK_Text_Mounts_SpecialMount)
        GRTK_Mounts_DropdownMenu_VendorMount:SetPoint("TOPLEFT", GRTK_MountMenu_Frame_Main, "TOPLEFT", 383, -32)
        GRTK_Mounts_DropdownMenu_VendorMount:SetDefaultText(" ")
        GRTK_Mounts_DropdownMenu_VendorMount:SetupMenu(function(dropdown, rootDescription)
    	    for i, v in ipairs(GRTK_Mounts_SpecialMountList_Names) do
    	        local GRTKTemp_MountID = GRTK_Mounts_SpecialMountList_Final[i]
    	        local GRTKTemp_MountName = v
                rootDescription:CreateButton(GRTKTemp_MountName, function()
    			    GRTK_Mounts_ButtonFunction_UpdateList("add", GRTKTemp_MountID, true)
    		    end)
    	    end
        end)
	end


    -- Mount list menu (buttons)
    GRTK_Mounts_Frame_MountMenu_Add:SetScript("OnClick", function(self, button)
        GRTK_Mounts_ButtonReaction("add")
    end)

    GRTK_Mounts_Frame_MountMenu_Remove:SetScript("OnClick", function(self, button)
        GRTK_Mounts_ButtonReaction("remove")
    end)

    GRTK_Mounts_Frame_MountMenu_Reset:SetScript("OnClick", function(self, button)
        GRTK_Mounts_ButtonReaction("reset")
    end)
    GRTK_Mounts_Frame_MountMenu_Info:SetScript("OnClick", function(self, button)
		GRTK_General_SendChatMessage(GRTK_Text_Mounts_InfoButton_Title..":")
		GRTK_General_SendChatMessage("1."..GRTK_Text_Mounts_AddMount..":")
		GRTK_General_SendChatMessage("   "..GRTK_Text_Mounts_InfoButton_AddMount_PartOne)
		GRTK_General_SendChatMessage("   "..GRTK_Text_Mounts_InfoButton_AddMount_PartTwo)
		GRTK_General_SendChatMessage("2."..GRTK_Text_Mounts_RemoveMount..":")
		GRTK_General_SendChatMessage("   "..GRTK_Text_Mounts_InfoButton_RemoveMount_PartOne)
		GRTK_General_SendChatMessage("   "..GRTK_Text_Mounts_InfoButton_RemoveMount_PartTwo)
		GRTK_General_SendChatMessage("3."..GRTK_Text_Mounts_ResetList..":")
		GRTK_General_SendChatMessage("   "..GRTK_Text_Mounts_InfoButton_ResetList_PartOne)
		GRTK_General_SendChatMessage("   "..GRTK_Text_Mounts_InfoButton_ResetList_PartTwo)
		GRTK_General_SendChatMessage("   "..GRTK_Text_Mounts_InfoButton_ResetList_PartThree)
		GRTK_General_SendChatMessage("   "..GRTK_Text_Mounts_InfoButton_ResetList_PartFour)
    end)

end