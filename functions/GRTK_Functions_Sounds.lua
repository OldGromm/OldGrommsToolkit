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
	
	if GRTK_SoundHandle_FirstTime == false then
	    GRTK_SoundHandle_FirstTime = true
    else
        StopSound(GRTK_SoundHandle, 0.0)	
	end

	GRTK_General_PlaySoundFile(GRTKTemp_SoundID, true)
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