MtMoon2Script: ; 51a42 (14:5a42)
; required for dialogues and signs script
	call EnableAutoTextBoxDrawing
; required for map script
	ld a, [W_MTMOON2CURSCRIPT]
	ld hl, MtMoon2ScriptPointers
	jp CallFunctionInTable

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
; hide object
	ld a, HS_MTMOON2_MOCHA
	ld [wcc4d], a
	predef HideObject
; if player is at script's position
	ld a, [W_YCOORD]
	cp $07
	ret nz
	ld a, [W_XCOORD]
	cp $05 + 1
	ret nc
; play some music
	ld a, Mus_MeetFemaleTrainer
	call PlayMusicEntry
; display text
	ld a, 2
	ld [hSpriteIndexOrTextID], a
	call DisplayTextID	; print text
; exclamation mark
	xor a
	ld [wcd4f],a
	ld [wcd50],a
	predef EmotionBubble
; show the object
	ld a, HS_MTMOON2_MOCHA
	ld [wcc4d], a
	predef ShowObject
; initialize sprite movements (1=Mocha)
	ld a, $1
	ld [H_SPRITEINDEX], a
; check if player is at left of map
	ld a, [W_XCOORD]
	cp 4
	jr z, .left
; do Mocha's movement
	ld de, .MochaEnters1
	jr .movemocha
.left
	ld de, .MochaEnters2
.movemocha
	call MoveSprite
; switch to next script
	ld a, 1
	ld [W_MTMOON2CURSCRIPT], a
	ret
	
.MochaEnters1:
	db $40, $40, $40, $40, $40, $FF
.MochaEnters2:
	db $40, $40, $40, $40, $40, $40, $FF
	
MtMoon2Script1:
	ld a, [wd730]
	bit 0, a
	jr z, .freedpad
	ld a, $FF
	ld [wJoyIgnore],a
	ret
.freedpad
	xor a
	ld [wJoyIgnore],a	; free the joypad
; continue here
; check player's position
	ld a, [W_XCOORD]
	cp 4
	jr nz, .dontfaceleft
; face left
	ld a,1
	ld [$FF8C],a
	ld a,8
	ld [$FF8D],a
	call SetSpriteFacingDirectionAndDelay
.dontfaceleft
; display text
	ld a, 3
	ld [hSpriteIndexOrTextID], a
	call DisplayTextID
; initialize battle
	ld a, MOCHA + $C8
	ld [W_CUROPPONENT], a
	ld a, 2
	ld [W_TRAINERNO], a
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, MtMoonMochaEndBattle
	ld de, MtMoonMochaEndBattle
	call SaveEndBattleTextPointers
; immediately run the next script after battle
	ld a, 2
	ld [W_MTMOON2CURSCRIPT], a
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
	ld a,0
	ld [$FF8C],a
	ld a,SPRITE_FACING_RIGHT
	ld [$FF8D],a
	call SetSpriteFacingDirectionAndDelay
	ld a,1
	ld [$FF8C],a
	ld a,8
	ld [$FF8D],a
	call SetSpriteFacingDirectionAndDelay
	jr .continue
.facefront
	ld [$FF8D],a
	call SetSpriteFacingDirectionAndDelay
	ld a,1
	ld [$FF8C],a
	ld a,4
	ld [$FF8D],a
	call SetSpriteFacingDirectionAndDelay
.continue
; print text
	ld a, 4
	ld [hSpriteIndexOrTextID], a
	call DisplayTextID
; goto next script
	ld a, 3
	ld [W_MTMOON2CURSCRIPT], a
	ret
.iflose
; reset script
	ld a, 0
	ld [W_MTMOON2CURSCRIPT], a
	ret
	
MtMoon2Script3:
; initialize sprite movements (1=Mocha)
	ld a, $1
	ld [H_SPRITEINDEX], a
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
; run next script
	ld a, 4
	ld [W_MTMOON2CURSCRIPT], a
	ret
	
.MochaOut1:
	db $A0, $40, $40, $C0, $40, $FF
.MochaOut2:
	db $40, $40, $FF
	
MtMoon2Script4:
	ld a, [wd730]
	bit 0, a
	jr z, .freedpad
	ld a, $FF
	ld [wJoyIgnore],a
	ret
.freedpad
	xor a
	ld [wJoyIgnore],a
; play sound
	ld a,(SFX_02_5c - SFX_Headers_02) / 3
	call PlaySound
	ld a,0
	ld [$FF8C],a
	ld a,SPRITE_FACING_DOWN
	ld [$FF8D],a
	call SetSpriteFacingDirectionAndDelay
; hide mocha object
	ld a, HS_MTMOON2_MOCHA
	ld [wcc4d], a
	predef HideObject
; switch to null script
	ld a, 5
	ld [W_MTMOON2CURSCRIPT], a
	
MtMoon2Script5:
	ret