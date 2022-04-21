CopyTileIDsFromList_ZeroBaseTileID: ; 41842 (10:5842) in-game related
	ld c, $0
	predef_jump CopyTileIDsFromList

Func_41849: ; 41849 (10:5849) in-game related
	predef Func_79869
	ld a, b
	jp PlaySound

; ACTUAL INTRO CODE GOES HERE

PlayIntro: ; 41682 (10:5682)
	xor a
	ld [hJoyHeld], a
	inc a
	ld [H_AUTOBGTRANSFERENABLED], a
	call Intro_CopyrightScreen
	call IntroZoomTenPresents
	call Intro_MainScene
IntroFinish:
	call GBFadeOutToWhite
	xor a
	ld [hSCX], a
	ld [H_AUTOBGTRANSFERENABLED], a
	ld [wIntroPalFlag], a
	call ClearSprites
	call DelayFrame
	ret

Intro_CopyrightScreen: ; 4188a (10:588a)
	ld b, $c
	call GoPAL_SET
	callba LoadCopyrightAndTextBoxTiles
	ld a, $e4
	ld [rBGP], a		; reset background palette
	ld c, 60 * 3
	call DelayFrames	; wait 3 seconds
	call ClearScreen
	call DisableLCD
	xor a
	ld [W_CUROPPONENT], a	; wd059
	call Intro_LoadBlackWhiteTile
	call Intro_WidescreenEffect
	call LoadFontTilePatterns
	call EnableLCD
	ld hl, rLCDC ; $ff40
	res 5, [hl]		; disable WIN
	set 3, [hl]		; set BGMAP to $9C00
	call Intro_ClearMiddleOfScreen
	jp Delay3

; intro subroutines...

Intro_WidescreenEffect: ; 418e9 (10:58e9)
	call IntroClearBGMap
	ld hl, wTileMap
	ld c, $50
	call IntroBGMapFillBlack
	hlCoord 0, 14
	ld c, $50
	call IntroBGMapFillBlack
	ld hl, vBGMap1
	ld c, $80
	call IntroBGMapFillBlack
	ld hl, vBGMap1 + $1c0
	ld c, $80
	jp IntroBGMapFillBlack
	
IntroClearBGMap: ; 417f0 (10:57f0)
	ld hl, vBGMap1
	ld bc, $240
	jr IntroBGMapFillZero

Intro_ClearMiddleOfScreen: ; 417f8 (10:57f8)
	hlCoord 0, 4
	ld bc, 20 * 10
IntroBGMapFillZero: ; 417fe (10:57fe)
	ld [hl], $0
	inc hl
	dec bc
	ld a, b
	or c
	jr nz, IntroBGMapFillZero
	ret

IntroBGMapFillBlack: ; 41807 (10:5807)
	ld a, $1
.fill
	ld [hli], a
	dec c
	jr nz, .fill
	ret
	
Intro_LoadBlackWhiteTile:
	ld hl, vChars2		; tile $00
	ld c, $10
	ld a, 0
.loadwhite
	ld [hli], a
	dec c
	jr nz, .loadwhite	; load white tile
	ld hl, vChars2+$10	; tile $01
	ld c, $10
	ld a, $ff
.loadblack
	ld [hli], a
	dec c
	jr nz, .loadblack	; load white tile
	ret
	
; MAIN INTRO CODES
	
IntroZoomTenPresents:		; "ZoomTen presents..." with a typing effect
	call GBPalNormal
	hlCoord 1, 8
	ld de, ZoomTenPresentsText
.type
	ld a, $0f
	call PlaySound
	call Delay3			; responsible for typewriter effect
	ld a, [de]			; fetch character
	ld [hli], a			; put character
	inc de
	ld a, [de]
	cp "@"				; check for end of string
	jr nz, .type
	ld c, 60 * 2
	call CheckForUserInterruption	; wait 2 seconds
	ret c
	ret
	
ZoomTenPresentsText:
	db "ZoomTen presents...@"
	
Intro_MainScene:
	call Intro_ClearMiddleOfScreen
	ld a, Mus_IntroBattle
	call PlayMusicEntry	; play music
	xor a
	ld [wIntroPalFlag], a	; set palette flag
	ld b, $7
	call GoPAL_SET		; reload palette
; Load border and floof tiles
	ld de, Intro_GFXTileset
	ld hl, vChars2 + $20
	ld bc, (BANK(Intro_GFXTileset) << 8) + $A
	call CopyVideoData
; Load thingy for the bottom
	ld de, Intro_GFXTileset + $A0
	ld hl, vChars2 + $600				; I can't be bothered to edit the tilemap
							; so I assigned tile $60 to that
	ld bc, (BANK(Intro_GFXTileset) << 8) + $1
	call CopyVideoData
; Um, okay. OAM reads from $8800...
	ld de, Intro_GFXTileset + $20
	ld hl, vChars0
	ld bc, (BANK(Intro_ZiloTileset) << 8) + $8
	call CopyVideoData
; Fill top of screen with gradient thingy
	hlCoord 0, 4
	ld a, 2			; upper tile
	ld bc, 20
	call FillMemory
	hlCoord 0, 5
	ld a, 3			; lower tile
	ld bc, 20
	call FillMemory
