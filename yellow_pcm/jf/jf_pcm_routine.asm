PlayPCM:
	ld a,e
	ld e,a
	ld d, 0
	ld hl,PCMPointers
	add hl,de
	add hl,de
	add hl,de		; multiply by 3 to get the correct pointer address
	ld b,[hl]		; b = bank of PCM data
	inc hl
	ld a,[hli]
	ld h,[hl]
	ld l,a			; hl = pointer to PCM data
	di			; make sure the CPU does NOT do anything else
				; while playing the audio.
	xor a			; make sure audio is completely silent while playing PCM.
	ld [rNR12], a		; mute ch1
	ld [rNR22], a		; mute ch2
	ld [rNR42], a		; mute ch3
	call PlayPCMSample
	ei			; our work is done here
	ret 

PCMPointers:
	pointer HmmHmm_PCM
	pointer Ou_PCM