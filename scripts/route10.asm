Route10Script: ; 59336 (16:5336)
	call EnableAutoTextBoxDrawing
	ld hl, Route10TrainerHeaders
	ld de, Route10ScriptPointers
	ld a, [W_ROUTE10CURSCRIPT]
	call ExecuteCurMapScriptInTable
	ld [W_ROUTE10CURSCRIPT], a
	ret

Route10ScriptPointers: ; 59349 (16:5349)
	dw Route10ExecuteSubScripts
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

Route10TextPointers: ; 5934f (16:534f)
	dw Route10Text1
	dw Route10Text2
	dw Route10Text3
	dw Route10Text4
	dw Route10Text5
	dw Route10Text6
	dw Route10Text7
	dw Route10Text9
	dw Route10Text9
	dw Route10Text10
	dw Route10Text11
	dw Route10Text12
	dw Route10Text13
	dw Route10Text14
	dw PokeCenterSignText

Route10TrainerHeaders: ; 59363 (16:5363)
Route10TrainerHeader0: ; 59363 (16:5363)
	db $1 ; flag's bit
	db ($4 << 4) ; trainer's view range
	dw wd7d1 ; flag's byte
	dw Route10BattleText1 ; 0x53b6 TextBeforeBattle
	dw Route10AfterBattleText1 ; 0x53c0 TextAfterBattle
	dw Route10EndBattleText1 ; 0x53bb TextEndBattle
	dw Route10EndBattleText1 ; 0x53bb TextEndBattle

Route10TrainerHeader1: ; 5936f (16:536f)
	db $2 ; flag's bit
	db ($3 << 4) ; trainer's view range
	dw wd7d1 ; flag's byte
	dw Route10BattleText2 ; 0x53cf TextBeforeBattle
	dw Route10AfterBattleText2 ; 0x53d9 TextAfterBattle
	dw Route10EndBattleText2 ; 0x53d4 TextEndBattle
	dw Route10EndBattleText2 ; 0x53d4 TextEndBattle

Route10TrainerHeader2: ; 5937b (16:537b)
	db $3 ; flag's bit
	db ($4 << 4) ; trainer's view range
	dw wd7d1 ; flag's byte
	dw Route10BattleText3 ; 0x53e8 TextBeforeBattle
	dw Route10AfterBattleText3 ; 0x53f2 TextAfterBattle
	dw Route10EndBattleText3 ; 0x53ed TextEndBattle
	dw Route10EndBattleText3 ; 0x53ed TextEndBattle

Route10TrainerHeader3: ; 59387 (16:5387)
	db $4 ; flag's bit
	db ($3 << 4) ; trainer's view range
	dw wd7d1 ; flag's byte
	dw Route10BattleText4 ; 0x5401 TextBeforeBattle
	dw Route10AfterBattleText4 ; 0x540b TextAfterBattle
	dw Route10EndBattleText4 ; 0x5406 TextEndBattle
	dw Route10EndBattleText4 ; 0x5406 TextEndBattle

Route10TrainerHeader4: ; 59393 (16:5393)
	db $5 ; flag's bit
	db ($2 << 4) ; trainer's view range
	dw wd7d1 ; flag's byte
	dw Route10BattleText5 ; 0x541a TextBeforeBattle
	dw Route10AfterBattleText5 ; 0x5424 TextAfterBattle
	dw Route10EndBattleText5 ; 0x541f TextEndBattle
	dw Route10EndBattleText5 ; 0x541f TextEndBattle

Route10TrainerHeader5: ; 5939f (16:539f)
	db $6 ; flag's bit
	db ($2 << 4) ; trainer's view range
	dw wd7d1 ; flag's byte
	dw Route10BattleText6 ; 0x5433 TextBeforeBattle
	dw Route10AfterBattleText6 ; 0x543d TextAfterBattle
	dw Route10EndBattleText6 ; 0x5438 TextEndBattle
	dw Route10EndBattleText6 ; 0x5438 TextEndBattle
	
Route10TrainerHeader6: ; 5939f (16:539f)
	db $7 ; flag's bit
	db ($4 << 5) ; trainer's view range
	dw wd7d1 ; flag's byte
	dw Route10BattleText7 ; 0x5433 TextBeforeBattle
	dw Route10AfterBattleText7 ; 0x543d TextAfterBattle
	dw Route10EndBattleText7 ; 0x5438 TextEndBattle
	dw Route10EndBattleText7 ; 0x5438 TextEndBattle

	db $ff