; Fill bottom of screen
	hlCoord 0, $d
	ld a, $60			; lower tile
	ld bc, 20
	call FillMemory
; Extend till VRAM is covered
	call DisableLCD			; ensures safe copying
	ld hl, vBGMap1 + $94
	ld a, 2
	ld c, 12
.fillvram1
	ld [hli], a
	dec c
	jr nz, .fillvram1
	ld hl, vBGMap1 + $b4
	ld a, 3
	ld c, 12
.fillvram2
	ld [hli],a
	dec c
	jr nz, .fillvram2
	ld hl, vBGMap1 + $1b4
	ld a, $60
	ld c, 12
.fillvram3
	ld [hli],a
	dec c
	jr nz, .fillvram3
	call EnableLCD
	ld a, $60
	ld [hSCX], a	; initialize X scroll
; Load Zilo tiles
	ld de, Intro_ZiloTileset
	ld hl, vChars2 + $C0
	ld bc, (BANK(Intro_ZiloTileset) << 8) + $45
	call CopyVideoData
; Load Zilo tilemap
	hlCoord 1,6		; tile map begin
	ld b, 8			; number of rows
	ld de, Intro_ZiloTmap	; tilemap
	call IntroDecodeTmap
; First scrolling effect
	ld b, -2		; how many pixels to scroll in one cycle
	ld c, $18		; how many times to run routine
	call Intro_DoScroll
; This gives a slight pause between animations
; Just so the intro's skippable :p
	ld c, 10
	call CheckForUserInterruption
	ret c
; Load "ZILO" OAM data
	ld a, (SFX_1f_66 - SFX_Headers_1f) / 3
	call PlaySound
	ld hl, Intro_ZiloOAM
	ld de, wOAMBuffer
	ld bc, Intro_ZiloOAM_End - Intro_ZiloOAM
	call CopyData
; Second scrolling effect
	ld b, -1
	ld c, $70 + $80		; the $80 is when you want to scroll OAM
				; OAM moves in the opposite direction as SCX
	ld a, 4
	ld [wIntroOAMEntries], a
	call Intro_DoScroll
	ld c, 5
	call CheckForUserInterruption
	ret c
; Third scrolling effect
	ld b, -4
	ld c, $16 + $80
	ld a, 4
	ld [wIntroOAMEntries], a
	call Intro_DoScroll
	ld c, 5
	call CheckForUserInterruption
	ret c
; Monty's animation
	ld a, $60
	ld [hSCX], a		; reinitialize X scroll	
	call ClearSprites	; clear OAM data
	ld a, 1
	ld [wIntroPalFlag], a	; set palette flag (Monty)
	ld b, $7
	call GoPAL_SET		; reload palette
; Load Monty tiles
	ld de, Intro_MontyTileset
	ld hl, vChars2 + $C0
	ld bc, (BANK(Intro_MontyTileset) << 8) + $44
	call CopyVideoData
; Load Monty tilemap
	hlCoord 1,6
	ld b, 8	
	ld de, Intro_MontyTmap
	call IntroDecodeTmap
; Fourth scrolling effect
	ld b, 2
	ld c, $20
	call Intro_DoScroll
	ld c, 5
	call CheckForUserInterruption
	ret c
; Load "MONTY" OAM data
	ld a, (SFX_1f_66 - SFX_Headers_1f) / 3
	call PlaySound
	ld hl, Intro_MontyOAM
	ld de, wOAMBuffer
	ld bc, Intro_MontyOAM_End - Intro_MontyOAM
	call CopyData
; Fifth scrolling effect
	ld b, 1
	ld c, $70 + $80
	ld a, 5
	ld [wIntroOAMEntries], a
	call Intro_DoScroll
	ld c, 5
	call CheckForUserInterruption
	ret c
; Sixth scrolling effect
	ld b, 4
	ld c, $16 + $80
	ld a, 5
	ld [wIntroOAMEntries], a
	call Intro_DoScroll
	ld c, 5
	call CheckForUserInterruption
	ret c
; "IN..." animation
	ld a, 2
	ld [wIntroPalFlag], a	; set palette flag (null)
	ld b, $7
	call GoPAL_SET		; reload palette
	hlCoord 1, 6
	ld c, 11
	ld b, 7		; 117.
	call ClearScreenArea
	hlCoord 0, $d
	ld a, $60			; lower tile
	ld bc, 20
	call FillMemory
	ld hl, Intro_ThirdScreenOAM
	ld de, wOAMBuffer
	ld bc, Intro_ThirdScreenOAM_End - Intro_ThirdScreenOAM
	call CopyData			; Load OAM data
	ld a, 110
	ld [wIntroPalFlag],a		; palette flag no longer used, so it's safe
					; to be used as counter
.scrollloop
	ld b, 2
	ld c, $1 + $80
	ld a, 5
	ld [wIntroOAMEntries], a
	call Intro_DoScroll
	ld c, 1
	call CheckForUserInterruption
	ret c
	ld a, [wIntroPalFlag]
	dec a
	ld [wIntroPalFlag], a
	jr nz, .scrollloop
	ret
	
