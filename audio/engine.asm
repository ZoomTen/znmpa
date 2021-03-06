; The first of three duplicated sound engines.

Music31_UpdateMusic::
	ld c, CH0
.loop
	ld b, $0
	ld hl, wc026
	add hl, bc
	ld a, [hl]
	and a
	jr z, .nextChannel
	ld a, c
	cp CH4
	jr nc, .applyEffects
	ld a, [wc002]
	and a
	jr z, .applyEffects
	bit 7, a
	jr nz, .nextChannel
	set 7, a
	ld [wc002], a
	xor a
	ld [$ff25], a
	ld [$ff1a], a
	ld a, $80
	ld [$ff1a], a
	jr .nextChannel
.applyEffects
	call Music31_ApplyMusicAffects
.nextChannel
	ld a, c
	inc c ; inc channel number
	cp CH7
	jr nz, .loop
	ret

; this routine checks flags for music effects currently applied
; to the channel and calls certain functions based on flags.
; known flags for wc02e:
;	0: toggleperfectpitch has been used
;	1: call has been used
;	3: a toggle used only by this routine for vibrato
;	4: pitchbend flag
;	6: dutycycle flag
Music31_ApplyMusicAffects: ; 0x9138
	ld b, $0
	ld hl, wc0b6 ; delay until next note
	add hl, bc
	ld a, [hl]
	cp $1 ; if the delay is 1, play next note
	jp z, Music31_PlayNextNote
	dec a ; otherwise, decrease the delay timer
	ld [hl], a
	ld a, c
	cp CH4
	jr nc, .startChecks ; if a sfx channel
	ld hl, wc02a
	add hl, bc
	ld a, [hl]
	and a
	jr z, .startChecks
	ret
.startChecks
	ld hl, wc02e
	add hl, bc
	bit 6, [hl] ; dutycycle
	jr z, .checkForExecuteMusic
	call Music31_ApplyDutyCycle
.checkForExecuteMusic
	ld b, $0
	ld hl, wc036
	add hl, bc
	bit 0, [hl]
	jr nz, .checkForPitchBend
	ld hl, wc02e
	add hl, bc
	bit 2, [hl]
	jr nz, .disablePitchBendVibrato
.checkForPitchBend
	ld hl, wc02e
	add hl, bc
	bit 4, [hl] ; pitchbend
	jr z, .checkVibratoDelay
	jp Music31_ApplyPitchBend
.checkVibratoDelay
	ld hl, wc04e ; vibrato delay
	add hl, bc
	ld a, [hl]
	and a ; check if delay is over
	jr z, .checkForVibrato
	dec [hl] ; otherwise, dec delay
.disablePitchBendVibrato
	ret
.checkForVibrato
	ld hl, wc056 ; vibrato rate
	add hl, bc
	ld a, [hl]
	and a
	jr nz, .vibrato
	ret ; no vibrato
.vibrato
	ld d, a
	ld hl, wc05e
	add hl, bc
	ld a, [hl]
	and $f
	and a
	jr z, .vibratoAlreadyDone
	dec [hl] ; apply vibrato pitch change
	ret
.vibratoAlreadyDone
	ld a, [hl]
	swap [hl]
	or [hl]
	ld [hl], a ; reset the vibrato value and start again
	ld hl, wc066
	add hl, bc
	ld e, [hl] ; get note pitch
	ld hl, wc02e
	add hl, bc
	bit 3, [hl] ; this is the only code that sets/resets bit three so
	jr z, .unset ; it continuously alternates which path it takes
	res 3, [hl]
	ld a, d
	and $f
	ld d, a
	ld a, e
	sub d
	jr nc, .noCarry
	ld a, $0
.noCarry
	jr .done
.unset
	set 3, [hl]
	ld a, d
	and $f0
	swap a
	add e
	jr nc, .done
	ld a, $ff
.done
	ld d, a
	ld b, $3
	call Func2_9838
	ld [hl], d
	ret

; this routine executes all music commands that take up no time,
; like tempo changes, duty changes etc. and doesn't return
; until the first note is reached
Music31_PlayNextNote ; 0x91d0
	ld hl, wc06e
	add hl, bc
	ld a, [hl]
	ld hl, wc04e
	add hl, bc
	ld [hl], a
	ld hl, wc02e
	add hl, bc
	res 4, [hl]
	res 5, [hl]
	call Music31_endchannel
	ret

Music31_endchannel: ; 0x91e6
	call Music31_GetNextMusicByte
	ld d, a
	cp $ff ; is this command an endchannel?
	jp nz, Music31_callchannel ; no
	ld b, $0 ; yes
	ld hl, wc02e
	add hl, bc
	bit 1, [hl]
	jr nz, .returnFromCall
	ld a, c
	cp CH3
	jr nc, .noiseOrSfxChannel
	jr .asm2_923f
.noiseOrSfxChannel
	res 2, [hl]
	ld hl, wc036
	add hl, bc
	res 0, [hl]
	cp CH6
	jr nz, .notSfxChannel3
	ld a, $0
	ld [$ff1a], a
	ld a, $80
	ld [$ff1a], a
