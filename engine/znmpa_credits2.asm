; NOICE CREDITS CODE. IT LOOKS LIKE A DEMO-
; oh wait IT IS AHAHAHAHAH

Credits_Main:		; setup everything
; clear the screen
	call ClearScreen
; set SGB palette
	ld b, $8
	call GoPAL_SET
; clear variables
	xor a
	ld [wCreditsCurrentTextPtr], a
	ld [wCreditsCurrentTextPtr+1],a
	ld [wCreditsScroll1], a
	ld [wCreditsScroll2], a
; get that window outta my face
	ld a, $90
	ld [hWY],a
; load white tile
;	ld bc, (BANK(Credits_WhiteTile) << 8) + 1
;	ld de, Credits_WhiteTile
;	ld hl, vChars2 + $7f0
;	call CopyVideoData
; load "END" gfx
	ld bc, (BANK(CreditsTiles) << 8) + $60
	ld de, CreditsTiles
	ld hl, vChars2
	call CopyVideoData
; load tile map
	hlCoord 0,0
	ld de, CreditsTileMap
; load tilemap's length
	ld a, [de]	; fetch low byte
	inc de
	ld c, a	
	ld a, [de]
	ld b, a		; fetch high byte
; copy tilemap
	inc de
.copytiles
	ld a, [de]
	ld [hli], a
	inc de
	dec bc
	ld a, c
	or b
	jr nz, .copytiles
;move the map
	ld a, 1
	ld [H_AUTOBGTRANSFERENABLED], a
	call Delay3	; transfer frames
	xor a
	ld [H_AUTOBGTRANSFERENABLED], a		; no transfers
	ld a, [rLCDC]	; LCD controls
	set 3, a	; background = 9c00
	ld [rLCDC], a	; display screen
	call GBFadeInFromWhite
; wait a while
	ld c, 100
	call DelayFrames
	ld c, 50
	call DelayFrames
; clear out part of the screen
	hlCoord 0,14
	ld c, 20
	ld a, 2
.clearloop1
	ld [hli], a
	dec c
	jr nz, .clearloop1
	hlCoord 0,15
	ld c, 20
	ld a, 0
.clearloop2
	ld [hli], a
	dec c
	jr nz, .clearloop2
	hlCoord 0,16
	ld c, 20
	ld a, 3
.clearloop3
	ld [hli], a
	dec c
	jr nz, .clearloop3
	ld a, 1
	ld [H_AUTOBGTRANSFERENABLED], a
	call Delay3			; transfer frames
	xor a
	ld [H_AUTOBGTRANSFERENABLED], a
; initialize offset
	xor a
	ld c, a
; initialize table limit	
	ld hl, Credits_Table
	ld a, [hl]
	ld e, a
; initialize text scrolling offset
	ld a, -8
	ld [wCreditsScroll2], a
; initialize scrolling text pointer
	ld hl, Credits_Text
	ld a, h
	ld [wCreditsCurrentTextPtr], a
	ld a, l
	ld [wCreditsCurrentTextPtr+1], a
	
Credits_MainLoop:
; d = scanline compare value
; e = table limit
; c = table offset
	ld a, [wCreditsCurrentTextPtr]	; end of text?
	and a
	jp z, Credits_Done
	ld hl, Credits_Table_Begin
; get table value from table offset
	push de
	ld d, 0
	ld e, c
	add hl,de
	ld a,[hl]
	ld [wCreditsScroll1],a
	pop de
; distort "END" gfx
	call Credits_DistortScreen1
; do scrolling text
	call Credits_DoText_Scroll
; check if table offset reached
; limit
	ld a, c
	cp e
	jr z, .resetcounter
	inc c
	jr .continue
.resetcounter
	xor a
	ld c,a
.continue
; scroll the text
	ld a, [wCreditsScroll2]
	inc a
	ld [wCreditsScroll2], a
; done.
	jp Credits_MainLoop

Credits_Done:
; clear variables
	xor a
	ld [wCreditsCurrentTextPtr], a
	ld [wCreditsCurrentTextPtr+1],a
	ld [wCreditsScroll1], a
	ld [wCreditsScroll2], a
	ld [wTempStack], a
	ld [rSCX], a
	ld [rSCY], a
	ld [rWY], a
	hlCoord 0, 15
	ld de, ThanksForPlayingText
	ld a, [de]
.copystring
	ld [hli], a
	inc de
	ld a, [de]
	cp "@"
	jr nz, .copystring
	ld a, 1
	ld [H_AUTOBGTRANSFERENABLED], a
	call Delay3	; transfer frames
	xor a
	ld [H_AUTOBGTRANSFERENABLED], a	; disable transferring
	ret				; credits finish

	
