Route2Script: ; 554e3 (15:54e3)
	runscripts W_ROUTE2CURSCRIPT, Route2ScriptPointers
	jp EnableAutoTextBoxDrawing

Route2ScriptPointers:
	dw Route2Script0
	dw Route2Script1
	dw Route2Script2
	dw Route2Script3

Route2Script0:
	testcoordinates 3, 11
	loadsprite1 $60, MochaSprite
	playmusicid Mus_MeetFemaleTrainer
	showobject HS_ROUTE_2_MOCHA
	showemote 3, 0
	messageid 5
	setbattle MOCHA, 1, Route2MochaEndBattle
	hideobject HS_ROUTE_2_MOCHA	; tricky shit
	changescript 1, W_ROUTE2CURSCRIPT
	ret
	
Route2Script1:
	loadsprite1 $60, MochaSprite
	showobject HS_ROUTE_2_MOCHA	; tricky shit
	predef HealParty
	messageid 6
	loadsprite2 $60, MochaSprite	; load walking sprites
	selectsprite 3			; mocha
	domovement .MochaExitMovement
	changescript 2, W_ROUTE2CURSCRIPT
	ret
	
.MochaExitMovement
	db Up, Right, Right, Right, Right, Right, Up, Up
	db End
	
Route2Script2:
	testflag 0, wd730
	jr z, .freedpad		; stop ignoring input?
	lock
	ret
.freedpad
	release
; reload one of the sprites
	hideobject HS_ROUTE_2_MOCHA
	loadsprite1 $60, LassSprite
	loadsprite2 $60, LassSprite
	changescript 3, W_ROUTE2CURSCRIPT
	ret
	
Route2Script3:
	ret
	
Route2TextPointers: ; 554e6 (15:54e6)
	dw Predef5CText;1?
	dw Predef5CText;2
	dw Route2Text3 ;3
	dw Route2Text4 ;4
	dw MochaText1
	dw MochaText2
	dw Route2Text3 ;7

Route2Text3: ; 554ee (15:54ee)
	TX_FAR _Route2Text3
	db "@"

Route2Text4: ; 554f3 (15:54f3)
	TX_FAR _Route2Text4
	db "@"
	
MochaText1:
	TX_FAR _MochaText1
	db "@"
	
MochaText2:
	TX_FAR _MochaText2
	db "@"

Route2MochaEndBattle:
	TX_FAR _Route2MochaEndBattle
	db "@"