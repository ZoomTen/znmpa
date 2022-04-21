; Here for some reason...
CopyFixedLengthText: ; 42b1 (1:42b1)
	ld bc, $b
	jp CopyData

SetDefaultNamesBeforeTitlescreen: ; 42b7 (1:42b7)
	ld hl, NintenText
	ld de, wPlayerName ; wd158
	call CopyFixedLengthText

	ld hl, SonyText
	ld de, W_RIVALNAME ; wd34a
	call CopyFixedLengthText

	xor a
	ld [hWY], a

	ld [wd358], a
	ld hl, wd732
	ld [hli], a
	ld [hli], a
	ld [hl], a

	ld a, $1F
	ld [wc0ef], a
	ld [wc0f0], a

LoadTitlescreenGraphics:
	call ClearScreen
	xor a
	ld [H_AUTOBGTRANSFERENABLED], a ; $ffba
	ld b,$6
        call GoPAL_SET	; set SGB palette.

;Title screen...

LoadTitleScreenTiles:
	call DisableLCD
        ld hl, ZiloAndMixelTitleLogo
        ld de, $8800
        ld bc, $560
        ld a,  $4
        ld a,  BANK(ZiloAndMixelTitleLogo)
	call FarCopyData2

;Copyright
        ld hl, ZiloAndMixelTitleCopyright ;ptr
        ld de, $8D60 ;dest
        ld bc, $F0 ;length
        ld a,  BANK(ZiloAndMixelTitleCopyright)  ;bank
        call FarCopyData2

;Numbers 0-9
        ld hl, ZiloAndMixelTitleVNumbers ;ptr
        ld de, $8F60 ;dest
        ld bc, $A0 ;length
        ld a,  BANK(ZiloAndMixelTitleVNumbers)  ;bank
        call FarCopyData2

	ld a, $86
	ld [$D2D5], a

	call EnableLCD
	
	ld a, $1
	ld [H_AUTOBGTRANSFERENABLED], a ; $ffba
Title_PlaySFX:
        ld a, (SFX_1f_63 - SFX_Headers_1f) / 3
	call PlaySound

DrawTitle:
        ld hl, $C3A0 + $2C
        ld de, TitleTMap1

PlaceString2:			; this is a custom print string subroutine
	push hl
.nextchar
	ld a,[de]
	cp "@"			; has text ended?
	jr nz,.check7f
	ld b,h
	ld c,l
	pop hl
	jp Title_ContinueFromSub
.check7f			; RLE bby~
	cp $7F
	jr nz,.printletter2	; go ahead if not 7F
	inc de			; get counter
	ld a,[de]
	ld b, a			; saves counter value for later
.runcounter
	ld a, $7F		; loads $7F as a tile
	dec b			; decrements counter
.printletter	
	ld [hli],a		; move to the next entry in tile map
	call PrintLetterDelay
	ld a,b
	cp 0			; check if counter has finished
	jr z, .continue		; if it is, then proceed like normal
	jp .runcounter		; otherwise, keep putting $7F until counter dies out
.printletter2
	ld [hli],a		; move to the next entry in tilemap
	call PrintLetterDelay
.continue
	inc de
	jp .nextchar

Title_ContinueFromSub:
        ;--"POKEMON ADVENTURES"--
        ld hl,$C3A0 + $CE
        ld de,Title_Text1
        call PlaceString

        ld hl,$C3A0 + $E1
        ld de,Title_Text2
        call PlaceString

;        ld hl,$C3A0 + $F8
;        ld de,Title_BetaText
;        call PlaceString

	ld hl,$C3A0 + $11F
        ld de,Title_Prestart
        call PlaceString
        
        ld a, 1
	ld [wTitlescreenCounter], a
        
        call MovePicLeft
	hlCoord 2, 16
        ld de,Title_Copyright
        call PlaceString

	call WaitForSoundToFinish
	ld a, Mus_Title
	call PlayMusicEntry

Title_MainLoop:
	call DelayFrame
	dec c
	jr nz, .checkcontrols
.checkcounter
	ld a, [wTitlescreenCounter]
	and a
	jr z, .setflag
	xor a
	ld [wTitlescreenCounter], a
	ld hl,$C3A0 + $11F
        ld bc,$0106
        call ClearScreenArea
        ld c, 30
        jr .checkcontrols
.setflag
	ld a, 1
	ld [wTitlescreenCounter], a
	ld hl,$C3A0 + $11F
        ld de,Title_Prestart
        call PlaceString
        ld c, 40
