BattleTransition_ShiftScreen:		; kind of gen 3 styled battle transition?
; don't hide legs
	ld a, [wOAMBuffer+11]
	res 7, a
	ld [wOAMBuffer+11], a
	
	ld a, [wOAMBuffer+15]
	res 7, a
	ld [wOAMBuffer+15], a
	
	ld a,1
	ld [H_AUTOBGTRANSFERENABLED],a ; enable auto background transfer
; set the counter
	ld a, 32
	ld [wTempBattleSplitCounter], a
	
BattleTransition_WildTest_Loop:
	call DelayFrame
	ld hl, wTileMap
	ld b, 9			; how many rows / 2 to scroll
	
BattleTransition_WildTest_ScrollLoop:
	ld c, 19		; how many columns to scroll
	ld a, $FF
	ld [hli],a		; blank out the first tile and get the next tile
.moveleft
	ld a, [hl]		; fetch that tile
	dec hl
	ld [hli],a		; move it to the previous row
	inc hl			; next tile
	dec c			; column done.
	jr nz, .moveleft	; shift the row until all characters are done
	ld a, $FF		; finish up by writing a space
	dec hl			; on the very last tile
	ld [hl], a

	xor a
	ld d, a
	ld e, 20
	add hl, de		; move to the next row
	
	ld c, 19		; reinitialize column count
	ld a, $FF		; here on it's basically the same thing, only in reverse
	ld [hld], a
.moveright
	ld a, [hl]
	inc hl
	ld [hld], a
	dec hl
	dec c
	jr nz, .moveright
	ld a, $FF
	inc hl
	ld [hl], a
	
	dec b			; once we finish moving 2 rows, go to the next 2 rows
	jr z, BattleTransition_WildTest_Continue	; if we've finished
	
	xor a			; else, run the loop again
	ld d, a
	ld e, 20
	add hl, de
	jr BattleTransition_WildTest_ScrollLoop
	
BattleTransition_WildTest_Continue:
	ld a, [wTempBattleSplitCounter]		; load counter
	dec a
	ld [wTempBattleSplitCounter], a
	jr nz, BattleTransition_WildTest_Loop	; if it's not zero run the whole thing again
	ld a, $ff				; blank out the whole palette
	ld [rBGP], a
	ld [rOBP0], a
	ld [rOBP1], a
	ret