; subroutines

Credits_DistortScreen1:
	ld a, [wCreditsScroll1]
	and a
	jr z, .done	; if zero, skip scanline trick
			; makes sure that you can see that 
			; beautiful "END" text without some shit going on
	push bc
	ld b, 7		; 7 rows
	ld d, 40	; scanline compare value
.loop
; this is the routine for a single tile
	call Credits_CheckScanLine
	ld a, [wCreditsScroll1]
	ld [rSCX], a
	inc d				; 41
	call Credits_CheckScanLine
	ld a, [wCreditsScroll1]
	inc a
	ld [rSCX], a
	inc d				; 42
	call Credits_CheckScanLine
	ld a, [wCreditsScroll1]
	inc a
	ld [rSCX], a
	inc d				; 43
	call Credits_CheckScanLine
	ld a, [wCreditsScroll1]
	ld [rSCX], a
	inc d				; 44
	call Credits_CheckScanLine
	ld a, [wCreditsScroll1]
	cpl
	ld [rSCX], a
	inc d				; 45
	call Credits_CheckScanLine
	ld a, [wCreditsScroll1]
	cpl
	dec a
	ld [rSCX], a
	inc d				; 46
	call Credits_CheckScanLine
	ld a, [wCreditsScroll1]
	cpl
	dec a
	ld [rSCX], a
	inc d				; 47
	call Credits_CheckScanLine
	ld a, [wCreditsScroll1]
	cpl
	ld [rSCX], a
	inc d
	dec b				; done?
	jr nz, .loop
	pop bc
.done
	xor a
	ld [rSCX], a		; return SCX to its place
	ret
	
Credits_DoText_Scroll:
	ld a, [wCreditsScroll2]		; current position
	and a
	jr nz, .skiploadingtexttile	; if we're still scrolling
					; skip the next routine
; load text tile
	call Credits_CheckOkay		; ensuring on-time VRAM manipulation
	ld a, [vBGMap1 + $1e0]		; move the first visible tile
	ld [vBGMap1 + $1ff], a		; to the end of the row
	ld b, 20			; tiles to move
	ld hl, vBGMap1 + $1e1		; begin offset
.move
	call Credits_CheckOkay		; wait till it's safe to tinker
					; with VRAM
	ld a, [hl]
	dec hl
	ld [hli], a			; move tile backwards
	inc hl				; next tile
	dec b
	jr nz, .move
; get character from pointer
	ld a, [wCreditsCurrentTextPtr]
	ld h, a
	ld a, [wCreditsCurrentTextPtr + 1]
	ld l, a
	ld a, [hl]
	call Credits_CheckOkay
; add new character
	cp "@"				; end of text?
	jr z, .finishtext
	ld [vBGMap1 + $1f3], a
; update the current character pointer
	inc hl
	ld a, h
	ld [wCreditsCurrentTextPtr], a
	ld a, l
	ld [wCreditsCurrentTextPtr + 1], a
; reset counter
	ld a, -8
	ld [wCreditsScroll2], a
.skiploadingtexttile
; update scx
	ld d, 120-4
	call Credits_CheckScanLine
	ld a, [wCreditsScroll2]
	ld [rSCX], a
	ld d, 128
	call Credits_CheckScanLine
	xor a
	ld [rSCX], a		; return SCX to its place
	ret
.finishtext
	xor a
	ld [wCreditsCurrentTextPtr], a
	jr .skiploadingtexttile

Credits_CheckScanLine:
	ld a, [rLY]
	cp d			; check if a certain scanline is rendering
	jr nz,Credits_CheckScanLine
; falls through here
Credits_CheckOkay:
	ld [wTempStack], a	; push and pop fucks up the gameboy :|
.loop
	ld a, [rSTAT]
	and %000011
	jr nz, .loop
	ld a, [wTempStack]	; if we're safe to do stuff to LCD
	ret			; then we're done waiting
	
Credits_Table:
db Credits_Table_End - Credits_Table_Begin
Credits_Table_Begin:
	db 0,0,0,0,0,0,0,0
	db 1,1,2,2,3,3,4,4
	db 5,6,10,11,15,16,20,21
	db 40,42,60,62,80,82,100,102
	db 120,124,140,144,160,164,180,184,200,204,220,224
	db 225,226,230,231,235,236,240,241,245,246
	db 247,248,249
	db 250,250,251,251,252,252,253,253
	db 254,254,255,255
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Credits_Table_End:	

CreditsTiles:
	INCBIN "gfx/enddemotiles.2bpp"
CreditsTiles_End:

