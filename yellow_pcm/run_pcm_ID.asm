; This was directly ported from Pokemon Yellow
; e is the PCM ID
PCMFREQ		EQU	$7FF

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
	ld l,a		; hl = pointer to PCM data

	ld c, 4
.wait
	dec c
	jr z,.begin
	call DelayFrame
	jr .wait

; begin the actual routine
.begin
	di 		; we're gonna screw around with
			; the audio, so don't mess things up
	push bc
	push hl

; save wave channel (push wave)
	ld a,$80	; set bit 7 (all sound on)
	ld [rNR52],a	; NR52, sound control
	ld a,$77	; 
	ld [rNR50],a	; NR50, channel volume control
	xor a		;
	ld [rNR30],a	; turn off wave channel

	ld hl,$FF30		; wave ram
	ld de,wWaveBackup	; wave instrument backup	
.fillwaveram
	ld a,[hl]
	ld [de],a
	inc de
	ld a,$FF		; fill up wave ram
	ldi [hl],a
	ld a,l
	cp a,$40		; are we at the end?
	jr nz,.fillwaveram
	
	ld a,$80	;
	ld [rNR30],a	; turn on wave channel
	ld a,[rNR51]	
	or a,$44	; enable all channels?
	ld [rNR51],a	; NR51, sound output
	
; prepare wave channel
	ld a,$FF		; wave channel length?
	ld [rNR31],a
	ld a,$20		; set output to 50%
	ld [rNR32],a

	ld a,(PCMFREQ % $100)
	ld [rNR33],a	; wave channel low frequency
	ld a,$80 + (PCMFREQ / $100)
	ld [rNR34],a	; wave channel high frequency

; we're done setting up wave channels
; play that sonofabitch!
	pop hl
	pop bc
	call PlayPCMSample		; play the pcm!

;	xor a
;	ld [$C0F3],a	; ???
;	ld [$C0F4],a	; ???

; reset wave channel (pop wave)
	ld a,$80		; set bit 7 (all sound on)
	ld [rNR52],a	; NR52, sound control
	xor a	
	ld [rNR30],a	; turn off wave channel

	ld hl,$FF30		; wave ram
	ld de,wWaveBackup	; wave instrument backup
.copybackup
	ld a,[de]		; copy saved wave instrument back to wave ram
	inc de
	ldi [hl],a
	ld a,l
	cp a,$40
	jr nz,.copybackup

	ld a,$80
	ld [rNR30],a	; turn on wave channel
	ld a,[rNR51]
	and a,$BB
	ld [rNR51],a	; turn off wave output?

; reset sfx and music
	xor a
	ld [wc02a],a
	ld [wc02b],a
	ld [wc02c],a
	ld [wc02d],a
	
	ld a,[H_LOADEDROMBANK]
	ei
	ret 

PCMPointers:
	pointer Ou_PCM
	pointer HmmHmm_PCM