.notSfxChannel3
	jr nz, .asm2_9222
	ld a, [wc003]
	and a
	jr z, .asm2_9222
	xor a
	ld [wc003], a
	jr .asm2_923f
.asm2_9222
	jr .asm2_9248
.returnFromCall
	res 1, [hl]
	ld d, $0
	ld a, c
	add a
	ld e, a
	ld hl, wc006
	add hl, de
	push hl ; store current channel address
	ld hl, wc016
	add hl, de
	ld e, l
	ld d, h
	pop hl
	ld a, [de]
	ld [hli], a
	inc de
	ld a, [de]
	ld [hl], a ; loads channel address to return to
	jp Music31_endchannel
.asm2_923f
	ld hl, Unknown2_9b1f
	add hl, bc
	ld a, [$ff25]
	and [hl]
	ld [$ff25], a
.asm2_9248
	ld a, [wc02a]
	cp $14
	jr nc, .asm2_9251
	jr .asm2_926e
.asm2_9251
	ld a, [wc02a]
	cp $86
	jr z, .asm2_926e
	jr c, .asm2_925c
	jr .asm2_926e
.asm2_925c
	ld a, c
	cp CH4
	jr z, .asm2_9265
	call Func2_96c7
	ret c
.asm2_9265
	ld a, [wc005]
	ld [$ff24], a
	xor a
	ld [wc005], a
.asm2_926e
	ld hl, wc026
	add hl, bc
	ld [hl], b
	ret

Music31_callchannel: ; 0x9274
	cp $fd ; is this command a callchannel?
	jp nz, Music31_loopchannel ; no
	call Music31_GetNextMusicByte ; yes
	push af
	call Music31_GetNextMusicByte
	ld d, a
	pop af
	ld e, a
	push de ; store pointer
	ld d, $0
	ld a, c
	add a
	ld e, a
	ld hl, wc006
	add hl, de
	push hl
	ld hl, wc016
	add hl, de
	ld e, l
	ld d, h
	pop hl
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hld]
	ld [de], a ; copy current channel address
	pop de
	ld [hl], e
	inc hl
	ld [hl], d ; overwrite current address with pointer
	ld b, $0
	ld hl, wc02e
	add hl, bc
	set 1, [hl] ; set the call flag
	jp Music31_endchannel

Music31_loopchannel: ; 0x92a9
	cp $fe ; is this command a loopchannel?
	jp nz, Music31_notetype ; no
	call Music31_GetNextMusicByte ; yes
	ld e, a
	and a
	jr z, .infiniteLoop
	ld b, $0
	ld hl, wc0be
	add hl, bc
	ld a, [hl]
	cp e
	jr nz, .loopAgain
	ld a, $1 ; if no more loops to make,
	ld [hl], a
	call Music31_GetNextMusicByte ; skip pointer
	call Music31_GetNextMusicByte
	jp Music31_endchannel
.loopAgain ; inc loop count
	inc a
	ld [hl], a
	; fall through
.infiniteLoop ; overwrite current address with pointer
	call Music31_GetNextMusicByte
	push af
	call Music31_GetNextMusicByte
	ld b, a
	ld d, $0
	ld a, c
	add a
	ld e, a
	ld hl, wc006
	add hl, de
	pop af
	ld [hli], a
	ld [hl], b
	jp Music31_endchannel

Music31_notetype: ; 0x92e4
	and $f0
	cp $d0 ; is this command a notetype?
	jp nz, Music31_toggleperfectpitch ; no
	ld a, d ; yes
	and $f
	ld b, $0
	ld hl, wc0c6
	add hl, bc
	ld [hl], a ; store low nibble as speed
	ld a, c
	cp CH3
	jr z, .noiseChannel ; noise channel has 0 params
	call Music31_GetNextMusicByte
	ld d, a
	ld a, c
	cp CH2
	jr z, .musicChannel3
	cp CH6
	jr nz, .notChannel3
	ld hl, wc0e7
	jr .sfxChannel3
.musicChannel3
	ld hl, wc0e6
.sfxChannel3
	ld a, d
	and $f
	ld [hl], a ; store low nibble of param as duty
	ld a, d
	and $30
	sla a
	ld d, a
	; fall through

	; if channel 3, store high nibble as volume
	; else, store volume (high nibble) and fade (low nibble)
.notChannel3
	ld b, $0
	ld hl, wc0de
	add hl, bc
	ld [hl], d
.noiseChannel
	jp Music31_endchannel

Music31_toggleperfectpitch: ; 0x9323
	ld a, d
	cp $e8 ; is this command a toggleperfectpitch?
	jr nz, Music31_vibrato ; no
	ld b, $0 ; yes
	ld hl, wc02e
	add hl, bc
	ld a, [hl]
	xor $1
	ld [hl], a ; flip bit 0 of wc02e
	jp Music31_endchannel

