NUM_SONGS	EQU 57

DisplaySoundTestMenu:
	ld a, $ff
	call PlaySound		; disable all sounds
	call ClearScreen
	xor a			; reset soundtest counter
	ld [wSoundTestNo],a
	hlCoord 0, 0
	ld b,16
	ld c,18
	call TextBoxBorder
	
	hlCoord 2,1
	ld de,SoundTestTitleText	; "SONG PLAYER:"
	call PlaceString
	
	ld a,1
	ld [H_AUTOBGTRANSFERENABLED],a ; enable auto background transfer
	call Delay3

DisplaySoundTestMenuMainLoop:
	hlCoord 15,1
	ld bc, $8103
	ld de, wSoundTestNo
	call PrintNumber
	
	hlCoord 1, 4
	ld c, 18
	ld b, 13
	call ClearScreenArea
	
DisplaySoundTestMenuPrintText:
	ld a, [wSoundTestMode]
	and a
	jr nz, .printotherscreen
	
	hlCoord 1,9
	ld de,SoundTestComposerText	; "COMPOSER:"
	call PlaceString
	
	hlCoord 1,14
	ld de,SoundTestArrangerText	; "ARRANGER:"
	call PlaceString

; Title of song
	call SoundTest_FetchTitle
	hlCoord 1,4
	call PlaceString
; Game
	call SoundTest_FetchGameTitle
	hlCoord 1,6
	call PlaceString

; Composer
	call SoundTest_FetchSongComposer
	hlCoord 1,11
	call PlaceString
	
; Arranger
	call SoundTest_FetchSongArranger
	hlCoord 1,16
	call PlaceString
	
	jp SoundTest_GetJoypadStateLoop
	
.printotherscreen
	hlCoord 1,4
	ld de,SoundTestSongInfoText	; "SONG INFO:"
	call PlaceString
	
	call SoundTest_FetchSongDescription
	hlCoord 1,6
	call PlaceString
	
;	hlCoord 1,8
;	ld de,SoundTestNoteDataText	; "NOTE DATA:"
;	call PlaceString
	
SoundTest_GetJoypadStateLoop:
	xor a
	ld [wSoundTestTemp],a
	ld [wSoundTestTemp+1],a
	call JoypadLowSensitivity
	ld a,[hJoy5]
	ld b,a
	and a,%11111111 ; any key besides select pressed?
	jr z,SoundTest_GetJoypadStateLoop
	bit 0,b ; A button pressed?
	jr nz,.executeSound
	bit 3,b ; Start button pressed?
	jr nz,.exitMenu
	bit 1,b ; B button pressed?
	jr nz,.stopSong
	bit 2,b ; Select pressed?
	jp nz,SoundTest_DoSwitch
	jr .checkDirectionKeys
.exitMenu
	call PlayDefaultMusic
	xor a
	ld [wSoundTestMode],a
	ret
	
.checkDirectionKeys
	bit 5,b ; Left pressed?
	jp nz,.pressedLeft
	bit 6,b ; Up pressed?
	jp nz,.pressedUp
	bit 7,b ; Down pressed?
	jp nz,.pressedDown
	jp .pressedRight
	
.pressedLeft
	ld a, [wSoundTestNo]
	dec a
	cp 255			; if we're on zero, and we decrement it results in 255
	jr nz, .noreset	
	ld a, NUM_SONGS		; so if we do, we reset the number to the number of songs defined.
.noreset
	ld [wSoundTestNo], a
	jp DisplaySoundTestMenuMainLoop
	
.pressedRight
	ld a, [wSoundTestNo]
	cp NUM_SONGS		; if we're in the max number and pressed right,
	jr z, .resetSoundTestNo	; instead we reset the number to zero.
	inc a
	ld [wSoundTestNo], a
	jp DisplaySoundTestMenuMainLoop
.resetSoundTestNo
	xor a
	ld [wSoundTestNo], a
	jp DisplaySoundTestMenuMainLoop
	
.pressedUp
	ld a, [wSoundTestNo]
	add 10
	cp NUM_SONGS
	jr c, .nooverflow_up
	xor a			; if we overflow then reset sound test number
.nooverflow_up
	ld [wSoundTestNo], a
	jp DisplaySoundTestMenuMainLoop
	
.pressedDown
	ld a, [wSoundTestNo]
	sub 10
	cp NUM_SONGS
	jr c, .nooverflow_down	
	ld a, NUM_SONGS		; if we overflow then max out sound test number
.nooverflow_down
	ld [wSoundTestNo], a
	jp DisplaySoundTestMenuMainLoop
	
.executeSound
	ld a,$FF
	call PlaySound ; make sure sound is completely reset
	ld a, [wSoundTestNo]
	call PlayMusicEntry	; play the loaded entry
	jp DisplaySoundTestMenuMainLoop
	
.stopSong
	ld a,$FF
	call PlaySound	; stop all sound
	jp DisplaySoundTestMenuMainLoop

SoundTest_DoSwitch:
	ld b, 6		; tiles / 3
	call SoundTestScrollAway
	ld a, [wSoundTestMode]
	and a
	jp nz, .loadcomposerarranger
	xor a
	ld b, a
	ld de, SoundTestSongInfoText
	hlCoord $12, 4
.searchend
	ld a, [de]
	cp "@"		; search for string end
	jr z, .continue
	inc de
	dec hl
	inc b		; keep track of how many characters we've checked
	jr .searchend
