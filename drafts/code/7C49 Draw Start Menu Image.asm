include "PkRedDefs.asm"

Start3 equ $7C49
SECTION "ROM", HOME[0]
;--------------------------------------------------------------
;$7C49 : load gfx + map of drawing in start menu
;GFX : $1AF20

        call $3DE5

LoadGFX1st:
        ld de,$6F20 ;ptr
        ld hl,$8C00 ;vram
        ld bc,$0620 ;bank 6, size 0x20
        call $1848

LoadGFX2nd:
        ld de,$7120
        ld hl,$9600
        ld bc,$0619
        call $1848
        
LoadPal:
        ld b,$04     ;pal
        call $3DEF

LoadBox:
        ld hl,$C3A0 + 20
        ld bc,$0707
        call $1922

LoadText:
        ld hl,$C3A0 + (20 * 3) + 2
        ld de,DemoTxt + Start3
        call $1955
        ld hl,$C3A0 + (20 * 5) + 2
        ld de,DateTxt + Start3
        call $1955
        ld hl,$C3A0 + (20 * 7) + 2
        ld de,VersionTxt + Start3
        call $1955
        ld a,$78
        ld [$C3A0 + (20*10) + 8],a

DrawChara:
        ld hl,$C3A0 + (20 * 11) + 1
        ld de,TitleMap00 + Start3
        call $1955
        ld hl,$C3A0 + (20 * 12) + 1
        ld de,TitleMap01 + Start3
        call $1955
        ld hl,$C3A0 + (20 * 13) + 1
        ld de,TitleMap02 + Start3
        call $1955
        ld hl,$C3A0 + (20 * 14) + 1
        ld de,TitleMap03 + Start3
        call $1955
        ld hl,$C3A0 + (20 * 15) + 1
        ld de,TitleMap04 + Start3
        call $1955
        ld hl,$C3A0 + (20 * 16) + 1
        ld de,TitleMap05 + Start3
        call $1955
        ld hl,$C3A0 + (20 * 17) + 1
        ld de,TitleMap06 + Start3
        call $1955
        
        call $3DDC

        ret

TitleMap00:
db $C0,$C1,$C2,$C3,$C4,$C5,$C6,$C7,$50
TitleMap01:
db $C8,$C9,$CA,$CB,$CC,$CD,$CE,$CF,$50
TitleMap02:
db $D0,$D1,$D2,$D3,$D4,$D5,$D6,$D7,$50
TitleMap03:
db $D8,$D9,$DA,$DB,$DC,$DD,$DE,$DF,$50
TitleMap04:
db $60,$61,$62,$63,$64,$65,$66,$67,$50
TitleMap05:
db $68,$69,$6A,$6B,$6C,$6D,$6E,$6F,$50
TitleMap06:
db $70,$71,$72,$73,$74,$75,$76,$77,$50

DemoTxt:
db _B,_e,_t,_a,$50
DateTxt:
db _0,_5,$E3,_0,_5,$50
VersionTxt:
db _v,$E8,_0,_0,_8,$50