Intro_GFXTileset:
	INCBIN "gfx/znm10intro/gfxtiles.2bpp"
Intro_ZiloTileset:
	INCBIN "gfx/znm10intro/zilotiles.2bpp"
Intro_MontyTileset:
	INCBIN "gfx/znm10intro/mixeltiles.2bpp"	; shit, I've become too used
						; to Mixel over Monty. ffff
Intro_ZiloTmap:
	db $00, 4, $0c, $0d, $00, 1, $0e, $00, 3
	db $ff
	db $00, 4, $0f, $10, $11, $12, $13, $14, $15
	db $ff
	db $00, 2, $16, $17, $18, $19, $1a, $1b, $1c, $1d, $1e
	db $ff
	db $1f, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29
	db $ff
	db $2a, $2b, $2c, $2d, $2e, $2f, $30, $31, $32, $33, $34
	db $ff
	db $35, $36, $37, $38, $39, $3a, $3b, $3c, $3d, $3e, $00, 1
	db $ff
	db $3f, $40, $41, $42, $43, $44, $45, $46, $47, $48, $00, 1
	db $ff
	db $00, 1, $49, $4a, $4b, $4c, $4d, $4e, $4f, $50, $00, 1
	db $ff
	
Intro_MontyTmap:
	db $00, 1, $0c, $0d, $0e, $0f, $10, $11, $12, $13, $00, 2
	db $ff
	db $00, 1, $14, $15, $16, $17, $18, $19, $1a, $1b, $00, 2
	db $ff
	db $00, 1, $1c, $1d, $1e, $1f, $20, $21, $22, $00, 3
	db $ff
	db $00, 1, $23, $24, $25, $26, $27, $28, $29, $00, 3
	db $ff
	db $00, 1, $2a, $2b, $2c, $2d, $2e, $2f, $30, $31, $32, $00, 1
	db $ff
	db $00, 2, $33, $34, $35, $36, $37, $38, $39, $3a, $00, 1
	db $ff
	db $00, 1, $3b, $3c, $3d, $3e, $3f, $40, $41, $42, $43, $44
	db $ff
	db $45, $46, $47, $48, $49, $4a, $4b, $4c, $4d, $4e, $4f
	db $ff

Intro_ZiloOAM:
	oam_def $10, $0d, $00, $80	; Z
	oam_def $11, $0d, $01, $80	; I
	oam_def $12, $0d, $02, $80	; L
	oam_def $13, $0d, $03, $80	; O
Intro_ZiloOAM_End:

Intro_MontyOAM:
	oam_def $00, $07, $04, $80	; M
	oam_def $01, $07, $03, $80	; O
	oam_def $02, $07, $05, $80	; N
	oam_def $03, $07, $06, $80	; T
	oam_def $04, $07, $07, $80	; Y
Intro_MontyOAM_End:

Intro_ThirdScreenOAM:
	oam_def $1a, $0a, $88, $0	; I
	oam_def $1b, $0a, $8D, $0	; N
	oam_def $1c, $0a, $E8, $0	; .
	oam_def $1d, $0a, $E8, $0	; .
	oam_def $1e, $0a, $E8, $0	; .
Intro_ThirdScreenOAM_End:

IntroDecodeTmap:
	ld a, [de]
	and a		; is zero character?
	jr z, IntroZeroRLE
	cp $ff		; entry end?
	jr z, .endentry
	ld [hli], a
	inc de
	jr IntroDecodeTmap
.endentry
	dec b
	ret z
	ld c, 9
.moverows
	inc hl
	dec c
	jr nz, .moverows
	inc de
	jr IntroDecodeTmap
	
IntroZeroRLE:
	inc de
	ld a, [de]
	ld c, a
	xor a
.keepputtingzeroes
	ld [hli], a
	dec c
	jr nz, .keepputtingzeroes
	inc de		; read next character
	jr IntroDecodeTmap
	
Intro_DoScroll:
; Intro scrolling function.
; b is how many pixels to scroll in one instance
; c is how many times this routine is run.
;	00 - 7f = scroll SCX only
;	80 - ff = scroll SCX and OAM in the opposite direction
; wIntroOAMEntries must be set if OAM is needed to be scrolled, 
; contains how many OAM entries to be scrolled.
	call DelayFrame
	ld a, [wIntroOAMEntries]
	ld d, a
	push bc
	bit 7, c
	jr z, .scrollscx
	res 7, c
; Scroll SCX
.scrollscx
	ld a, [hSCX]
	add a, b
	ld [hSCX], a
	pop bc
	bit 7,c
	jr z, .skipoam
; Scroll OAM
	ld hl, wOAMBuffer
.modifyoam
	inc hl			; get x position
	ld a, [hl]
	add a, b
	ld [hl], a
	inc hl
	inc hl
	inc hl
	dec d
	jr nz, .modifyoam
.skipoam
	bit 7, c
	jr nz, .check80
	dec c
	jr nz, Intro_DoScroll
	ret
.check80
	dec c
	ld a, c
	cp $80
	jr nz, Intro_DoScroll
	ret