Music31_vibrato: ; 0x9335
	cp $ea ; is this command a vibrato?
	jr nz, Music31_pitchbend ; no
	call Music31_GetNextMusicByte ; yes
	ld b, $0
	ld hl, wc04e
	add hl, bc
	ld [hl], a ; store delay
	ld hl, wc06e
	add hl, bc
	ld [hl], a ; store delay
	call Music31_GetNextMusicByte
	ld d, a
	and $f0
	swap a
	ld b, $0
	ld hl, wc056
	add hl, bc
	srl a
	ld e, a
	adc b
	swap a
	or e
	ld [hl], a ; store rate as both high and low nibbles
	ld a, d
	and $f
	ld d, a
	ld hl, wc05e
	add hl, bc
	swap a
	or d
	ld [hl], a ; store depth as both high and low nibbles
	jp Music31_endchannel

Music31_pitchbend: ; 0x936d
	cp $eb ; is this command a pitchbend?
	jr nz, Music31_duty ; no
	call Music31_GetNextMusicByte ; yes
	ld b, $0
	ld hl, wc076
	add hl, bc
	ld [hl], a ; store first param
	call Music31_GetNextMusicByte
	ld d, a
	and $f0
	swap a
	ld b, a
	ld a, d
	and $f
	call Func2_9858
	ld b, $0
	ld hl, wc0a6
	add hl, bc
	ld [hl], d ; store unknown part of second param
	ld hl, wc0ae
	add hl, bc
	ld [hl], e ; store unknown part of second param
	ld b, $0
	ld hl, wc02e
	add hl, bc
	set 4, [hl] ; set pitchbend flag
	call Music31_GetNextMusicByte
	ld d, a
	jp Music31_notelength

Music31_duty: ; 0x93a5
	cp $ec ; is this command a duty?
	jr nz, Music31_tempo ; no
	call Music31_GetNextMusicByte ; yes
	rrca
	rrca
	and $c0
	ld b, $0
	ld hl, wc03e
	add hl, bc
	ld [hl], a ; store duty
	jp Music31_endchannel

Music31_tempo: ; 0x93ba
	cp $ed ; is this command a tempo?
	jr nz, Music31_stereopanning ; no
	ld a, c ; yes
	cp CH4
	jr nc, .sfxChannel
	call Music31_GetNextMusicByte
	ld [wc0e8], a ; store first param
	call Music31_GetNextMusicByte
	ld [wc0e9], a ; store second param
	xor a
	ld [wc0ce], a ; clear RAM
	ld [wc0cf], a
	ld [wc0d0], a
	ld [wc0d1], a
	jr .musicChannelDone
.sfxChannel
	call Music31_GetNextMusicByte
	ld [wc0ea], a ; store first param
	call Music31_GetNextMusicByte
	ld [wc0eb], a ; store second param
	xor a
	ld [wc0d2], a ; clear RAM
	ld [wc0d3], a
	ld [wc0d4], a
	ld [wc0d5], a
.musicChannelDone
	jp Music31_endchannel

Music31_stereopanning: ; 0x93fa
	cp $ee ; is this command a stereopanning?
	jr nz, Music31_unknownmusic0xef ; no
	call Music31_GetNextMusicByte ; yes
	ld [wc004], a ; store panning
	jp Music31_endchannel

; this appears to never be used
Music31_unknownmusic0xef ; 0x9407
	cp $ef ; is this command an unknownmusic0xef?
	jr nz, Music31_dutycycle ; no
	call Music31_GetNextMusicByte ; yes
	push bc
	call Func2_9876
	pop bc
	ld a, [wc003]
	and a
	jr nz, .skip
	ld a, [wc02d]
	ld [wc003], a
	xor a
	ld [wc02d], a
.skip
	jp Music31_endchannel

Music31_dutycycle: ; 0x9426
	cp $fc ; is this command a dutycycle?
	jr nz, Music31_volume ; no
	call Music31_GetNextMusicByte ; yes
	ld b, $0
	ld hl, wc046
	add hl, bc
	ld [hl], a ; store full cycle
	and $c0
	ld hl, wc03e
	add hl, bc
	ld [hl], a ; store first duty
	ld hl, wc02e
	add hl, bc
	set 6, [hl] ; set dutycycle flag
	jp Music31_endchannel

Music31_volume: ; 0x9444
	cp $f0 ; is this command a volume?
	jr nz, Music31_executemusic ; no
	call Music31_GetNextMusicByte ; yes
	ld [$ff24], a ; store volume
	jp Music31_endchannel

Music31_executemusic: ; 0x9450
	cp $f8 ; is this command an executemusic?
	jr nz, Music31_octave ; no
	ld b, $0 ; yes
	ld hl, wc036
	add hl, bc
	set 0, [hl]
	jp Music31_endchannel

Music31_octave: ; 0x945f
	and $f0
	cp $e0 ; is this command an octave?
	jr nz, Music31_unknownsfx0x20 ; no
	ld hl, wc0d6 ; yes
	ld b, $0
	add hl, bc
	ld a, d
	and $f
	ld [hl], a ; store low nibble as octave
	jp Music31_endchannel

