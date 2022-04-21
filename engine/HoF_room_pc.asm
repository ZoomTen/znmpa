HallOfFamePC: ; 7405c (1d:405c)
	callba AnimateHallOfFame
	
CreditsStart:
	call ClearScreen
	ld c, $64
	call DelayFrames
	call LoadFontTilePatterns
	ld a, $ff
	call PlaySoundWaitForCurrent
	ld a, Mus_ToyWarrior
	call PlayMusicEntry
	xor a
	ld [wWhichTrade], a ; wWhichTrade
	ld [wTrainerEngageDistance], a
	call GBPalNormal
	jp Credits_Main

INCLUDE "engine/znmpa_credits2.asm"