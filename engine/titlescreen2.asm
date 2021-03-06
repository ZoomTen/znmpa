TitleScroll_WaitBall: ; 37244 (d:7244)
; Wait around for the TitleBall animation to play out.
; hi: speed
; lo: duration
	db $05, $05, 0

TitleScroll_In: ; 37247 (d:7247)
; Scroll a TitleMon in from the right.
; hi: speed
; lo: duration
	db $a2, $94, $84, $63, $52, $31, $11, 0

TitleScroll_Out: ; 3724f (d:724f)
; Scroll a TitleMon out to the left.
; hi: speed
; lo: duration
	db $12, $22, $32, $42, $52, $62, $83, $93, 0

TitleScroll: ; 37258 (d:7258)
	ld a, d

	ld bc, TitleScroll_In	; load scroll-in table
	ld d, $88		; scx start value
	ld e, 0			; don't animate titleball

	and a
	jr nz, .ok

	ld bc, TitleScroll_Out	; load scroll-out table
	ld d, $00		; scx start value
	ld e, 0 		; don't animate titleball
.ok

_TitleScroll: ; 3726a (d:726a)
	ld a, [bc]
	and a
	ret z			; if table ends then stop

	inc bc
	push bc

	ld b, a
	and $f
	ld c, a
	ld a, b
	and $f0
	swap a
	ld b, a			; loop c times, incrementing SCX by b pixels each time

.loop
	ld h, d
	ld l, $48
	call .ScrollBetween

	ld h, $00
	ld l, $88
	call .ScrollBetween

	ld a, d
	add b
	ld d, a

	call GetTitleBallY
	dec c
	jr nz, .loop

	pop bc
	jr _TitleScroll

.ScrollBetween ; 37292 (d:7292)
.wait
	ld a, [$ff44] ; rLY
	cp l
	jr nz, .wait

	ld a, h
	ld [rSCX], a ; $ff43

.wait2
	ld a, [$ff44] ; rLY
	cp h
	jr z, .wait2
	cp l
	ret

TitleBallYTable: ; 372a0 (d:72a0)
; OBJ y-positions for the Poke Ball held by Red in the title screen.
; This is really two 0-terminated lists. Initiated with an index of 1.
	db 0, $71, $6f, $6e, $6d, $6c, $6d, $6e, $6f, $71, $74, 0

Func_372ac: ; 372ac (d:72ac)
; Animate the TitleBall if a starter just got scrolled out.
	ld a, [wWhichTrade] ; wWhichTrade
	cp STARTER1
	jr z, .ok
	cp STARTER2
	jr z, .ok
	cp STARTER3
	ret nz
.ok
	ld e, 1 ; animate titleball
	ld bc, TitleScroll_WaitBall
	ld d, 0
	jp _TitleScroll

GetTitleBallY: ; 372c4 (d:72c4)
; Get position e from TitleBallYTable
	push de
	push hl
	xor a
	ld d, a
	ld hl, TitleBallYTable
	add hl, de
	ld a, [hl]
	pop hl
	pop de
	and a
	ret z
	ld [wOAMBuffer + $28], a
	inc e
	ret
