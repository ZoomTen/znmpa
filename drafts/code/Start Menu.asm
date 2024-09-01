include "PkRedDefs.asm"

SECTION "ROM", HOME[0]
;--------------------------------------------------------------
db "$135E3:"
; $135E3
;
; edit function that
; saves/resets the game
;
        call $190F
        call $2429 ;saves screen
	ld a,$3F
	call $3E6D ; predef that saves the game
	call $3701 ; restore saved screen
	jp $29DF
; make space
	nop
	nop
;--------------------------------------------------------------
db "$2ACD:"
; $2ACD
;
; rewrite the start of
; start menu code
;
; so that it cls first
;
	ld a,$04
	ld [$ffb8],a
	ld [$2000],a ; Bankswitch..
	call $CD ;ClearScreen
	nop
	nop
	nop
;--------------------------------------------------------------
db "$2B0B:"
; $2B0B
;
; make way for items
;
	ld a,7
	db $20,1 ;jr nz, $2B10
	dec a
 ;--------------------------------------------------------------
db "$2B21:"
; $2B21
       nop
       nop
       nop
 ;--------------------------------------------------------------
db "$2B70:"
; $2B70
;
; add more pointers
;
	cp a,6
	jp z,$BE ;CloseMenu
	cp a,7
	jp z,$150 ;resets game
;--------------------------------------------------------------
db "$08DE:"
; $08DE
; change fade in color
        call $20D8

;$20E6, $2104 :
;0E 04  | ld c, $04
;smoother fades
;--------------------------------------------------------------
db "$00CD:"
; $00CD
; clear a screen
        xor a
        ld [$FFBA],a
        call $190F
        call $2429
        call $3701
        call $190F
        jp $2429
        ld a,$8f ; Start menu sound
	call $23B1