Music31_unknownsfx0x20: ; 0x9472
	cp $20 ; is this command an unknownsfx0x20?
	jr nz, Music31_unknownsfx0x10 ; no
	ld a, c
	cp CH3 ; is this a noise or sfx channel?
	jr c, Music31_unknownsfx0x10 ; no
	ld b, $0
	ld hl, wc036
	add hl, bc
	bit 0, [hl]
	jr nz, Music31_unknownsfx0x10 ; no
	call Music31_notelength ; yes
	ld d, a
	ld b, $0
	ld hl, wc03e
	add hl, bc
	ld a, [hl]
	or d
	ld d, a
	ld b, $1
	call Func2_9838
	ld [hl], d
	call Music31_GetNextMusicByte
	ld d, a
	ld b, $2
	call Func2_9838
	ld [hl], d
	call Music31_GetNextMusicByte
	ld e, a
	ld a, c
	cp CH7
	ld a, $0
	jr z, .sfxNoiseChannel ; only two params for noise channel
	push de
	call Music31_GetNextMusicByte
	pop de
.sfxNoiseChannel
	ld d, a
	push de
	call Func2_9629
	call Func2_95f8
	pop de
	call Func2_964b
	ret

Music31_unknownsfx0x10:
	ld a, c
	cp CH4
	jr c, Music31_note ; if not a sfx
	ld a, d
	cp $10 ; is this command a unknownsfx0x10?
	jr nz, Music31_note ; no
	ld b, $0
	ld hl, wc036
	add hl, bc
	bit 0, [hl]
	jr nz, Music31_note ; no
	call Music31_GetNextMusicByte ; yes
	ld [$ff10], a
	jp Music31_endchannel

Music31_note:
	ld a, c
	cp CH3
	jr nz, Music31_notelength ; if not noise channel
	ld a, d
	and $f0
	cp $b0 ; is this command a dnote?
	jr z, Music31_dnote ; yes
	jr nc, Music31_notelength ; no
	swap a
	ld b, a
	ld a, d
	and $f
	ld d, a
	ld a, b
	push de
	push bc
	jr asm2_94fd

Music31_dnote:
	ld a, d
	and $f
	push af
	push bc
	call Music31_GetNextMusicByte ; get dnote instrument
asm2_94fd
	ld d, a
	ld a, [wc003]
	and a
	jr nz, .asm2_9508
	ld a, d
	call Func2_9876
.asm2_9508
	pop bc
	pop de

Music31_notelength: ; 0x950a
	ld a, d
	push af
	and $f
	inc a
	ld b, $0
	ld e, a  ; store note length (in 16ths)
	ld d, b
	ld hl, wc0c6
	add hl, bc
	ld a, [hl]
	ld l, b
	call Func2_9847
	ld a, c
	cp CH4
	jr nc, .sfxChannel
	ld a, [wc0e8]
	ld d, a
	ld a, [wc0e9]
	ld e, a
	jr .skip
.sfxChannel
	ld d, $1
	ld e, $0
	cp CH7
	jr z, .skip ; if noise channel
	call Func2_9693
	ld a, [wc0ea]
	ld d, a
	ld a, [wc0eb]
	ld e, a
.skip
	ld a, l
	ld b, $0
	ld hl, wc0ce
	add hl, bc
	ld l, [hl]
	call Func2_9847
	ld e, l
	ld d, h
	ld hl, wc0ce
	add hl, bc
	ld [hl], e
	ld a, d
	ld hl, wc0b6
	add hl, bc
	ld [hl], a
	ld hl, wc036
	add hl, bc
	bit 0, [hl]
	jr nz, Music31_notepitch
	ld hl, wc02e
	add hl, bc
	bit 2, [hl]
	jr z, Music31_notepitch
	pop hl
	ret

Music31_notepitch: ; 0x9568
	pop af
	and $f0
	cp $c0 ; compare to rest
	jr nz, .notRest
	ld a, c
	cp CH4
	jr nc, .sfxChannel
	ld hl, wc02a
	add hl, bc
	ld a, [hl]
	and a
	jr nz, .done
	; fall through
.sfxChannel
	ld a, c
	cp CH2
	jr z, .musicChannel3
	cp CH6
	jr nz, .notSfxChannel3
.musicChannel3
	ld b, $0
	ld hl, Unknown2_9b1f
	add hl, bc
	ld a, [$ff25]
	and [hl]
	ld [$ff25], a
	jr .done
.notSfxChannel3
	ld b, $2
	call Func2_9838
	ld a, $8
	ld [hli], a
	inc hl
	ld a, $80
	ld [hl], a
.done
	ret
.notRest
	swap a
	ld b, $0
	ld hl, wc0d6
	add hl, bc
	ld b, [hl]
	call Func2_9858
	ld b, $0
	ld hl, wc02e
	add hl, bc
	bit 4, [hl]
	jr z, .asm2_95b8
	call Func2_978f
.asm2_95b8
	push de
	ld a, c
	cp CH4
	jr nc, .skip ; if sfx channel
	ld hl, wc02a
	ld d, $0
	ld e, a
	add hl, de
	ld a, [hl]
	and a
	jr nz, .asm2_95cb
	jr .skip
