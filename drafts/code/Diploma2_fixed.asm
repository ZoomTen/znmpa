include "PkRedDefs.asm"
Start    equ $566E2
;--------------------------------------------------
SECTION "ROM", HOME[0]
ClearScreen:
            call $36F4 ; copy background from $C3A0 to $CD81
            call $3DD4
            call $190F
            xor a
            ld [$CFCB], a
            ld hl, $D730
            set 6,[hl] ; turn off letter printing delay

Diploma_DrawSet:
            ld hl, $7D88
            ld de, $9700
            ld bc, $0010
            ld a, $B
            call $17F7

Diploma_DrawMap:
            ld hl, $C3A0
            ld bc, $1012
            ld a, $27   ;$01:$5AB0
            call $3E6D
            ld hl, DiplomaPtrs6784 + Start
            ld c,$5
            
DiplomaSub6715:
            push bc
            ld a,[hli]
            ld e,a
            ld a,[hli]
            ld d,a
            ld a,[hli]
            push hl
            ld h,[hl]
            ld l,a
            call $1955
            pop hl
            inc hl
            pop bc
            dec c
            jr nz DiplomaSub6715 + Start
            
DiplomaSub6727:
            ld hl,$C3FA
            ld de,$D158
            call $1955
            ld b,$01
            ld hl,$44DD
            call $35D6
            ld hl,$C301
            ld bc,$8028
            
DiplomaSub673E:
            ld a,[hl]
            add a,$21
            ld [hli],a
            inc hl
            ld a,b
            ld [hli],a
            inc hl
            dec c
            jr nz DiplomaSub673E + Start
            
DiplomaSub6749:
            call $007B
            ld b,$01
            ld hl,$5AE6
            call $35D6
            ld b,$08
            call $3DEF
            call $3DBE
            call $3DD7
            jp $3DDC
            
DiplomaSub6777:
            ld hl,$D158
            ld bc,$FF00
            
DiplomaSub677D:
            ld a,[hli]
            cp a,$50
            ret z
            dec c
            jr DiplomaSub677D + Start
            
DiplomaPtrs6784:
; <text ptr> <screen pos>
            dw DiplomaText6798 + Start
            dw $C3CD
            
            dw DiplomaText67A2 + Start
            dw $C3F3
            
            dw DiplomaText67A9 + Start
            dw $C3FF
            
            dw DiplomaText67AA + Start
            dw $C41A
            
            dw DiplomaText67EE + Start
            dw $C4E9

DiplomaText6798:
db $70, _D, _i, _p, _l, _o, _m, _a, $70, $50

DiplomaText67A2:
db _P, _l, _a, _y, _e, _r, $50

DiplomaText67A9:
db $50

DiplomaText67AA:
db _C, _o, _n, _g, _r, _a, _t, _s, _!, SPACE, _T, _h, _i, _s, $4E
db _d, _i, _p, _l, _o, _m, _a, SPACE, _c, _e, _r, _t, _i, _f, _i, _e, _s $4E
db _t, _h, _a, _t, SPACE, _y, _o, _u, SPACE, _h, _a, _v, _e, $4E
db _c, _o, _m, _p, _l, _e, _t, _e, _d, SPACE, _y, _o, _u, _r, $4E
db _POKE, _D, _E, _X, DOT, $50

DiplomaText67EE:
db _G, _A, _M, _E, SPACE, _F, _R, _E, _A ,_K, $50