Route10Text1: ; 593ac (16:53ac)
	db $08 ; asm
	ld hl, Route10TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

Route10BattleText1: ; 593b6 (16:53b6)
	TX_FAR _Route10BattleText1
	db "@"

Route10EndBattleText1: ; 593bb (16:53bb)
	TX_FAR _Route10EndBattleText1
	db "@"

Route10AfterBattleText1: ; 593c0 (16:53c0)
	TX_FAR _Route10AfterBattleText1
	db "@"

Route10Text2: ; 593c5 (16:53c5)
	db $08 ; asm
	ld hl, Route10TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

Route10BattleText2: ; 593cf (16:53cf)
	TX_FAR _Route10BattleText2
	db "@"

Route10EndBattleText2: ; 593d4 (16:53d4)
	TX_FAR _Route10EndBattleText2
	db "@"

Route10AfterBattleText2: ; 593d9 (16:53d9)
	TX_FAR _Route10AfterBattleText2
	db "@"

Route10Text3: ; 593de (16:53de)
	db $08 ; asm
	ld hl, Route10TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

Route10BattleText3: ; 593e8 (16:53e8)
	TX_FAR _Route10BattleText3
	db "@"

Route10EndBattleText3: ; 593ed (16:53ed)
	TX_FAR _Route10EndBattleText3
	db "@"

Route10AfterBattleText3: ; 593f2 (16:53f2)
	TX_FAR _Route10AfterBattleText3
	db "@"

Route10Text4: ; 593f7 (16:53f7)
	db $08 ; asm
	ld hl, Route10TrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

Route10BattleText4: ; 59401 (16:5401)
	TX_FAR _Route10BattleText4
	db "@"

Route10EndBattleText4: ; 59406 (16:5406)
	TX_FAR _Route10EndBattleText4
	db "@"

Route10AfterBattleText4: ; 5940b (16:540b)
	TX_FAR _Route10AfterBattleText4
	db "@"

Route10Text5: ; 59410 (16:5410)
	db $08 ; asm
	ld hl, Route10TrainerHeader4
	call TalkToTrainer
	jp TextScriptEnd

Route10BattleText5: ; 5941a (16:541a)
	TX_FAR _Route10BattleText5
	db "@"

Route10EndBattleText5: ; 5941f (16:541f)
	TX_FAR _Route10EndBattleText5
	db "@"

Route10AfterBattleText5: ; 59424 (16:5424)
	TX_FAR _Route10AfterBattleText5
	db "@"

Route10Text6: ; 59429 (16:5429)
	db $08 ; asm
	ld hl, Route10TrainerHeader5
	call TalkToTrainer
	jp TextScriptEnd

Route10BattleText6: ; 59433 (16:5433)
	TX_FAR _Route10BattleText6
	db "@"

Route10EndBattleText6: ; 59438 (16:5438)
	TX_FAR _Route10EndBattleText6
	db "@"

Route10AfterBattleText6: ; 5943d (16:543d)
	TX_FAR _Route10AfterBattleText6
	db "@"
	
Route10Text7: ; 59429 (16:5429)
	db $08 ; asm
	ld hl, Route10TrainerHeader6
	call TalkToTrainer
	jp TextScriptEnd

Route10BattleText7: ; 59433 (16:5433)
	TX_FAR _Route10BattleText7
	db "@"

Route10EndBattleText7: ; 59438 (16:5438)
	TX_FAR _Route10EndBattleText7
	db "@"

Route10AfterBattleText7: ; 5943d (16:543d)
	TX_FAR _Route10AfterBattleText7
	db "@"


Route10Text9: ; 59442 (16:5442)
Route10Text14: ; 59442 (16:5442)
	TX_FAR _Route10Text7 ; _Route10Text9
	db "@"

Route10Text10: ; 59447 (16:5447)
	TX_FAR _Route10Text10
	db "@"

Route10Text11:
	TX_FAR _Route10Text11
	db "@"
	
Route10Text12:
	TX_FAR _Route10Text12
	db "@"

TronSilvumiAfterBattle:
	TX_FAR _Route10TronEndBattle
	db "@"
	