.asm2_95cb
	pop de
	ret
.skip
	ld b, $0
	ld hl, wc0de
	add hl, bc
	ld d, [hl]
	ld b, $2
	call Func2_9838
	ld [hl], d
	call Func2_9629
	call Func2_95f8
	pop de
	ld b, $0
	ld hl, wc02e
	add hl, bc
	bit 0, [hl]   ; has toggleperfectpitch been used?
	jr z, .skip2
	inc e         ; if yes, increment the pitch by 1
	jr nc, .skip2
	inc d
.skip2
	ld hl, wc066
	add hl, bc
	ld [hl], e
	call Func2_964b
	ret

Func2_95f8: ; 0x95f8
	ld b, $0
	ld hl, Unknown2_9b27
	add hl, bc
	ld a, [$ff25]
	or [hl]
	ld d, a
	ld a, c
	cp CH7
	jr z, .sfxNoiseChannel
	cp CH4
	jr nc, .skip ; if sfx channel
	ld hl, wc02a
	add hl, bc
	ld a, [hl]
	and a
	jr nz, .skip
.sfxNoiseChannel
	ld a, [wc004]
	ld hl, Unknown2_9b27
	add hl, bc
	and [hl]
	ld d, a
	ld a, [$ff25]
	ld hl, Unknown2_9b1f
	add hl, bc
	and [hl]
	or d
	ld d, a
.skip
	ld a, d
	ld [$ff25], a
	ret

Func2_9629: ; 0x9629
	ld b, $0
	ld hl, wc0b6
	add hl, bc
	ld d, [hl]
	ld a, c
	cp CH2
	jr z, .channel3 ; if music channel 3
	cp CH6
	jr z, .channel3 ; if sfx channel 3
	ld a, d
	and $3f
	ld d, a
	ld hl, wc03e
	add hl, bc
	ld a, [hl]
	or d
	ld d, a
.channel3
	ld b, $1
	call Func2_9838
	ld [hl], d
	ret

Func2_964b: ; 0x964b
	ld a, c
	cp CH2
	jr z, .channel3
	cp CH6
	jr nz, .notSfxChannel3
	; fall through
.channel3
	push de
	ld de, wc0e6
	cp CH2
	jr z, .musicChannel3
	ld de, wc0e7
.musicChannel3
	ld a, [de]
	add a
	ld d, $0
	ld e, a
	ld hl, Music31_WavePointers
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, $ff30
	ld b, $f
	ld a, $0
	ld [$ff1a], a
.loop
	ld a, [de]
	inc de
	ld [hli], a
	ld a, b
	dec b
	and a
	jr nz, .loop
	ld a, $80
	ld [$ff1a], a
	pop de
.notSfxChannel3
	ld a, d
	or $80
	and $c7
	ld d, a
	ld b, $3
	call Func2_9838
	ld [hl], e
	inc hl
	ld [hl], d
	call Func2_96b5
	ret

Func2_9693: ; 0x9693
	call Func2_96e5
	jr nc, .asm2_96ab
	ld d, $0
	ld a, [wc0f2]
	add $80
	jr nc, .asm2_96a2
	inc d
.asm2_96a2
	ld [wc0eb], a
	ld a, d
	ld [wc0ea], a
	jr .asm2_96b4
.asm2_96ab
	xor a
	ld [wc0eb], a
	ld a, $1
	ld [wc0ea], a
.asm2_96b4
	ret

Func2_96b5: ; 0x96b5
	call Func2_96e5
	jr nc, .asm2_96c6
	ld a, [wc0f1]
	add e
	jr nc, .asm2_96c1
	inc d
.asm2_96c1
	dec hl
	ld e, a
	ld [hl], e
	inc hl
	ld [hl], d
.asm2_96c6
	ret

Func2_96c7: ; 0x96c7
	call Func2_96e5
	jr nc, .asm2_96e2
	ld hl, wc006
	ld e, c
	ld d, $0
	sla e
	rl d
	add hl, de
	ld a, [hl]
	sub $1
	ld [hl], a
	inc hl
	ld a, [hl]
	sbc $0
	ld [hl], a
	scf
	ret
.asm2_96e2
	scf
	ccf
	ret

Func2_96e5: ; 0x96e5
	ld a, [wc02a]
	cp $14
	jr nc, .asm2_96ee
	jr .asm2_96f4
.asm2_96ee
	cp $86
	jr z, .asm2_96f4
	jr c, .asm2_96f7
.asm2_96f4
	scf
	ccf
	ret
.asm2_96f7
	scf
	ret

