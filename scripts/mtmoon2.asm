MtMoon2Script: ; 51a42 (14:5a42)
	enabletextscripts
	runscripts W_MTMOON2CURSCRIPT, MtMoon2ScriptPointers
	ret

MtMoon2ScriptPointers:
	dw MtMoon2Script0
	dw MtMoon2Script1
	dw MtMoon2Script2
	dw MtMoon2Script3
	dw MtMoon2Script4
	dw MtMoon2Script5
	
MtMoon2TextPointers: ; 51a46 (14:5a46)
	dw MtMoonText1
	dw MochaMtMoonText1
	dw MochaMtMoonText2
	dw MochaMtMoonText3

MtMoonText1: ; 51a48 (14:5a48)
	TX_FAR _MtMoonText1
	db "@"

MochaMtMoonText1:
	TX_FAR _MochaMtMoonText1
	db "@"
	
MochaMtMoonText2:
	TX_FAR _MochaMtMoonText2
	db "@"
	
MochaMtMoonText3:
	TX_FAR _MochaMtMoonText3
	db "@"
	
MtMoonMochaEndBattle:
	TX_FAR _MtMoonMochaEndBattle
	db "@"
	
MtMoon2Script0:
	hideobject HS_MTMOON2_MOCHA
; if player is at script's position
	ld a, [W_YCOORD]
	cp 7
	ret nz
	ld a, [W_XCOORD]
	cp 5 + 1
	ret nc
	playmusicid Mus_MeetFemaleTrainer
	messageid 2
	showemote 0,0
	showobject HS_MTMOON2_MOCHA
	selectsprite 1
; check if player is at left of map
	ld a, [W_XCOORD]
	cp 4
	jr z, .left
; do Mocha's movement
	ld de, .MochaEnters + 1
	jr .movemocha
.left
	ld de, .MochaEnters
.movemocha
	call MoveSprite
; switch to next script
	changescript 1, W_MTMOON2CURSCRIPT
	ret
	
.MochaEnters:
	db Up, Up, Up, Up, Up, Up
	db End
	
MtMoon2Script1:
	testflag 0, wd730
	jr z, .freedpad
	lock
	ret
.freedpad
	release
; continue here
; check player's position
	ld a, [W_XCOORD]
	cp 4
	jr nz, .dontfaceleft
	selectsprite 1
	facesprite SPRITE_FACING_LEFT
.dontfaceleft
	messageid 3
	setbattle MOCHA, 2, MtMoonMochaEndBattle
	changescript 2, W_MTMOON2CURSCRIPT
	ret
	
MtMoon2Script2:
; test battle result
	ld a, [wBattleResult]
	and a
	jr nz, .iflose
; if won battle
	ld a, [W_XCOORD]
	cp 4
	jr nz, .facefront
; face left if player is on left side
	selectsprite 0			; zilo
	facesprite SPRITE_FACING_RIGHT
	selectsprite 1			; mocha
	facesprite SPRITE_FACING_LEFT
	jr .continue
.facefront
	selectsprite 0			; zilo
	facesprite SPRITE_FACING_DOWN
	selectsprite 1			; mocha
	facesprite SPRITE_FACING_UP
.continue
	messageid 4
	changescript 3, W_MTMOON2CURSCRIPT
	ret
.iflose
; reset script
	changescript 0, W_MTMOON2CURSCRIPT
	ret
	
MtMoon2Script3:
; initialize sprite movements (1 = Mocha)
	selectsprite 1
; check for left position
	ld a, [W_XCOORD]
	cp 4
	jr z, .left
; if right
	ld de, .MochaOut1
	jr .movemocha
.left
	ld de, .MochaOut2
.movemocha
	call MoveSprite
	changescript 4, W_MTMOON2CURSCRIPT
	ret
	
.MochaOut1:
	db Left, Up, Up, Right, Up
	db End
.MochaOut2:
	db Up, Up
	db End
	
MtMoon2Script4:
	testflag 0, wd730
	jr z, .freedpad
	lock
	ret
.freedpad
	release
	playsound (SFX_02_5c - SFX_Headers_02) / 3
	selectsprite 0
	facesprite SPRITE_FACING_DOWN
	hideobject HS_MTMOON2_MOCHA
	changescript 5, W_MTMOON2CURSCRIPT
	ret
	
MtMoon2Script5:
	ret