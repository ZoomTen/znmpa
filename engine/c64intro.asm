; it's an c64-style ocean loader sorta

C64IntroThing:
; stop music
	ld a, $FF
	call PlaySound
; clear the screen
	call ClearScreen
; set SGB palette
	ld a, 1
	ld [wPalSelect], a
	ld b, $8
	call GoPAL_SET
; disable tile snorts
	xor a
	ld [H_AUTOBGTRANSFERENABLED], a ; disable transfers
	ld [hTilesetType], a	; disable tile animations
; load font
	call LoadFontTilePatterns
; copy solid tiles
	ld bc, (BANK(LightGrayTile) << 8) + $1
	ld de, LightGrayTile
	ld hl, vChars2 + $10
	call CopyVideoData
	ld bc, (BANK(DarkGrayTile) << 8) + $1
	ld de, DarkGrayTile
	ld hl, vChars2 + $20
	call CopyVideoData
	ld bc, (BANK(BlackTile) << 8) + $1
	ld de, BlackTile
	ld hl, vChars2 + $30
	call CopyVideoData
	
C64IntroThing_PromptSim:	; first screen (the "BASIC prompt")
; print border and text
	call .printborder
	hlCoord 1,1
	ld de, .introtext
	call C64IntroThing_PrintText
	ld a, 1
	ld [H_AUTOBGTRANSFERENABLED], a ; enable transfers
; blink the cursor
	ld b, 5				; 5 times
	hlCoord 1,6
	call .blinkcursor
; print "load: press play on tape" (right where the cursor is)
	ld de, .loadtext
	call C64IntroThing_PrintText
; wait a while
	ld c, 120
	call DelayFrames
; clear entire screen
	ld a, 3				; black tile
	hlCoord 0,0
	ld bc, $1214
	call C64IntroThing_ClearArea
; simulate tape loading
	ld c, 240
	call DelayFrames
; reload the last screen
	ld a, 4
	hlCoord 0,0
	ld bc, $1214
	call C64IntroThing_ClearArea
	call .printborder
	hlCoord 1,1
	ld de, .introtext
	call C64IntroThing_PrintText
	hlCoord 1,6
	ld de, .loadtext
	call C64IntroThing_PrintText
; print "ok: found mcdshulk"
	hlCoord 1,9
	ld de, .oktext
	call C64IntroThing_PrintText
; wait.
	ld c, 180
	call DelayFrames
; clear screen again
	ld a, 3
	hlCoord 0,0
	ld bc, $1214
	call C64IntroThing_ClearArea
; load sgb
	ld b, $8
	call GoPAL_SET
; flashy transition 
	ld c, 255
.delay
	call C64IntroThing_DoFlash
	call DelayFrame
	dec c
	jr nz, .delay
	jp C64IntroThing_RevealPicture

; Subroutines
.printborder
	ld a, $03	; light gray tile
	hlCoord 0,0	; start
	call .fillrow
	ld b, 16
	call .fillmiddle
	call .fillrow
	ret
	
.typeintext
	ld a, [de]
	cp $4e
	jp z, .movenextrow2
	cp $50
	jp z, .finishtype
	ld [hli], a
	ld a, 3
	ld [hl], a
	inc de
	call Delay3
	jr .typeintext
.finishtype
	ret
.movenextrow2
	inc de
	ld a, [de]
	ld c, a
.movenextrowloop2
	inc hl
	dec c
	jr nz, .movenextrowloop2
	inc de
	jr .typeintext
	
.blinkcursor
	ld a, 3
	ld [hl], a
	ld c, $10
	call DelayFrames
	ld a, $7F
	ld [hl], a
	ld c, $10
	call DelayFrames
	dec b
	jr nz, .blinkcursor
	ret
	
.fillrow
	ld c, 20
.fillrowloop
	ld [hli], a
	dec c
	jr nz, .fillrowloop
	ret
	
.fillmiddle
	ld [hl], a
	ld c, 19
.skipcolumns
	inc hl
	dec c
	jr nz, .skipcolumns
	ld [hl],a
	inc hl
	dec b
	jr nz, .fillmiddle
	ret

; Text
	
.introtext
	db "-GAMEBOY BASIC V2-"
	db $4e, 2
	db "  8K RAM SYSTEM   "
	db $4e, 2
	db "  8192 BYTES FREE "
	db $4e, 2
	db $4e, 20
	db "READY."
	finish
.loadtext
	db "LOAD"
	db $4e, 16
	db $4e, 20
	db "PRESS PLAY ON TAPE"
	finish
.oktext
	db "OK"
	db $4e, 17
	db $4e, 21
	db "SEARCHING         "
	db $4e, 2
	db "FOUND MCDSHULK    "
	finish