Music31_ApplyPitchBend: ; 0x96f9
	ld hl, wc02e
	add hl, bc
	bit 5, [hl]
	jp nz, .asm2_9740
	ld hl, wc09e
	add hl, bc
	ld e, [hl]
	ld hl, wc096
	add hl, bc
	ld d, [hl]
	ld hl, wc07e
	add hl, bc
	ld l, [hl]
	ld h, b
	add hl, de
	ld d, h
	ld e, l
	ld hl, wc08e
	add hl, bc
	push hl
	ld hl, wc086
	add hl, bc
	ld a, [hl]
	pop hl
	add [hl]
	ld [hl], a
	ld a, $0
	adc e
	ld e, a
	ld a, $0
	adc d
	ld d, a
	ld hl, wc0a6
	add hl, bc
	ld a, [hl]
	cp d
	jp c, .asm2_9786
	jr nz, .asm2_9773
	ld hl, wc0ae
	add hl, bc
	ld a, [hl]
	cp e
	jp c, .asm2_9786
	jr .asm2_9773
.asm2_9740
	ld hl, wc09e
	add hl, bc
	ld a, [hl]
	ld hl, wc096
	add hl, bc
	ld d, [hl]
	ld hl, wc07e
	add hl, bc
	ld e, [hl]
	sub e
	ld e, a
	ld a, d
	sbc b
	ld d, a
	ld hl, wc086
	add hl, bc
	ld a, [hl]
	add a
	ld [hl], a
	ld a, e
	sbc b
	ld e, a
	ld a, d
	sbc b
	ld d, a
	ld hl, wc0a6
	add hl, bc
	ld a, d
	cp [hl]
	jr c, .asm2_9786
	jr nz, .asm2_9773
	ld hl, wc0ae
	add hl, bc
	ld a, e
	cp [hl]
	jr c, .asm2_9786
.asm2_9773
	ld hl, wc09e
	add hl, bc
	ld [hl], e
	ld hl, wc096
	add hl, bc
	ld [hl], d
	ld b, $3
	call Func2_9838
	ld a, e
	ld [hli], a
	ld [hl], d
	ret
.asm2_9786
	ld hl, wc02e
	add hl, bc
	res 4, [hl]
	res 5, [hl]
	ret

Func2_978f: ; 0x978f
	ld hl, wc096
	add hl, bc
	ld [hl], d
	ld hl, wc09e
	add hl, bc
	ld [hl], e
	ld hl, wc0b6
	add hl, bc
	ld a, [hl]
	ld hl, wc076
	add hl, bc
	sub [hl]
	jr nc, .asm2_97a7
	ld a, $1
.asm2_97a7
	ld [hl], a
	ld hl, wc0ae
	add hl, bc
	ld a, e
	sub [hl]
	ld e, a
	ld a, d
	sbc b
	ld hl, wc0a6
	add hl, bc
	sub [hl]
	jr c, .asm2_97c3
	ld d, a
	ld b, $0
	ld hl, wc02e
	add hl, bc
	set 5, [hl]
	jr .asm2_97e6
.asm2_97c3
	ld hl, wc096
	add hl, bc
	ld d, [hl]
	ld hl, wc09e
	add hl, bc
	ld e, [hl]
	ld hl, wc0ae
	add hl, bc
	ld a, [hl]
	sub e
	ld e, a
	ld a, d
	sbc b
	ld d, a
	ld hl, wc0a6
	add hl, bc
	ld a, [hl]
	sub d
	ld d, a
	ld b, $0
	ld hl, wc02e
	add hl, bc
	res 5, [hl]
.asm2_97e6
	ld hl, wc076
	add hl, bc
.asm2_97ea
	inc b
	ld a, e
	sub [hl]
	ld e, a
	jr nc, .asm2_97ea
	ld a, d
	and a
	jr z, .asm2_97f8
	dec a
	ld d, a
	jr .asm2_97ea
.asm2_97f8
	ld a, e
	add [hl]
	ld d, b
	ld b, $0
	ld hl, wc07e
	add hl, bc
	ld [hl], d
	ld hl, wc086
	add hl, bc
	ld [hl], a
	ld hl, wc08e
	add hl, bc
	ld [hl], a
	ret

Music31_ApplyDutyCycle: ; 0x980d
	ld b, $0
	ld hl, wc046
	add hl, bc
	ld a, [hl]
	rlca
	rlca
	ld [hl], a
	and $c0
	ld d, a
	ld b, $1
	call Func2_9838
	ld a, [hl]
	and $3f
	or d
	ld [hl], a
	ret

Music31_GetNextMusicByte: ; 0x9825
	ld d, $0
	ld a, c
	add a
	ld e, a
	ld hl, wc006
	add hl, de
	ld a, [hli]
	ld e, a
	ld a, [hld]
	ld d, a
	ld a, [de] ; get next music command
	inc de
	ld [hl], e ; store address of next command
	inc hl
	ld [hl], d
	ret

Func2_9838: ; 0x9838
	ld a, c
	ld hl, Unknown2_9b17
	add l
	jr nc, .noCarry
	inc h
.noCarry
	ld l, a
	ld a, [hl]
	add b
	ld l, a
	ld h, $ff
	ret

Func2_9847: ; 0x9847
	ld h, $0
.loop
	srl a
	jr nc, .noCarry
	add hl, de
.noCarry
	sla e
	rl d
	and a
	jr z, .done
	jr .loop