.continue
	dec de
	dec b
	jr nz, .continue	; go back to the beginning of string
	call PlaceString
;	ld b, 4			; rows >_>
;.stupid
;	ld a, 20
;.unnecessaryloop
;	inc hl
;	dec a
;	jr nz, .unnecessaryloop	; do I have to do this just to add hl by a value?
;	dec b
;	jr nz, .stupid		; wow shit
;	ld de, SoundTestNoteDataText
;	call PlaceString
	ld b, 3		; tiles / 3
	call SoundTestScrollAway
.checkmode
	ld a, [wSoundTestMode]
	and a
	jp z, .add
	xor a
	ld [wSoundTestMode], a
	jp DisplaySoundTestMenuMainLoop
.add
	inc a
	ld [wSoundTestMode], a
	jp DisplaySoundTestMenuMainLoop
	
.loadcomposerarranger
	xor a
	ld b, a
	ld de, SoundTestComposerText
	hlCoord $12, 9
.searchend2
	ld a, [de]
	cp "@"
	jr z, .continue2
	inc de
	dec hl
	inc b
	jr .searchend2
.continue2
	dec de
	dec b
	jr nz, .continue2
	call PlaceString
	ld b, 5
.stupid2
	ld a, 20
.unnecessaryloop2
	inc hl
	dec a
	jr nz, .unnecessaryloop2
	dec b
	jr nz, .stupid2	
	ld de, SoundTestArrangerText
	call PlaceString
	ld b, 3
	call SoundTestScrollAway
	jp .checkmode
	
SoundTestTitleText:
	db "SONG PLAYER:@"

SoundTestComposerText:
	db "COMPOSER:@"
	
SoundTestArrangerText:
	db "ARRANGER:@"

SoundTestSongInfoText:
	db "SONG INFO:@"
	
SoundTestNoteDataText:
	db "NOTE DATA:@"
	

INCLUDE	"data/soundtestgamecomposerarrangertext.asm"

INCLUDE	"data/soundtestsongentrytext.asm"

INCLUDE	"data/soundtestsongdesc.asm"
	

SoundTest_FetchTitle:
	ld a,[wSoundTestNo]
	add a
	ld hl, SoundTestSongTextEntries
	ld b, 0
	ld c, a
	add hl, bc
	ld a,[hli]
	ld e,a
	ld a,[hl]
	ld d,a
	ret
	
SoundTest_FetchSongDescription:
	ld a,[wSoundTestNo]
	add a
	ld hl, SoundTestSongDescriptions
	ld b, 0
	ld c, a
	add hl, bc
	ld a,[hli]
	ld e,a
	ld a,[hl]
	ld d,a
	ret

SoundTest_FetchGameTitle:
	ld a,[wSoundTestNo]
	ld b,a
	add a
	add a,b
	ld b, 0
	ld c, a
	ld hl, SoundTestGameComposerArranger
	add hl,bc
	ld a,[hli]
	add a
	ld b,a
	; --push hl---
	ld a,h
	ld [wSoundTestTemp],a
	ld a,l
	ld [wSoundTestTemp+1],a
	; ------------
	ld a,b
	ld hl, SoundTestCommonTextEntries
	ld b, 0
	ld c,a
	add hl,bc
	ld a,[hli]
	ld e, a
	ld a,[hl]
	ld d, a
	ret
	
SoundTest_FetchSongComposer:
	; --pop hl---
	ld a,[wSoundTestTemp]
	ld h,a
	ld a,[wSoundTestTemp+1]
	ld l,a
	; -----------
	ld a,[hli]
	add a
	ld b,a
	; --push hl---
	ld a,h
	ld [wSoundTestTemp],a
	ld a,l
	ld [wSoundTestTemp+1],a
	; ------------
	ld a,b
	ld hl, SoundTestCommonTextEntries
	ld b, 0
	ld c,a
	add hl,bc
	ld a,[hli]
	ld e, a
	ld a,[hl]
	ld d, a
	ret

SoundTest_FetchSongArranger:
	; --pop hl---
	ld a,[wSoundTestTemp]
	ld h,a
	ld a,[wSoundTestTemp+1]
	ld l,a
	; -----------
	ld a,[hl]
	add a
	ld b,a
	; --push hl---
	ld a,h
	ld [wSoundTestTemp],a
	ld a,l
	ld [wSoundTestTemp+1],a
	; ------------
	ld a,b
	ld hl, SoundTestCommonTextEntries
	ld b, 0
	ld c,a
	add hl,bc
	ld a,[hli]
	ld e, a
	ld a,[hl]
	ld d, a
	ret
	
SoundTestScrollAway:
	ld e, 3
	call Delay3
.scrollleft
	ld d, 13	; rows
	ld c, 17	; characters
	hlCoord 1,4	; starting point
.wholerowloop
	ld a, $7F
	ld [hli],a
.loop
	ld a, [hl]
	dec hl
	ld [hli],a
	inc hl
	dec c
	jr nz, .loop	; shift the row until all characters are done
	ld a, $7f	; finish up by writing a space
	dec hl		; on the very last tile
	ld [hl], a
	dec d		; this row done
	inc hl		; move to the next row
	inc hl
	inc hl
	ld c, 17	; reinitialize characters
	jr nz, .wholerowloop
	
	dec e
	jr nz, .scrollleft	; did we scroll e times?
				; if not, keep going
	dec b				; one frame done
	jr nz, SoundTestScrollAway	; keep looping until done
	ret