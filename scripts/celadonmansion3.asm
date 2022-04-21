CeladonMansion3Script: ; 48790 (12:4790)
	jp EnableAutoTextBoxDrawing

CeladonMansion3TextPointers: ; 48793 (12:4793)
	dw GameFreakPCText1
	dw GameFreakPCText2
	dw GameFreakSignText
	dw DirectorText
	dw GameFreakPCText1

GameFreakPCText1: ; 487eb (12:47eb)	IT'S A LINUX
	TX_FAR _PC1Text
	db "@"

GameFreakPCText2: ; 487f0 (12:47f0)	IT'S A WINDOWS
	TX_FAR _PC2Text
	db "@"

GameFreakSignText: ; 487fa (12:47fa)
	TX_FAR _CeladonMansion3Text8
	db "@"

DirectorText: ; 487b2 (12:47b2)
	db $08 ; asm
	ld a, [wBeatenChamp]
	bit 0, a
	jr nz, .CompletedGame
	ld hl, .GameDesigner
	call PrintText
	jp TextScriptEnd

.CompletedGame
	bit 1, a
	jr nz, .alreadygaveitems
	
	ld hl,ZoomyText2
	call PrintText
	
	ld a, SOUND_TEST
	call GiveSingleItem
	jr nc, .BagFull
	
	ld hl,ZoomyText2a
	call PrintText
	
	ld hl,ZoomyText3
	call PrintText
	
	ld hl,ZoomyText2c
	call PrintText
	
	ld a, BATTEM
	call GiveSingleItem
	jr nc, .BagFull
	
	ld hl,ZoomyText2b
	call PrintText
	
	ld hl,ZoomyText2d
	call PrintText
	
	ld a, [wNumBagItems]
	add 5
	cp 20
	jr nc, .dontgive
	
	ld hl,ZoomyText7
	call PrintText
	
	ld hl,ZoomyText4
	call PrintText
	
	ld b, TWINKLY
	ld c, 6
	call GiveItem
	ld a, FLOATING_ITEM
	call GiveSingleItem
	ld a, ZOMOM
	call GiveSingleItem
	ld a, ZNOZZZZ_EGG
	call GiveSingleItem
	ld a, BAGOLANDEPOFF
	call GiveSingleItem
	
.dontgive	
	ld a, [wBeatenChamp]
	set 1, a
	ld [wBeatenChamp], a
	jp TextScriptEnd
	
.alreadygaveitems
	ld hl,ZoomyText46
	call PrintText
	jp TextScriptEnd
	
.BagFull
	ld hl, ZoomyText6
	call PrintText
	jp TextScriptEnd

.GameDesigner ; 487d0 (12:47d0)
	TX_FAR _ZoomyText1
	db "@"

.CompletedGameText
	TX_FAR _ZoomyText2
	db $6
	db $8 ; asm
	callab DisplayDiploma
	jp TextScriptEnd
	
ZoomyText2:
	TX_FAR _ZoomyText2
	db "@"
	
ZoomyText2a:
	TX_FAR _PlayerreceivedSoundTest
	db $0b,$0d,"@"
	
ZoomyText2b:
	TX_FAR _PlayerreceivedBattem
	db $0b,$0d,"@"
	
ZoomyText3:
	TX_FAR _ZoomyText3
	db "@"
	
ZoomyText2c:
	TX_FAR _ZoomyText2c
	db "@"
	
ZoomyText2d:
	TX_FAR _ZoomyText2d
	db "@"
	
ZoomyText4:
	TX_FAR _PlayerreceivedJunk
	db $0b,"@"
	
ZoomyText46:
	TX_FAR _ZoomyText4
	db "@"
	
ZoomyText6:
	TX_FAR _ZoomyTextFull
	db "@"
	
ZoomyText7:
	TX_FAR _ZoomyText7
	db "@"