.done
	ret

Func2_9858: ; 0x9858
	ld h, $0
	ld l, a
	add hl, hl
	ld d, h
	ld e, l
	ld hl, Music31_Pitches
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld a, b
.loop
	cp $7
	jr z, .done
	sra d
	rr e
	inc a
	jr .loop
.done
	ld a, $8
	add d
	ld d, a
	ret

Func2_9876:: ; 0x9876
	ld [wc001], a
	cp $ff
	jp z, Func2_9a34
	cp $b9
	jp z, Func2_994e
	jp c, Func2_994e
	cp $fe
	jr z, .asm2_988d
	jp nc, Func2_994e
.asm2_988d
	xor a
	ld [wc000], a
	ld [wc003], a
	ld [wc0e9], a
	ld [wc0e6], a
	ld [wc0e7], a
	ld d, $8
	ld hl, wc016
	call FillMusicRAM31
	ld hl, wc006
	call FillMusicRAM31
	ld d, $4
	ld hl, wc026
	call FillMusicRAM31
	ld hl, wc02e
	call FillMusicRAM31
	ld hl, wc03e
	call FillMusicRAM31
	ld hl, wc046
	call FillMusicRAM31
	ld hl, wc04e
	call FillMusicRAM31
	ld hl, wc056
	call FillMusicRAM31
	ld hl, wc05e
	call FillMusicRAM31
	ld hl, wc066
	call FillMusicRAM31
	ld hl, wc06e
	call FillMusicRAM31
	ld hl, wc036
	call FillMusicRAM31
	ld hl, wc076
	call FillMusicRAM31
	ld hl, wc07e
	call FillMusicRAM31
	ld hl, wc086
	call FillMusicRAM31
	ld hl, wc08e
	call FillMusicRAM31
	ld hl, wc096
	call FillMusicRAM31
	ld hl, wc09e
	call FillMusicRAM31
	ld hl, wc0a6
	call FillMusicRAM31
	ld hl, wc0ae
	call FillMusicRAM31
	ld a, $1
	ld hl, wc0be
	call FillMusicRAM31
	ld hl, wc0b6
	call FillMusicRAM31
	ld hl, wc0c6
	call FillMusicRAM31
	ld [wc0e8], a
	ld a, $ff
	ld [wc004], a
	xor a
	ld [$ff24], a
	ld a, $8
	ld [$ff10], a
	ld a, $0
	ld [$ff25], a
	xor a
	ld [$ff1a], a
	ld a, $80
	ld [$ff1a], a
	ld a, $77
	ld [$ff24], a
	jp Func2_9a8f

Func2_994e: ; 0x994e
	ld l, a
	ld e, a
	ld h, $0
	ld d, h
	add hl, hl
	add hl, de
	ld de, SFX_Headers_02
	add hl, de
	ld a, h
	ld [wc0ec], a
	ld a, l
	ld [wc0ed], a
	ld a, [hl]
	and $c0
	rlca
	rlca
	ld c, a
.asm2_9967
	ld d, c
	ld a, c
	add a
	add c
	ld c, a
	ld b, $0
	ld a, [wc0ec]
	ld h, a
	ld a, [wc0ed]
	ld l, a
	add hl, bc
	ld c, d
	ld a, [hl]
	and $f
	ld e, a
	ld d, $0
	ld hl, wc026
	add hl, de
	ld a, [hl]
	and a
	jr z, .asm2_99a3
	ld a, e
	cp $7
	jr nz, .asm2_999a
	ld a, [wc001]
	cp $14
	jr nc, .asm2_9993
	ret
.asm2_9993
	ld a, [hl]
	cp $14
	jr z, .asm2_99a3
	jr c, .asm2_99a3
.asm2_999a
	ld a, [wc001]
	cp [hl]
	jr z, .asm2_99a3
	jr c, .asm2_99a3
	ret
.asm2_99a3
	xor a
	push de
	ld h, d
	ld l, e
	add hl, hl
	ld d, h
	ld e, l
	ld hl, wc016
	add hl, de
	ld [hli], a
	ld [hl], a
	ld hl, wc006
	add hl, de
	ld [hli], a
	ld [hl], a
	pop de
	ld hl, wc026
	add hl, de
	ld [hl], a
	ld hl, wc02e
	add hl, de
	ld [hl], a
	ld hl, wc03e
	add hl, de
	ld [hl], a
	ld hl, wc046
	add hl, de
	ld [hl], a
	ld hl, wc04e
	add hl, de
	ld [hl], a
	ld hl, wc056
	add hl, de
	ld [hl], a
	ld hl, wc05e
	add hl, de
	ld [hl], a
	ld hl, wc066
	add hl, de
	ld [hl], a
	ld hl, wc06e
	add hl, de
	ld [hl], a
	ld hl, wc076
	add hl, de
	ld [hl], a
	ld hl, wc07e
	add hl, de
	ld [hl], a
	ld hl, wc086
	add hl, de
	ld [hl], a
	ld hl, wc08e
	add hl, de
	ld [hl], a
	ld hl, wc096
	add hl, de
	ld [hl], a
	ld hl, wc09e
	add hl, de
	ld [hl], a
	ld hl, wc0a6
	add hl, de
	ld [hl], a
	ld hl, wc0ae
	add hl, de
	ld [hl], a
	ld hl, wc036
	add hl, de
	ld [hl], a
	ld a, $1
	ld hl, wc0be
	add hl, de
	ld [hl], a
	ld hl, wc0b6
	add hl, de
	ld [hl], a
	ld hl, wc0c6
	add hl, de
	ld [hl], a
	ld a, e
	cp $4
	jr nz, .asm2_9a2b
	ld a, $8
	ld [$ff10], a
