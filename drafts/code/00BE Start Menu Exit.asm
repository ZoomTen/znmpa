include "PkRedDefs.asm"

;Start equ $BE
SECTION "ROM", HOME[$BE]
;--------------------------------------------------------------
; $00BE : Repointed exit routine
CloseMenu:
	call $19A
	ld a,[$FF00 + $B3]
	bit 0,a ; was A button newly pressed?
	jp nz,CloseMenu; + Start
	call $36A0
	ld a,[$DB00]
	ld [$CF2E],a
	jp $29E8
ClearScreen:
;clears screen
        xor a
        ld [$FFBA],a
        call $190F
        call $2429
        call $3701
        call $190F
        jp $2429