BattleTransition_ShowPic:
	call ClearSprites	; clean OAM
	ld a, %11100100
	ld [rOBP0], a		; full-color palette

BattleTransition_ShowPic_ClearArea:
	hlCoord 0, 6		; where to begin clearing tiles
	ld c, (20 * 6)		; how many tiles should we clear out?
.cleararea
	ld a, $7f		; load the space character
	ld [hli], a
	dec c
	ld a, c
	and a
	jr nz, .cleararea	; keep clearing until we're through
	ld c, 24		; +
	call DelayFrames	; +
	
BattleTransition_ShowPic_LoadTiles:
	ld a, [W_CUROPPONENT]
	cp SONY3 + $C8	; final rival id
	jr z, .loadtheta
	cp MASKEDLUMI + $C8	; lumi id
	jr z, .loadlumi
	ld de, 0	; null, should do nothing but graphical glitches
	jr .load
.loadtheta
	ld de, BattleTransition_ThetaPic
	jr .load
.loadlumi
	ld de, BattleTransition_LumiPic
.load
	ld hl,vChars0
	ld b, $2d
	ld c, 6*6
	call CopyVideoData	; overwrite sprite tileset with pic tiles
	
BattleTransition_ShowPic_LoadPicOAM:
	ld bc, $0606		; width and height of picture
	ld hl, wOAMBuffer
	ld d, 8*8		; initial Y position
	ld e, $e0		; initial X position
	ld a, 0			; starting tile
	ld [wPicSavedTiles], a	; save tile because... accumulators'
.setupoamloop
	ld a, d
	ld [hli], a		; load entry's Y position
	ld a, e
	ld [hli], a		; load entry's X position
	ld a, [wPicSavedTiles]
	ld [hli],a		; load the correct tile
	xor a
	ld [hli],a		; finally, load the entry's flags
	ld a, e			; we're gonna do the next entry, so
	add 8			; add 8 to the
	ld e, a			; X position.
	ld a, [wPicSavedTiles]	; also, we're gonna move to the
	inc a			; next tile
	ld [wPicSavedTiles], a
	dec b
	jr nz, .setupoamloop	; keep putting tiles until current row is done
	ld a, d			; do the next row, so
	add 8			; we add 8 to the
	ld d, a			; Y position.
	ld b, 6			; reinitialize column count
	ld e, $e0		; reinitialize starting X position
	dec c			; reserve for next row
	jr nz, .setupoamloop	; keep putting tiles until all rows are done
				; We're done setting up OAM. Now for the animation...
	ld b, 16		; how many pixels / 4 should we scroll?
	call BattleTransition_ShowPic_ScrollOAM		; scroll OAM

BattleTransition_ShowPic_PrintText:
	ld de, FontGraphics
	ld hl, vFont
	ld bc, BANK(FontGraphics) << 8 | $7f
	call CopyVideoData	; load the character set minus the number "9"
				; because it is used as a blank tile
	hlCoord 0, 11
	ld de, W_TRAINERNAME
	call PlaceString	; Trainer name
	ld a, [W_CUROPPONENT]
	cp SONY3 + $C8
	jr nz, .skiprematch	; if not Theta
	ld a, [wBeatenChamp]
	bit 0, a
	jr z, .skiprematch
	hlCoord 0, 9
	ld de, BattleTransition_RematchText
	call PlaceString	; "REMATCH!"
.skiprematch
	ld c, 90
	call DelayFrames	; wait 1,5 seconds
	
	hlCoord 0, 11		; clear the string for the outro
	ld c, 10
.clearstring
	ld a, $7f
	ld [hli], a
	dec c
	ld a, c
	and a
	jr nz, .clearstring
	
	hlCoord 0, 9
	ld c, 10
.clearstring2
	ld a, $7f
	ld [hli], a
	dec c
	ld a, c
	and a
	jr nz, .clearstring2
	
	xor a
	ld [wPicSavedTiles], a	; clear out our RAM location, just because.
	ld b, 9			; how many pixels / 4 should we scroll?
	call BattleTransition_ShowPic_ScrollOAM		; scroll OAM
	jp GBFadeOutToBlack	; we're finally done here, let the battle core
				; do the next job

BattleTransition_ShowPic_ScrollOAM:
	ld c, 2
	call DelayFrames	; delay 2 frames
	ld c, 6*6		; how many tiles would we like to scroll?
	ld hl, wOAMBuffer + 1	; make sure that we load to OAM entry's X position
.loop
	ld a, [hl]
	add 8			; add 12 to X position
	ld [hl], a
	inc hl			; move to next entry
	inc hl			; an OAM entry is 4 bytes long
	inc hl
	inc hl
	dec c
	jr nz, .loop		; keep messing with OAM until we're finished
				; moving the whole pic
	dec b
	jr nz, BattleTransition_ShowPic_ScrollOAM		; keep scrolling until we finish the counter
	ret			; done

BattleTransition_RematchText: db "REMATCH!@"

BattleTransition_LumiPic:
	INCBIN "gfx/battlepics/placeholder.2bpp"
	
BattleTransition_ThetaPic:
	INCBIN "gfx/battlepics/theta.2bpp"