Route10Text13:
	TX_FAR _Route10Text13
	db "@"
	
Route10ExecuteSubScripts:
	ld a,[W_ROUTE10_SUBSCRIPT]
	and a
	jp z, .routine0
	dec a
	jp z, .routine1
	inc a
	cp 2
	jp z, .routine2
	cp 3
	jp z, .routine3
	cp 4
	jp z, .routine4
	cp 5
	jp z, .routine5
	changescript 1, W_CURMAPSCRIPT
	ret
.routine0		; move Lumi
	call Route10HideTronSilvumi
	testcoordsarray .scripttriggers
	playmusicid Mus_MeetFemaleTrainer
	messageid 11
	showemote 0,0
	call Route10ShowTronSilvumi
	call Route10ReloadTronSprites
	selectsprite 8
	fetchcoordsindex
	ld [wTempIndexNo], a
	call .calldomovement
	changescript 1, W_ROUTE10_SUBSCRIPT
	ret
.scripttriggers:
	db $08, 00
	db $09, 00
	db $ff
.lumientertop
	db Left, Left, Left, Up, Left, Left
	db End
.lumienterbottom
	db Left, Left, Left, Left, Left
	db End
.routine1		; move Tron
	delay 8
	selectsprite 9
	fetchcoordsindex
	call .calldomovement
	changescript 2, W_ROUTE10_SUBSCRIPT
	ret
.routine2
; control script
	testflag 0, wd730
	jr z, .continue
	lock
	ret
.continue
	release
	call .callupdatespritedirections
	call SetSpriteFacingDirectionAndDelay
; initiate battle
	messageid 12
	call Route10HideTronSilvumi
	setbattle TRON_SILVUMI, 1, TronSilvumiAfterBattle
	changescript 3, W_ROUTE10_SUBSCRIPT
	ret
.routine3
	ld a, [wBattleResult]
	dec a
	jr nz, .win
	changescript 0, W_ROUTE10_SUBSCRIPT
	ret
.win
	call Route10ReloadTronSprites
	call Route10ShowTronSilvumi
	call .callupdatespritedirections
	messageid 13
	call Route10ReloadTronSprites
	selectsprite 8
	ld a, [wTempIndexNo]
	call .calldomovement2
	changescript 4, W_ROUTE10_SUBSCRIPT
	ret
	
.routine4
	delay 8
	selectsprite 9
	ld a, [wTempIndexNo]
	call .calldomovement2
	changescript 5, W_ROUTE10_SUBSCRIPT
	ret
	
.routine5
; control script
	testflag 0, wd730
	jr z, .continue5
	lock
	ret
.continue5
	release
	call Route10HideTronSilvumi
	xor a
	ld [W_SPRITESETID], a
	call DisableLCD		; prevent glitches
	callba InitMapSprites
	call EnableLCD
	changescript $FF, W_ROUTE10_SUBSCRIPT
	ret
	
.lumiouttop
	db Down, Left, Left, Left, Left, Left, Left, Left
	db End
.lumioutbottom
	db Up, Left, Left, Left, Left, Left, Left, Left
	db End
	
.calldomovement
	dec a
	jr z, .top
	inc a
	domovement .lumienterbottom
	jr .done
.top
	domovement .lumientertop
.done
	ret
	
.calldomovement2
	dec a
	jr z, .top2
	inc a
	domovement .lumioutbottom
	jr .done2
.top2
	domovement .lumiouttop
.done2
	ret
	
.callupdatespritedirections
	selectsprite 0
	facesprite SPRITE_FACING_RIGHT
	selectsprite 8
	facesprite SPRITE_FACING_LEFT
	selectsprite 9
	jp SetSpriteFacingDirectionAndDelay
	
Route10HideTronSilvumi:
	hideobject HS_ROUTE10_LUMI
	hideobject HS_ROUTE10_TRON
	ret
	
Route10ShowTronSilvumi:
	showobject HS_ROUTE10_LUMI
	showobject HS_ROUTE10_TRON
	ret
	
Route10ReloadTronSprites:
; tron
	loadsprite1 $18, JinxSprite
	loadsprite2 $18, JinxSprite
; lumi
	loadsprite1 $60, LumiSprite
	loadsprite2 $60, LumiSprite
	ret
	