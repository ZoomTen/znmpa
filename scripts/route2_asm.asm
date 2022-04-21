Route2Script: ; 554e3 (15:54e3)
; required for dialogues and signs script
	call EnableAutoTextBoxDrawing
; required for map script
	ld a, [W_ROUTE2CURSCRIPT]
	ld hl, Route2ScriptPointers
	jp CallFunctionInTable

Route2ScriptPointers:
	dw Route2Script0
	dw Route2Script1
	dw Route2Script2
	dw Route2Script3

Route2Script0:
	ld a, [W_YCOORD]	; if player is at script position
	cp $0b
	ret nz
	ld a, [W_XCOORD]
	cp $03
	ret nz
; Temporarily loads Mocha's sprites in.
; Because loading another sprite set is such a waste.
	ld hl, vChars0 + $600
	ld de, MochaSprite
	ld bc, (BANK(MochaSprite)<<8) + 12
	call CopyVideoData
	ld a, Mus_MeetFemaleTrainer
	call PlayMusicEntry	; play music
	xor a
	ld [wcd4f],a		; 00 = player's sprite
	ld [wcd50],a		; 00 = exclamation mark
	predef EmotionBubble	; display ! over head
	ld a, HS_ROUTE_2_MOCHA
	ld [wcc4d], a
	predef ShowObject		; show the mocha object
					; for some reason it was hidden
	ld a, 5
	ld [hSpriteIndexOrTextID], a
	call DisplayTextID	; print text
	ld a, MOCHA + $C8
	ld [W_CUROPPONENT], a	; commence trainer battle
	ld a, 1
	ld [W_TRAINERNO], a	; which instance
	ld hl, wd72d
	set 6, [hl]			; These bits need to be set in order
	set 7, [hl]			; to display the end battle text
	ld hl, Route2MochaEndBattle
	ld de, Route2MochaEndBattle
	call SaveEndBattleTextPointers
	ld a, HS_ROUTE_2_MOCHA
	ld [wcc4d], a
	predef HideObject		; tricky shit
	ld a, 1				; set current script so that
	ld [W_ROUTE2CURSCRIPT], a	; it can be executed immediately
					; after battle
	ret
	
Route2Script1:
; At this point Mocha morphed into some random snort
; so reload Mocha's spriteset
	ld hl, vChars0 + $600
	ld de, MochaSprite
	ld bc, (BANK(MochaSprite)<<8) + 12
	call CopyVideoData
	ld a, HS_ROUTE_2_MOCHA
	ld [wcc4d], a
	predef ShowObject		; tricky shit
	predef HealParty		; Makes all Pokemon usable again
	ld a, Mus_MeetFemaleTrainer	; After battle it plays the map music
	call PlayMusicEntry		; so bring back the encounter music
	ld a, 6
	ld [hSpriteIndexOrTextID], a
	call DisplayTextID
; Temporarily loads Mocha's walking sprites
	ld hl, vChars1 + $600
	ld de, MochaSprite + (12 * 16)
	ld bc, (BANK(MochaSprite)<<8) + 12
	call CopyVideoData
	ld a, $3			; Move Mocha
	ld [H_SPRITEINDEX], a
	ld de, .MochaExitMovement
	call MoveSprite
	ld a, 2				; switch to joypad control script
	ld [W_ROUTE2CURSCRIPT], a	; because movesprite doesn't wait until
					; it's finished moving
	ret
	
.MochaExitMovement
	db $40,$C0,$C0,$C0,$C0,$C0,$40,$40,$FF
	; 40 = up
	; 80 = down
	; C0 = right
	; A0 = left
	
Route2Script2:
	ld a, [wd730]
	bit 0, a
	jr z, .freedpad		; stop ignoring input?
	ld a, $FF		; freeze joypad if we aren't supposed to
	ld [wJoyIgnore],a
	ret
.freedpad
	xor a
	ld [wJoyIgnore],a	; free the joypad
; reload one of the sprites
	ld hl, vChars0 + $600
	ld de, LassSprite
	ld bc, (BANK(LassSprite)<<8) + 12
	call CopyVideoData
	ld hl, vChars1 + $600
	ld de, LassSprite + (12 * 16)
	ld bc, (BANK(LassSprite)<<8) + 12
	call CopyVideoData
	call PlayDefaultMusic
	ld a, HS_ROUTE_2_MOCHA
	ld [wcc4d], a
	predef HideObject		; hide the mocha object
	ld a, 3				; switch to an empty routine immediately
	ld [W_ROUTE2CURSCRIPT], a	; this also sets the "???"/"Mocha" flag
	ret
	
Route2Script3:
	ret
	
Route2TextPointers: ; 554e6 (15:54e6)
	dw Predef5CText
	dw Predef5CText
	dw Route2Text3
	dw Route2Text4
	dw MochaText1
	dw MochaText2

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