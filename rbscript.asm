; this is what I like to call
; "taking the fun out of scripting" :P

messageid: MACRO
; \1 = text ID
	ld a, \1
	ld [hSpriteIndexOrTextID], a
	call DisplayTextID
	ENDM
	
changescript: MACRO
; \1 = script #
; \2 = script byte address
	ld a,\1
	ld [\2],a
	ENDM
	
setflag: MACRO
; \1 = bit to set
; \2 = RAM address
	ld a, [\2]
	set \1,a
	ld [\2],a
	ENDM
	
setflag2: MACRO
; \1 = bit to set
; \2 = RAM address
	ld hl,\2
	set \1,[hl]
	ENDM

testflag: MACRO
; \1 = bit to test
; \2 = RAM address
	ld a, [\2]
	bit \1,a
	ENDM
	
testflag2: MACRO
; \1 = bit to test
; \2 = RAM address
	ld hl,\2
	bit \1,[hl]
	ENDM
	
resetflag: MACRO
; \1 = bit to set
; \2 = RAM address
	ld a, [\2]
	res \1,a
	ld [\2],a
	ENDM
	
resetflag2: MACRO
; \1 = bit to set
; \2 = RAM address
	ld hl,\2
	res \1,[hl]
	ENDM
	
enabletextscripts: MACRO
	call EnableAutoTextBoxDrawing
	ENDM

runscripts: MACRO
; \1 = script counter byte
; \2 = script pointers
	ld hl,\2
	ld a,[\1]
	call CallFunctionInTable
	ENDM
	
playmusicid: MACRO
; \1 = music ID
	ld a, \1
	call PlayMusicEntry
	ENDM
	
playmusic: MACRO
; \1 = music ID
; \2 = bank
	ld a, \1
	ld c, \2
	call PlayMusic
	ENDM
	
playsound: MACRO
; \1 = sound ID
	ld a, \1
	call PlaySound
	ENDM
	
showobject: MACRO
; \1 = hideable object ID
	ld a, \1
	ld [wcc4d], a
	predef ShowObject
	ENDM
	
hideobject: MACRO
; \1 = hideable object ID
	ld a, \1
	ld [wcc4d], a
	predef HideObject
	ENDM
	
showemote:	MACRO
; \1 = sprite ID
; \2 = emotion
	ld a, \1
	ld [wcd4f],a
	ld a, \2
	ld [wcd50],a
	predef EmotionBubble
	ENDM

selectsprite:	MACRO
; \1 = sprite ID
	ld a, \1
	ld [H_SPRITEINDEX], a
	ENDM
	
selectsprite2:	MACRO
; \1 = sprite ID
	ld a, \1
	ld [wSpriteIndex], a
	ENDM
	
movesprite:	MACRO
; \1 = X position on screen
; \2 = Y position on screen
; \3 = X position on map
; \4 = Y position on map
	ld a, \2
	ld [$ffeb], a
	ld a, \1
	ld [$ffec], a
	ld a, \4
	ld [$ffed], a
	ld a, \3
	ld [$ffee], a
	call SetSpritePosition1
	ENDM
	
domovement:	MACRO
; \1 = movement table address
	ld de, \1
	call MoveSprite
	ENDM
	
Left	EQU	$A0
Right	EQU	$C0
Down	EQU	$00
Up	EQU	$40
End	EQU	$FF

facesprite:	MACRO
; \1 = facing byte
	ld a,\1
	ld [H_SPRITEOFFSET],a
	call SetSpriteFacingDirectionAndDelay
	ENDM
	
setspriteimage:	MACRO
; \1 = sprite
; \2 = direction
	ld a, (\1 << 4) | \2
	ld [$ff8d], a
	call SetSpriteImageIndexAfterSettingFacingDirection
	ENDM

delay:	MACRO
; \1 = no. of frames
	ld c, \1
	call DelayFrames
	ENDM
	
testcoordsarray:	MACRO
; \1 = coordinates array offset
	ld hl, \1
	call ArePlayerCoordsInArray
	ret nc
	ENDM
	
fetchcoordsindex:	MACRO
; to be used with checkcoordsarray
	ld a, [wWhichTrade]
	ENDM

release:	MACRO
	xor a
	ld [wJoyIgnore], a
	ENDM

lock:	MACRO
	ld a, $FF
	ld [wJoyIgnore],a
	ENDM
	
lockcontrols:	MACRO
; \1 = which controls to be locked
	ld a, \1
	ld [wJoyIgnore],a
	ENDM
	
setbattle:	MACRO
; \1 = trainer
; \2 = trainer instance
; \3 = afterbattle text
	ld a, \1 + $C8
	ld [W_CUROPPONENT], a
	ld a, \2
	ld [W_TRAINERNO], a
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, \3
	ld de, \3
	call SaveEndBattleTextPointers
	ENDM
	
setbattle2:	MACRO
; \1 = trainer
; \2 = trainer instance
	ld a, \1 + $C8
	ld [W_CUROPPONENT], a
	ld a, \2
	ld [W_TRAINERNO], a
	ENDM
	
setbattle3:	MACRO
; \1 = trainer / pokemon
	ld a, \1 + $C8
	ld [W_CUROPPONENT], a
	ENDM
	
playmapmusic:	MACRO
	call PlayDefaultMusic
	ENDM

testcoordinates:	MACRO
; \1 = X
; \2 = Y
	ld a, [W_YCOORD]
	cp \2
	ret nz
	ld a, [W_XCOORD]
	cp \1
	ret nz
	ENDM

loadsprite1:	MACRO
; for standing sprites
; \1 = sprite's beginning tile ID in VRAM
; \2 = sprite address
	ld hl, vChars0 + (\1 * 16)
	ld de, \2
	ld bc, (BANK(\2)<<8) + 12
	call CopyVideoData
	ENDM
	
loadsprite2:	MACRO
; for walking sprites
; \1 = sprite's beginning tile ID in VRAM
; \2 = sprite address
	ld hl, vChars1 + (\1 * 16)
	ld de, \2 + (12 * 16)
	ld bc, (BANK(\2)<<8) + 12
	call CopyVideoData
	ENDM
	
giveitem:	MACRO
; \1 = item ID
; \2 = quantity
	ld bc,(\1 << 8) | \2
	push de
	ld d, b
	ld e, c
	callba GiveItem2
	pop de
	ENDM
	
givesingleitem:	MACRO
; \1 = item ID
	push de
	ld d, \1
	callba GiveSingleItem2
	pop de
	ENDM
	
giveitem2:	MACRO
; \1 = item ID
; \2 = quantity
	ld bc,(\1 << 8) | \2
	call GiveItem
	ENDM
	
givesingleitem2:	MACRO
; \1 = item ID
	ld a, \1
	call GiveSingleItem
	ENDM
	
givepokemon:	MACRO
; \1 = Pokemon ID
; \2 = level
	ld bc,(\1 << 8) | \2
	call GivePokemon
	ENDM