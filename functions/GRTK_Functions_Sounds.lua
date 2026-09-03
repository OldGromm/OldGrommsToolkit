function GRTK_DefaultVictorySoundToggle(input_state)
    if input_state == true then
	    MuteSoundFile(1125303)
	elseif input_state == false then
	    UnmuteSoundFile(1125303)
	else
	end
end




function GRTK_PreviewSoundPlayer(input_soundID)
    local GRTKTemp_SoundID = input_soundID
	
	if GRTK_SoundHandle_PlayedSomeMusicBefore == false then
    else
        StopSound(GRTK_SoundHandle, 0.0)	
	end

	GRTK_General_PlaySoundFile(GRTKTemp_SoundID, true)
	GRTK_SoundHandle_PlayedSomeMusicBefore = true
end




function GRTK_PlayVictorySound()
	local GRTKTemp_SoundIndex = GRTK_UV("Load", 4, "Sounds_Victory")
	if GRTKTemp_SoundIndex == 21 then
	
	else
	    if GRTKTemp_SoundIndex == 20 then
	        GRTKTemp_SoundIndex = fastrandom(1, 19)
	    end
		local GRTKTemp_SoundID = GRTK_Sounds_Victory_Entries[GRTKTemp_SoundIndex]
		GRTK_General_PlaySoundFile(GRTKTemp_SoundID, false)
	end
end




function GRTK_Sounds_UpdateTalkingHeadRecords(input_soundID)
    if GRTKDB_TalkingHead[input_soundID] == nil then
        GRTKDB_TalkingHead[input_soundID] = 1
	else
	    GRTKDB_TalkingHead[input_soundID] = GRTKDB_TalkingHead[input_soundID] + 1
    end
end




function GRTK_Sounds_CheckTalkingHeadSoundID(input_soundID, input_difficultyID, input_instancetype)
    local GRTKTemp_Proceed = false

	if GRTK_UV("Load", 4, "Sounds_TalkingHeadDungeons") == true then
	    if input_instancetype == "party" then
		    GRTKTemp_Proceed = true
		end
	end

	if GRTK_UV("Load", 4, "Sounds_TalkingHeadMythicPlus") == true then
	    if input_difficultyID == 8 then
		    GRTKTemp_Proceed = true
		end
	end

	if GRTK_UV("Load", 4, "Sounds_TalkingHeadMRaids") == true then
	    if input_instancetype == "raid" then
		    GRTKTemp_Proceed = true
		end
	end

	if GRTK_UV("Load", 4, "Sounds_TalkingHeadPvP") == true then
	    if input_instancetype == "arena" or input_instancetype == "pvp" then
		    GRTKTemp_Proceed = true
		end
	end

	if GRTKDB_TalkingHead[input_soundID] > GRTK_UV("Load", 4, "Sounds_TalkingHead") then
	    GRTKTemp_Proceed = true
	end
	return GRTKTemp_Proceed
end