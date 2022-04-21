_BattleTransition_WhiteOut:
; don't hide legs
	ld a, [wOAMBuffer+11]
	res 7, a
	ld [wOAMBuffer+11], a
	
	ld a, [wOAMBuffer+15]
	res 7, a
	ld [wOAMBuffer+15], a
	
	ld a,1
	ld [H_AUTOBGTRANSFERENABLED],a	; enable auto background transfer
	ld d, 3				; how many times to run routine
	hlCoord 0,0			; start at beginning

_BattleTransition_WhiteOut_Main:
	call Delay3
	push hl
	call _BattleTransition_WhiteOut_LoopTransition
	pop hl
	dec d
	jr z, .done
	ld e, 20
.movetonextrow
	inc hl
	dec e
	jr nz, .movetonextrow
	jr _BattleTransition_WhiteOut_Main
.done
	call GBFadeOutToWhite
	ret

_BattleTransition_WhiteOut_LoopTransition:
	ld b, 6				; row count
	ld c, 20			; initialize column count
.loop
	ld a, " "			; load blank tile
	ld [hli], a
	dec c
	jr nz, .loop			; if we're not done with column then keep going
	dec b
	ret z				; if we're done with the whole process then return
	ld e, $28
.move2rows
	inc hl
	dec e
	jr nz, .move2rows
	ld c, 20			; reinitialize column count
	jr .loop