CreditsTileMap:
	dw CreditsTileMap_End - CreditsTileMap_Begin
CreditsTileMap_Begin:
	db $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
	db $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
	db $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
	db $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
	db $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$04,$05,$06,$07,$08,$09,$0a,$0b,$0c,$0d,$0e,$0f,$10,$00,$00,$00
	db $00,$00,$00,$00,$11,$12,$13,$14,$15,$16,$17,$18,$19,$1a,$1b,$1c,$1d,$00,$00,$00
	db $00,$00,$00,$00,$1e,$1f,$20,$21,$22,$23,$24,$25,$26,$27,$28,$29,$2a,$00,$00,$00
	db $00,$00,$00,$00,$2b,$2c,$2d,$2e,$2f,$30,$31,$32,$33,$34,$35,$36,$37,$00,$00,$00
	db $00,$00,$00,$00,$38,$39,$3a,$3b,$3c,$3d,$3e,$3f,$40,$41,$42,$43,$44,$00,$00,$00
	db $00,$00,$00,$00,$45,$46,$47,$48,$49,$4a,$4b,$4c,$4d,$4e,$4f,$50,$51,$00,$00,$00
	db $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
	db $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
	db $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
	db $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
	db $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
	db $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
CreditsTileMap_End:	

Credits_Text:
; This is really just demo-like text.
	db "                "
	db "                "
	db "... Zilo and Monty's Pokémon Adventures Credits ... "
	db "Assembly modifications by ZoomTen ... "
	db "New sprites and graphics by ZoomTen ... "
	db "New scripts by ZoomTen ... "
	db "Script ideas: Haidenisa, ZoomTen, Rae, RedLeopardNyro ... "
	db "Custom music by ZoomTen ... "
	db "PCM playback code by Jeff Frohwein ... "
	db "Credits music (Toy Warrior) composed by Alphonse Uprising, arranged by ZoomTen ... "
	db "Kitsarushi, Rex Mask and their evolutions owned by RedLeopardNyro ... "
	db "Lumi and Mocha characters owned by Rae ... "
	db "Jinx character owned by Jay ... "
	db "Theta and Mwah characters owned by RedLeopardNyro ... "
	db "Haiden character owned by Haidenisa ... "
	db "Based on the pokered disassembly project by IIMarckus and contributors ... "
	db "Original Pokémon Red game made by Game Freak, Creatures and Nintendo ... "
	db "                "
	db "... Staff of Pokémon Red ... "
	db "Director: Satoshi Tajiri ... "
	db "Programmers: Takenori Oota, Shigeki Morimoto, Tetsuya Watanabe, Jun'ichi Masuda, Sousuke Tamada ... "
	db "Character design: Ken Sugimori, Atsuko Nishida ... "
	db "Music and sound effects: Jun'ichi Masuda ... "
	db "Game designer: Satoshi Tajiri ... "
	db "Pokémon designs: Ken Sugimori, Atsuko Nishida, Motofumi Fujiwara, Shigeki Morimoto, Satoshi Oota, Rena Yoshikawa ... "
	db "Scenario/scripting: Satoshi Tajiri, Ryousuke Taniguchi, Fumihiro Nonomura, Hiroyuki Jinnai ... "
	db "Parametric design: Kohji Nishino, Takeo Nakamura ... "
	db "Map design: Satoshi Tajiri, Kohji Nishino, Kenji Matsushima, Fumihiro Nonomura, Ryosuke Taniguchi ... "
	db "Product testing: Akiyoshi Kakei, Kazuki Tsuchiya, Takeo Nakamura, Masamitsu Yuda ... "
	db "Special thanks: Tatsuya Hishida, Yasuhiro Sakai, Wataru Yamaguchi, Kazuyuki Yamamoto, Akihito Tomisawa, Hiroshi Kawamoto, Tomomichi Oota ... "
	db "Producers: Shigeru Miyamoto, Takashi Kawaguchi, Tsunekazu Ishihara ... "
	db "US version staff ... "
	db "US coordination: Gail Tilden, Naoko Kawakami, Hiro Nakamura, William Giese, Sara Osborne ... "
	db "Text translation: Nob Ogasawara ... "
	db "Programmers: Teruki Murakawa, Kohta Fukui ... "
	db "Special thanks: Satoru Iwata, Takahiro Harada ... "
	db "Product testing: PAAD Testing, NCL Super Mario Club ... "
	db "Producer: Takehiro Izushi ... "
	db "Executive producer: Hiroshi Yamauchi ... "
	db "                    "
	db $50
	
ThanksForPlayingText:
	db "THANKS FOR PLAYING!@"
	
;Credits_WhiteTile:
;	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0