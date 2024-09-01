include "PkRedDefs.asm"

Start1 equ $7158
SECTION "ROM", HOME[0]
;--------------------------------------------------------------
;$7158: Draw Start Menu
MenuItems:
	ld [$cc28],a ; number of menu items
	ld de,PKMN_Tx + Start1
	call PrintItem + Start1
	ld de,ITEM_Tx + Start1
	call PrintItem + Start1
	ld de,$d158 ; player's name
	call PrintItem + Start1
	ld de,Save_Tx + Start1
	call PrintItem + Start1
	ld de,Option_Tx + Start1
	call PrintItem + Start1
	ld de,StMenuExit_Tx + Start1
	call PrintItem + Start1
	ld de,Reset_Tx + Start1
	call $1955
	ld hl,$D730
	res 6,[hl] ; Reset text typing
	jp $7C49 ;ret

DEX_Tx:
db _POKE,_D,_E,_X,$50
PKMN_Tx:
db _POKE,_M,_O,_N,$50
ITEM_Tx:
db _P,_A,_C,_K,$50
Save_Tx:
db _S,_A,_V,_E,$50
Option_Tx:
db _O,_P,_T,_I,_O,_N,$50
StMenuExit_Tx:
db _E,_X,_I,_T,$50
Reset_Tx:
db _R,_E,_S,_E,_T,$50
PrintItem:
	push hl
	call $1955
	pop hl
	ld de,$28
	add hl,de
	ret
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop