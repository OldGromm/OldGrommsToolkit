function GRTK_Mounts_CheckMountFactionUnlockStatus(input_mountID)
    local GRTKTemp_MountID = input_mountID
	local GRTKTemp_Unlocked = select(11, C_MountJournal.GetMountInfoByID(input_mountID))
	local GRTKTemp_FactionSpecific = select(8, C_MountJournal.GetMountInfoByID(GRTKTemp_MountID))
	local GRTKTemp_Faction = select(9, C_MountJournal.GetMountInfoByID(GRTKTemp_MountID))
	local GRTKTemp_Status = false
	
    if GRTKTemp_Unlocked == true then
        if GRTKTemp_FactionSpecific == true then
            if GRTKTemp_Faction == GRTK_PlayerStats_CurrentFactionNumber then
		        GRTKTemp_Status = true
            end
		else
		    GRTKTemp_Status = true
        end
    end
	
	return GRTKTemp_Status
end








function GRTK_Mounts_RefreshIconList()
    for i=1, 4 do
	    local GRTKTemp_MountType = GRTK_Mounts_MountType[i]
	    local GRTKTemp_FrameName = ("GRTK_Mounts_Frame_MountMenu_String_"..GRTKTemp_MountType)
	    local GRTKTemp_FrameNameFinal = _G[GRTKTemp_FrameName]
		
		local GRTKTemp_Table = GRTK_UV("Load", 5, "Mounts_"..GRTKTemp_MountType.."_List")
		local GRTKTemp_IconStringFinal = ""

        if GRTKTemp_Table == nil then
		
		else
		    if GRTKTemp_MountType == "Other" then
			    local GRTKTemp_IconString = GRTK_Macros_FetchMountIcon(GRTKTemp_Table)
    		    GRTKTemp_IconStringFinal = (GRTKTemp_IconStringFinal.." "..GRTKTemp_IconString)
			else
    		    for i, v in ipairs(GRTKTemp_Table) do
    		        if i > 16 then
    			    else
    				    if not v == nil or 0 then
                            local GRTKTemp_IconString = GRTK_Macros_FetchMountIcon(v)
    		                GRTKTemp_IconStringFinal = (GRTKTemp_IconStringFinal.." "..GRTKTemp_IconString)
    		            end
    			    end
				end
	        end
            GRTKTemp_FrameNameFinal:SetText(GRTKTemp_IconStringFinal)
		end
	end
end