.checkcontrols
	call JoypadLowSensitivity
	ld a, [$FFB4]
	cp a, D_UP | SELECT | B_BUTTON
	jr z, Title_ClearSave
	cp a, D_DOWN | D_LEFT | A_BUTTON
	jr z, Title_EasterEgg
	and a, START
	jr z, Title_MainLoop

ClickJump:
       ld a,$90
       call PlaySound
       jp MainMenu ; main menu

Title_ClearSave:
	ld b, BANK(DoClearSaveDialogue)
	ld hl, DoClearSaveDialogue
	jp Bankswitch
	
Title_EasterEgg:
	ld b, BANK(C64IntroThing)
	ld hl, C64IntroThing
	jp Bankswitch

;Title map
TitleTMap1:
db $80, $81, $82, $83, $84
db $7F, 3
db $85, $86, $87, $88 
db $7F, 8
db $90, $91, $92, $93, $94
db $7F, 3
db $95, $96, $97, $98
db $7F, 8
db $A0, $A1, $A2, $A3, $A4
db $7F, 3
db $A5, $A6, $A7, $A8
db $7F, 8
db $B0, $B1, $B2, $B3, $B4
db $7F, 3
db $B5, $B6, $B7, $B8 
db $7F, 8
db $89, $8A, $8B, $8C
db $7F, 3
db $A9, $AA, $AB, $AC, $AD
db $7F, 8
db $99, $9A, $9B, $9C
db $7F, 3
db $B9, $BA, $BB, $BC, $BD
db $7F, 7
db $8D, $8E, $8F, $9D, $9E, $9F
db $7F, 3
db $AE, $AF, $BE
db "@"

Title_Text1:
db $C0, $C1, $C2, $C3, $C4, $C1, $C5, "@"			; "POKEMON"

Title_Text2:
db $C6, $C7, $C8, $C9, $C5, $CA, $CB, $CC, $C9, $CD, "@"	; "ADVENTURES"

Title_BetaText:
db $D4		; "v"
db "10"
db $D5		; ".x"
db "@"

Title_Prestart:
db $CE, $CF, $D0, $D1, $D2, $D3, "@"

Title_Copyright:
db $D6					; "(c)"
db $D7, $D8, $D9, $DA, $E4		; "2013-"
db $D9, $DC, $7F			; "15 "
db $DE, $DF, $DF, $E0, $E1, $E2, $E3	; "ZOOMTEN"
db "@"

;Pokemon Red title screen stuff, seems to be used by other files.

Func_44dd: ; 44dd (1:44dd)
	ld hl, PlayerCharacterTitleGraphics ; $66a8
	ld de, vSprites
	ld bc, $230
	ld a, BANK(PlayerCharacterTitleGraphics)
	call FarCopyData2
	call ClearSprites
	xor a
	ld [wWhichTrade], a ; wWhichTrade
	ld hl, wOAMBuffer
	ld de, $605a
	ld b, $7
.asm_44fa
	push de
	ld c, $5
.asm_44fd
	ld a, d
	ld [hli], a
	ld a, e
	ld [hli], a
	add $8
	ld e, a
	ld a, [wWhichTrade] ; wWhichTrade
	ld [hli], a
	inc a
	ld [wWhichTrade], a ; wWhichTrade
	inc hl
	dec c
	jr nz, .asm_44fd
	pop de
	ld a, $8
	add d
	ld d, a
	dec b
	jr nz, .asm_44fa
	ret

Func_4519: ; 4519 (1:4519)
	ld hl, vBGMap0
	ld bc, $800
	ld a, $7f
	jp FillMemory

Func_4524: ; 4524 (1:4524)
	ld [wcf91], a
	ld [wd0b5], a
	hlCoord 5, 10
	call GetMonHeader
	jp LoadFrontSpriteByMonIndex

Func_4533: ; 4533 (1:4533)
	ld [$ffbd], a
	jp Delay3

LoadCopyrightAndTextBoxTiles: ; 4538 (1:4538)
	xor a
	ld [hWY], a
	call ClearScreen
	call LoadTextBoxTilePatterns

LoadCopyrightTiles: ; 4541 (1:4541)
	ld de, NintendoCopyrightLogoGraphics ; $60c8
	ld hl, vChars1
	ld bc, (BANK(NintendoCopyrightLogoGraphics) << 8) + $2A
	call CopyVideoData
	hlCoord 2, 6
	ld de, CopyrightTextString ; $4556
	jp PlaceString

CopyrightTextString: ; 4556 (1:4556)
	db   "ABCDEFG HIJKLM"
	next "ABCDEFG NOPQRSij" 
	next "ABCDEFG TUVWXYZij"
	next "A()(:(;[]abcdefgh"
	db   "@"
