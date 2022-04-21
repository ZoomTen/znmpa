Credits::
	ld a, $80
	ld [hWY], a			; init window scroll
Credits_MainLoop:
	ld hl, CreditsOrder		; load index
	ld a, [wCreditsIndex]
	and a				; have we just started? (index=0)
	jr z, .dictionary		; jump right ahead to starting point

.movetoindex
	inc hl
	dec a
	jr nz, .movetoindex

.dictionary
; Checks index to a subroutine-dictionary.
	ld a, [hl]
	cp $ff
	jp z, Cred_CmdScroll
	cp $fe
	jp z, Cred_CmdShowCopyright
	cp $fd
	jp z, Cred_CmdShowTheEnd
	cp $fc
	jp z, Cred_CmdTextCut
	cp $fb
	jp z, Cred_CmdEnableOAM
	cp $fa
	jp z, Cred_CmdDisableOAM
	cp $f9
	jp z, Cred_ScrollAndStop
	ld de, CreditsTextPointers	; load pointers

; Fetches the correct pointer-entry
	push bc
	ld bc, 0
	ld a, [hl]
	add a
	jr nc, .nocarry
	ld b, 1
.nocarry
	ld c, a
	push hl
	ld h, b
	ld l, c
	add hl, de
	ld d, h
	ld e, l
	pop hl

; Grabs pointer from pointer-entry
	ld a, [de]
	ld c, a
	inc de
	ld a, [de]
	ld b, a
	ld d, b
	ld e, c
	pop bc

; Prints text from pointer
	call Cred_PrintText
	ld a, [wCreditsLineNo]
	inc a
	ld [wCreditsLineNo], a
	call Cred_MoveToNextIndex
	jp Credits_MainLoop

; --Command routines--

Cred_CmdScroll:	; Scrolls credits according to a table.
	call Cred_Scroll
; Wait a while.
	ld c, 150
	call DelayFrames
; Fade out.
	call Cred_FadeBGP
; Reset Window-y to starting point.
	ld a, $80
	ld [hWY], a
	call DelayFrame
	call ClearScreen
	call GBPalNormal
	xor a
	ld [wCreditsLineNo], a
	call Cred_MoveToNextIndex
	jp Credits_MainLoop

Cred_CmdShowCopyright:	; Shows copyright ( ©1995-1998 game freak, creatures, etc. )
	callba LoadCopyrightTiles
	call Cred_MoveToNextIndex
	jp Credits_MainLoop

Cred_CmdShowTheEnd:	; Shows "THE END"
	call ClearScreen
; Load GFX
	ld de, TheEndGfx
	ld hl, vChars2 + $600
	ld bc, (BANK(TheEndGfx) << 8) + $0a
	call CopyVideoData
; Load tilemap
	hlCoord 4, 8
	ld de, TheEndTextString
	call PlaceString
	hlCoord 4, 9
	inc de
	call PlaceString
; Fades the "THE END" screen in.
	call GBFadeInFromWhite
	ld c, 60
	call DelayFrames
	ld c, 155
	call DelayFrames
	ld a, $80
	ld [hWY], a
	call GBFadeOutToWhite
	call ClearScreen
	call GBPalNormal
	xor a
	ld [wCreditsLineNo], a
	call Cred_MoveToNextIndex
	jp Credits_MainLoop

Cred_CmdTextCut:	; This ever used?
; Reset Window-y to 0
	call DelayFrame
	xor a
	ld [hWY], a
	ld c, 155
	call DelayFrames
; Fade out.
	call GBFadeOutToWhite
	call ClearScreen
	call GBPalNormal
	xor a
	ld [wCreditsLineNo], a
	call Cred_MoveToNextIndex
	ret

Cred_CmdEnableOAM:	; Scrolls "CREDITS" in.
	ld de, wOAMBuffer
	ld hl, CredOAMData
	ld bc, CredOAMDataEnd - CredOAMData
	call CopyData	; load OAM
	call Cred_ScrollOAM
	call Cred_MoveToNextIndex
	jp Credits_MainLoop