C64IntroThing_PrintText:
	ld a, [de]
	cp $4e
	jr z, .movenextrow
	cp $50
	jr z, .finish
	ld [hli], a
	inc de
	jr C64IntroThing_PrintText
.finish
	ret
.movenextrow
	inc de
	ld a, [de]
	ld c, a
.movenextrowloop
	inc hl
	dec c
	jr nz, .movenextrowloop
	inc de
	jr C64IntroThing_PrintText
	
C64IntroThing_DoFlash:
; Do some snorts with tile #3 to produce
; the "flashing border" effect
	ld hl, vChars2+$30
.waitvram
	ld a, [rSTAT]
	and %000011
	jr nz, .waitvram
	ld a, [hRandomAdd]
	and %000101
	jr z, .set0
	ld b, $FF
	jr .dotiles
.set0
	ld b, $0
.dotiles
	ld a, b
	ld [hli], a
	inc hl
	ld [hli], a
	inc hl
	ld [hli], a
	inc hl
	ld [hli], a
	inc hl
	ld [hli], a
	inc hl
	ld [hli], a
	inc hl
	ld [hli], a
	inc hl
	ld [hli], a
	inc hl
	ret

C64IntroThing_ClearArea:
; Copy of ClearScreenArea
	ld de, 20 ; screen width
.y
	push hl
	push bc
.x
	ld [hli], a
	dec c
	jr nz, .x
	pop bc
	pop hl
	add hl, de
	dec b
	jr nz, .y
	call Delay3
	ret
	
C64IntroThing_RevealPicture:	; second screen (picture and loader music)
; clear middle of screen
	hlCoord 1,1
	ld a, 4
	ld bc, $1012
	call C64IntroThing_ClearArea
; flash border
	ld c, 100
.delayroutine
	call C64IntroThing_DoFlash
	call DelayFrame
	dec c
	jr nz, .delayroutine
	
; SCROLL UP TO SEE SHIRTLESS MCDONALD'S SHULK.
	hlCoord 1,1
	ld de, .nowloadingtext
	call C64IntroThing_PrintText
; again, delay
	ld c, 255
.delayroutine2
	call C64IntroThing_DoFlash
	call DelayFrame
	dec c
	jr nz, .delayroutine2
; clear screen area
	hlCoord 1,1
	ld a, 4
	ld bc, $1012
	call C64IntroThing_ClearArea
; reset black tile
	ld bc, (BANK(BlackTile) << 8) + $1
	ld de, BlackTile
	ld hl, vChars2 + $30
	call CopyVideoData
	call DelayFrame
; play loader music
	ld a, Mus_OceanLoader3
	call PlayMusicEntry
; actually load the image
	ld bc, (BANK(DemoImage) << 8) + $7b
	ld de, DemoImage
	ld hl, vChars2 + $50
	call CopyVideoData
	ld bc, (BANK(DemoImage) << 8) + $80
	ld de, DemoImage + $7b0
	ld hl, vChars1
	call CopyVideoData
	ld a, 2
	ld [wPalSelect], a
	ld b, $8
	call GoPAL_SET
	
	ld c, 50
	call DelayFrames

; "load" the image
; prints gradually by tile
; simulating a 1980s c64 loader image
	hlCoord 2,2	; start coordinates
	ld d, 5		; tile
	ld b, 16	; width
	ld c, 14	; height
	
.columnloop
	push bc
	ld c, 5
	call DelayFrames
	pop bc
	ld a, d
	ld [hli], a
	call DelayFrame
	inc d
	dec b
	jr nz, .columnloop
	dec c
	jr z, .finish
;fuck
	inc hl
	inc hl
	inc hl
	inc hl
	ld b, 16
	jr .columnloop
.finish
; wait until start pressed
	call JoypadLowSensitivity
	ld a, [$FFB5]
	and a, START
	jr z, .finish
	jp Init
	
.nowloadingtext
	db "NOW LOADING CREEPY"
	db $4e, 2
	db "MCDONALD's SHULK   "
	db $4e, 2
	db "STARING INTO YOUR "
	db $4e, 2
	db "SOUL"
	finish
	
LightGrayTile:
	dw $00FF
	dw $00FF
	dw $00FF
	dw $00FF
	dw $00FF
	dw $00FF
	dw $00FF
	dw $00FF
DarkGrayTile:
	dw $FF00
	dw $FF00
	dw $FF00
	dw $FF00
	dw $FF00
	dw $FF00
	dw $FF00
	dw $FF00
BlackTile:
	dw $FFFF
	dw $FFFF
	dw $FFFF
	dw $FFFF
	dw $FFFF
	dw $FFFF
	dw $FFFF
	dw $FFFF
	
DemoImage:
	INCBIN "gfx/demoimage.2bpp"