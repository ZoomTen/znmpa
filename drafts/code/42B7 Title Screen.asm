include "PkRedDefs.asm"

Start0 equ $42B7
SECTION "ROM", HOME[0]
;--------------------------------------------------------------
;$42B7 : Write a blank, new title screen
CLS_LoadText:
        call $190f
        ld b,$4     ;pal
        call $3DEF
LoadTiles:
         ;Title screen
         ld hl,$5380 ;ptr
         ld de,$8800 ;dest
         ld bc,$550 ;length
         ld a,$4  ;bank
         call $17F7
         ;Numbers 0-9
         ld hl,$5E30 ;ptr
         ld de,$8F60 ;dest
         ld bc,$50 ;length
         ld a,$4  ;bank
         call $182B
PlayMusic:
        ld c,$1F
        ld a,$C3
        call $23A1
DrawTitle:
        ;--titlemap--
        ld hl,$C3A0 + $2C
        ld de,TitleTMap1 + Start0
        call $1955
        ;--"POKEMON ADVENTURES"--
        ld hl,$C3A0 + $CE
        ld de,Title_Text1 + Start0
        call $1955
        ld hl,$C3A0 + $E1
        ld de,Title_Text2 + Start0
        call $1955
        ld hl,$C3A0 + $F8
        ld de,Title_BetaText + Start0
        call $1955
        ;--press start--
        ld hl,$C3A0 + $11F
        ld de,Title_Prestart + Start0
        call $1955
        call $6288
CheckForControls:
        call $3831
        ld a, [$FFB5]
        and a, %00001011 ;A, B, Start
        jp z, CheckForControls + Start0
ClickJump:
        ld a,$90
        call $23B1
        jp $5AF2 ; main menu

;Title map
TitleTMap1:
        incbin "B716_TITLE.tmap"
        db $50
Title_Text1:
db $C0, $C1, $C2, $C3, $C4, $C1, $C5, $50
Title_Text2:
db $C6, $C7, $C8, $C9, $C5, $CA, $CB, $CC, $C9, $CD, $50
Title_BetaText:
db $D4
db _0, _0, _1
db $50
Title_Prestart:
db $CE, $CF, $D0, $D1, $D2, $D3, $50

;--------------------------------------------------------------
db "=5B89="
;repointing title...
        jp nz, PlayMusic + Start0