Cred_CmdDisableOAM:	; Scrolls "CREDITS" out.
	call Cred_ScrollOAM
	call Cred_ClearOAM
	call Cred_MoveToNextIndex
	jp Credits_MainLoop

Cred_ScrollAndStop:	; Last screen
	call LoadFontTilePatterns ; reload font
	call Cred_Scroll
	xor a
	ld [wCreditsIndex], a
	ld [wCreditsLineNo], a
	ret

; 						=== SUBROUTINES ===

Cred_PrintText:
	; Printing start point.
	hlCoord 9, 4

; Offset text X.
; This uses the first byte pointed by
; de. The actual text is located at
; de + 1. As a regular string, the text
; still ends if char = $50 as usual.
	ld a, [de]
	ld b, a
	ld a, l
	add a, b
	ld l, a
	inc de

; Offset text Y.
; This reads from a WRAM address
; dedicated to the current line number.
	push de
	ld a, [wCreditsLineNo]
	and a
	jr z, .offsetyend
	ld b, a
	xor a
.offsetyloop
	add a, $28
	dec b
	ld c, a
	ld a, b
	and a
	jr z, .offsetyloopend
	ld a, c
	jr .offsetyloop
.offsetyloopend
	add hl, bc
.offsetyend
	pop de
	call PlaceString
	ret

Cred_MoveToNextIndex:
	ld a, [wCreditsIndex]
	inc a
	ld [wCreditsIndex], a
	ret

Cred_Scroll:
; This was literally copied from the title screen asm...
; Run scrolling according to a table
	ld bc, hWY
	ld hl, Cred_ScrollTable
.loop1
	ld a, [hli]
	and a
	jr z, .continue
	ld d, a
	cp $fd
	jr nz, .loop2
.loop2
	ld a, [hli]
	ld e, a
	call .ScrollY
	jr .loop1
.ScrollY
	call DelayFrame
	ld a, [bc]
	add d
	ld [bc], a
	dec e
	jr nz, .ScrollY
.continue
	ret

Cred_FadeBGP:
	ld hl, Cred_FadePal
	ld b, 4
.fade
	ld a, [hli]
	cpl
	ld [rBGP], a
	ld c, 4
	call DelayFrames
	dec b
	jr nz, .fade
	ret

Cred_ClearOAM:
	ld hl, wOAMBuffer
	ld bc, 4 * 40
	ld a, $0
	jp FillMemory

Cred_ScrollOAM:
	ld b, 12	; number of times to scroll
.scroll
	call DelayFrame
	ld c, 7		; number of letters
	ld hl, wOAMBuffer
	inc hl		; get x
.loop
	ld a, [hl]
	sub 8
	ld [hl], a
	inc hl
	inc hl
	inc hl
	inc hl		; get next OAM data
	dec c
	jr nz, .loop
	dec b
	jr nz, .scroll
	ret

; 						=== DATA ===

Cred_ScrollTable:
; The table format is as follows:
; offset, length
; It is terminated by the $00 byte.
	db -16, 4
	db -8, 4
	db -4, 4
	db -2, 4
	db -1, 8
	db 0

TheEndTextString: ; 74229 (1d:4229)
; "T H E  E N D"
	db $60," ",$62," ",$64,"  ",$64," ",$66," ",$68,"@"
	db $61," ",$63," ",$65,"  ",$65," ",$67," ",$69,"@"
	;   T       H       E        E       N       D

CredOAMData:
	oam_def 18, 3, "C", 0
	oam_def 19, 3, "R", 0
	oam_def 20, 3, "E", 0
	oam_def 21, 3, "D", 0
	oam_def 22, 3, "I", 0
	oam_def 23, 3, "T", 0
	oam_def 24, 3, "S", 0
CredOAMDataEnd:

Cred_FadePal:
	db %00011011
	db %01101111
	db %10111111
	db %11111111

INCLUDE "data/credits_order_new.asm"

INCLUDE "text/credits_text_new.asm"

TheEndGfx: ; 7473e (1d:473e) ; 473E (473F on blue)
	INCBIN "gfx/theend.interleave.2bpp"
