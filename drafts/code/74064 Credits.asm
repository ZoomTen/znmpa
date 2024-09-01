include "PkRedDefs.asm"
ORI equ $74064

SECTION "Credits", HOME[0]

InitCredits:
     call $190F	;Clear screen
;     ld c,$64	;Delay 100 frames (1.6 sec)
;     call $3739
     call $0061
     ld hl,$97E0	;address (VRAM)
     ld bc,$10	;length
     ld a,$FF	;fill with FF
     call $36E0       ;do fill
     ld hl,$C3A0	    ;load top black bar
     call LoadBlackBar
     ld hl,$C4B8      ;load bottom black bar
     call LoadBlackBar
     ld a,$C0
     ld [$FF00 + $47],a
     call $007B
     ld a,$FF	;stop sound
     call $3740
     ld c,$1F	;play credits music
     ld a,$C7
     call $23A1

     ld c,$04
     ld hl,CredPoi1
ScrollCredits:
     ld de,$C418
     call $1955
     ld c,64
     call $3739
     call ClearScreenArea
     dec c
     ld c,a
     cp 0
     jp z, TheEnd
     inc l
     inc l
     jp ScrollCredits
     
TheEnd:
     call $190F
     ld c,$64
     call $3739
     jp $150

;subs
LoadBlackBar:
     ld bc,$50
     ld a,$7E
     jp $36E0
ClearScreenArea:
     ld hl,$C3F0
     ld bc,$C8
     ld a,$7F
     jp $36E0
     
CredPoi1:
dw Text01
dw Text02
dw Text03
dw Text04
dw Text05

Text01:
db _C, _R, _E, _D, _I, _T, _S
db $50

Text02:
db _C,_R,_E,_D,_I,_T,SPACE,_0,_1,SPACE
db _G,_O,_E,_S,SPACE,_H,_E,_R,_E
db $50

Text03:
db _C,_R,_E,_D,_I,_T,SPACE,_0,_2,SPACE
db _G,_O,_E,_S,SPACE,_H,_E,_R,_E
db $50

Text04:
db _C,_R,_E,_D,_I,_T,SPACE,_0,_3,SPACE
db _G,_O,_E,_S,SPACE,_H,_E,_R,_E
db $50

Text05:
db _C,_R,_E,_D,_I,_T,SPACE,_0,_4,SPACE
db _G,_O,_E,_S,SPACE,_H,_E,_R,_E
db $50