.asm2_9a2b
	ld a, c
	and a
	jp z, Func2_9a8f
	dec c
	jp .asm2_9967

Func2_9a34: ; 0x9a34
	ld a, $80
	ld [$ff26], a
	ld [$ff1a], a
	xor a
	ld [$ff25], a
	ld [$ff1c], a
	ld a, $8
	ld [$ff10], a
	ld [$ff12], a
	ld [$ff17], a
	ld [$ff21], a
	ld a, $40
	ld [$ff14], a
	ld [$ff19], a
	ld [$ff23], a
	ld a, $77
	ld [$ff24], a
	xor a
	ld [wc000], a
	ld [wc003], a
	ld [wc002], a
	ld [wc0e9], a
	ld [wc0eb], a
	ld [wc0e6], a
	ld [wc0e7], a
	ld d, $a0
	ld hl, wc006
	call FillMusicRAM31
	ld a, $1
	ld d, $18
	ld hl, wc0b6
	call FillMusicRAM31
	ld [wc0e8], a
	ld [wc0ea], a
	ld a, $ff
	ld [wc004], a
	ret

; fills d bytes at hl with a
FillMusicRAM31: ; 0x9a89
	ld b, d
.loop
	ld [hli], a
	dec b
	jr nz, .loop
	ret

Func2_9a8f: ; 0x9a8f
	ld a, [wc001]
	ld l, a
	ld e, a
	ld h, $0
	ld d, h
	add hl, hl
	add hl, de
	ld de, SFX_Headers_02
	add hl, de
	ld e, l
	ld d, h
	ld hl, wc006
	ld a, [de] ; get channel number
	ld b, a
	rlca
	rlca
	and $3
	ld c, a
	ld a, b
	and $f
	ld b, c
	inc b
	inc de
	ld c, $0
.asm2_9ab1
	cp c
	jr z, .asm2_9ab9
	inc c
	inc hl
	inc hl
	jr .asm2_9ab1
.asm2_9ab9
	push hl
	push bc
	push af
	ld b, $0
	ld c, a
	ld hl, wc026
	add hl, bc
	ld a, [wc001]
	ld [hl], a
	pop af
	cp $3
	jr c, .asm2_9ad2
	ld hl, wc02e
	add hl, bc
	set 2, [hl]
.asm2_9ad2
	pop bc
	pop hl
	ld a, [de] ; get channel pointer
	ld [hli], a
	inc de
	ld a, [de]
	ld [hli], a
	inc de
	inc c
	dec b
	ld a, b
	and a
	ld a, [de]
	inc de
	jr nz, .asm2_9ab1
	ld a, [wc001]
	cp $14
	jr nc, .asm2_9aeb
	jr .asm2_9b15
.asm2_9aeb
	ld a, [wc001]
	cp $86
	jr z, .asm2_9b15
	jr c, .asm2_9af6
	jr .asm2_9b15
.asm2_9af6
	ld hl, wc02a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld hl, wc012 ; sfx noise channel pointer
	ld de, Noise31_endchannel
	ld [hl], e
	inc hl
	ld [hl], d ; overwrite pointer to point to endchannel
	ld a, [wc005]
	and a
	jr nz, .asm2_9b15
	ld a, [$ff24]
	ld [wc005], a
	ld a, $77
	ld [$ff24], a
.asm2_9b15
	ret

Noise31_endchannel: ; 0x9b16
	endchannel

Unknown2_9b17: ; 0x9b17
	db $10, $15, $1A, $1F ; channels 0-3
	db $10, $15, $1A, $1F ; channels 4-7

Unknown2_9b1f: ; 0x9b1f
	db $EE, $DD, $BB, $77 ; channels 0-3
	db $EE, $DD, $BB, $77 ; channels 4-7

Unknown2_9b27: ; 0x9b27
	db $11, $22, $44, $88 ; channels 0-3
	db $11, $22, $44, $88 ; channels 4-7

Music31_Pitches: ; 0x9b2f
	dw $F82C ; C_
	dw $F89D ; C#
	dw $F907 ; D_
	dw $F96B ; D#
	dw $F9CA ; E_
	dw $FA23 ; F_
	dw $FA77 ; F#
	dw $FAC7 ; G_
	dw $FB12 ; G#
	dw $FB58 ; A_
	dw $FB9B ; A#
	dw $FBDA ; B_