AUDIO_1 EQU $2
AUDIO_2 EQU $8
AUDIO_3 EQU $1f
AUDIO_4 EQU $2e
AUDIO_5 EQU $2f
PCM_1	EQU $30
AUDIO_6 EQU $31

INCLUDE "constants.asm"

SECTION "Sound Effect Headers 1", ROMX, BANK[AUDIO_1]
INCLUDE "audio/headers/sfxheaders02.asm"

SECTION "Sound Effect Headers 2", ROMX, BANK[AUDIO_2]
INCLUDE "audio/headers/sfxheaders08.asm"

SECTION "Sound Effect Headers 3", ROMX, BANK[AUDIO_3]
INCLUDE "audio/headers/sfxheaders1f.asm"

SECTION "SFX Headers 31", ROMX, BANK[AUDIO_6]
INCLUDE "audio/headers/sfxheaders31.asm"

SECTION "Music Headers 1", ROMX, BANK[AUDIO_1]
INCLUDE "audio/headers/musicheaders02.asm"

SECTION "Music Headers 2", ROMX, BANK[AUDIO_2]
INCLUDE "audio/headers/musicheaders08.asm"

SECTION "Music Headers 3", ROMX, BANK[AUDIO_3]
INCLUDE "audio/headers/musicheaders1f.asm"

SECTION "Music Headers 31", ROMX, BANK[AUDIO_6]
INCLUDE "audio/headers/musicheaders31.asm"

SECTION "Sound Effects 1", ROMX, BANK[AUDIO_1]
INCLUDE "audio/sfx/sfx_02_01.asm"
INCLUDE "audio/sfx/sfx_02_02.asm"
INCLUDE "audio/sfx/sfx_02_03.asm"
INCLUDE "audio/sfx/sfx_02_04.asm"
INCLUDE "audio/sfx/sfx_02_05.asm"
INCLUDE "audio/sfx/sfx_02_06.asm"
INCLUDE "audio/sfx/sfx_02_07.asm"
INCLUDE "audio/sfx/sfx_02_08.asm"
INCLUDE "audio/sfx/sfx_02_09.asm"
INCLUDE "audio/sfx/sfx_02_0a.asm"
INCLUDE "audio/sfx/sfx_02_0b.asm"
INCLUDE "audio/sfx/sfx_02_0c.asm"
INCLUDE "audio/sfx/sfx_02_0d.asm"
INCLUDE "audio/sfx/sfx_02_0e.asm"
INCLUDE "audio/sfx/sfx_02_0f.asm"
INCLUDE "audio/sfx/sfx_02_10.asm"
INCLUDE "audio/sfx/sfx_02_11.asm"
INCLUDE "audio/sfx/sfx_02_12.asm"
INCLUDE "audio/sfx/sfx_02_13.asm"
Music2_WavePointers: INCLUDE "audio/wave_instruments.asm"
INCLUDE "audio/sfx/sfx_02_3f.asm"
INCLUDE "audio/sfx/sfx_02_5e.asm"
INCLUDE "audio/sfx/sfx_02_56.asm"
INCLUDE "audio/sfx/sfx_02_57.asm"
INCLUDE "audio/sfx/sfx_02_58.asm"
INCLUDE "audio/sfx/sfx_02_3c.asm"
INCLUDE "audio/sfx/sfx_02_59.asm"
INCLUDE "audio/sfx/sfx_02_5a.asm"
INCLUDE "audio/sfx/sfx_02_5b.asm"
INCLUDE "audio/sfx/sfx_02_5c.asm"
INCLUDE "audio/sfx/sfx_02_40.asm"
INCLUDE "audio/sfx/sfx_02_5d.asm"
INCLUDE "audio/sfx/sfx_02_3d.asm"
INCLUDE "audio/sfx/sfx_02_43.asm"
INCLUDE "audio/sfx/sfx_02_3e.asm"
INCLUDE "audio/sfx/sfx_02_44.asm"
INCLUDE "audio/sfx/sfx_02_45.asm"
INCLUDE "audio/sfx/sfx_02_46.asm"
INCLUDE "audio/sfx/sfx_02_47.asm"
INCLUDE "audio/sfx/sfx_02_48.asm"
INCLUDE "audio/sfx/sfx_02_49.asm"
INCLUDE "audio/sfx/sfx_02_4a.asm"
INCLUDE "audio/sfx/sfx_02_4b.asm"
INCLUDE "audio/sfx/sfx_02_4c.asm"
INCLUDE "audio/sfx/sfx_02_4d.asm"
INCLUDE "audio/sfx/sfx_02_4e.asm"
INCLUDE "audio/sfx/sfx_02_4f.asm"
INCLUDE "audio/sfx/sfx_02_50.asm"
INCLUDE "audio/sfx/sfx_02_51.asm"
INCLUDE "audio/sfx/sfx_02_52.asm"
INCLUDE "audio/sfx/sfx_02_53.asm"
INCLUDE "audio/sfx/sfx_02_54.asm"
INCLUDE "audio/sfx/sfx_02_55.asm"
INCLUDE "audio/sfx/sfx_02_5f.asm"
INCLUDE "audio/sfx/sfx_02_1d.asm"
INCLUDE "audio/sfx/sfx_02_37.asm"
INCLUDE "audio/sfx/sfx_02_38.asm"
INCLUDE "audio/sfx/sfx_02_25.asm"
INCLUDE "audio/sfx/sfx_02_39.asm"
INCLUDE "audio/sfx/sfx_02_17.asm"
INCLUDE "audio/sfx/sfx_02_23.asm"
INCLUDE "audio/sfx/sfx_02_24.asm"
INCLUDE "audio/sfx/sfx_02_14.asm"
INCLUDE "audio/sfx/sfx_02_22.asm"
INCLUDE "audio/sfx/sfx_02_1a.asm"
INCLUDE "audio/sfx/sfx_02_1b.asm"
INCLUDE "audio/sfx/sfx_02_19.asm"
INCLUDE "audio/sfx/sfx_02_1f.asm"
INCLUDE "audio/sfx/sfx_02_20.asm"
INCLUDE "audio/sfx/sfx_02_16.asm"
INCLUDE "audio/sfx/sfx_02_21.asm"
INCLUDE "audio/sfx/sfx_02_15.asm"
INCLUDE "audio/sfx/sfx_02_1e.asm"
INCLUDE "audio/sfx/sfx_02_1c.asm"
INCLUDE "audio/sfx/sfx_02_18.asm"
INCLUDE "audio/sfx/sfx_02_2d.asm"
INCLUDE "audio/sfx/sfx_02_2a.asm"
INCLUDE "audio/sfx/sfx_02_2f.asm"
INCLUDE "audio/sfx/sfx_02_26.asm"
INCLUDE "audio/sfx/sfx_02_27.asm"
INCLUDE "audio/sfx/sfx_02_28.asm"
INCLUDE "audio/sfx/sfx_02_32.asm"
INCLUDE "audio/sfx/sfx_02_29.asm"
INCLUDE "audio/sfx/sfx_02_2b.asm"
INCLUDE "audio/sfx/sfx_02_30.asm"
INCLUDE "audio/sfx/sfx_02_2e.asm"
INCLUDE "audio/sfx/sfx_02_31.asm"
INCLUDE "audio/sfx/sfx_02_2c.asm"
INCLUDE "audio/sfx/sfx_02_33.asm"
INCLUDE "audio/sfx/sfx_02_34.asm"
INCLUDE "audio/sfx/sfx_02_35.asm"
INCLUDE "audio/sfx/sfx_02_36.asm"


SECTION "Sound Effects 2", ROMX, BANK[AUDIO_2]
INCLUDE "audio/sfx/sfx_08_01.asm"
INCLUDE "audio/sfx/sfx_08_02.asm"
INCLUDE "audio/sfx/sfx_08_03.asm"
INCLUDE "audio/sfx/sfx_08_04.asm"
INCLUDE "audio/sfx/sfx_08_05.asm"
INCLUDE "audio/sfx/sfx_08_06.asm"
INCLUDE "audio/sfx/sfx_08_07.asm"
INCLUDE "audio/sfx/sfx_08_08.asm"
INCLUDE "audio/sfx/sfx_08_09.asm"
INCLUDE "audio/sfx/sfx_08_0a.asm"
INCLUDE "audio/sfx/sfx_08_0b.asm"
INCLUDE "audio/sfx/sfx_08_0c.asm"
INCLUDE "audio/sfx/sfx_08_0d.asm"
INCLUDE "audio/sfx/sfx_08_0e.asm"
INCLUDE "audio/sfx/sfx_08_0f.asm"
INCLUDE "audio/sfx/sfx_08_10.asm"
INCLUDE "audio/sfx/sfx_08_11.asm"
INCLUDE "audio/sfx/sfx_08_12.asm"
INCLUDE "audio/sfx/sfx_08_13.asm"
Music8_WavePointers: INCLUDE "audio/wave_instruments.asm"
INCLUDE "audio/sfx/sfx_08_40.asm"
INCLUDE "audio/sfx/sfx_08_3f.asm"
INCLUDE "audio/sfx/sfx_08_3c.asm"
INCLUDE "audio/sfx/sfx_08_3d.asm"
INCLUDE "audio/sfx/sfx_08_3e.asm"
INCLUDE "audio/sfx/sfx_08_77.asm"
INCLUDE "audio/sfx/sfx_08_41.asm"
INCLUDE "audio/sfx/sfx_08_42.asm"
INCLUDE "audio/sfx/sfx_08_43.asm"
INCLUDE "audio/sfx/sfx_08_44.asm"
INCLUDE "audio/sfx/sfx_08_45.asm"
INCLUDE "audio/sfx/sfx_08_pokeflute_ch3.asm"
INCLUDE "audio/sfx/sfx_08_47.asm"
INCLUDE "audio/sfx/sfx_08_48.asm"
INCLUDE "audio/sfx/sfx_08_49.asm"
INCLUDE "audio/sfx/sfx_08_4a.asm"
INCLUDE "audio/sfx/sfx_08_4b.asm"
INCLUDE "audio/sfx/sfx_08_4c.asm"
INCLUDE "audio/sfx/sfx_08_4d.asm"
INCLUDE "audio/sfx/sfx_08_4e.asm"
INCLUDE "audio/sfx/sfx_08_4f.asm"
INCLUDE "audio/sfx/sfx_08_50.asm"
INCLUDE "audio/sfx/sfx_08_51.asm"
INCLUDE "audio/sfx/sfx_08_52.asm"
INCLUDE "audio/sfx/sfx_08_53.asm"
INCLUDE "audio/sfx/sfx_08_54.asm"
INCLUDE "audio/sfx/sfx_08_55.asm"
INCLUDE "audio/sfx/sfx_08_56.asm"
INCLUDE "audio/sfx/sfx_08_57.asm"
INCLUDE "audio/sfx/sfx_08_58.asm"
INCLUDE "audio/sfx/sfx_08_59.asm"
INCLUDE "audio/sfx/sfx_08_5a.asm"
INCLUDE "audio/sfx/sfx_08_5b.asm"
INCLUDE "audio/sfx/sfx_08_5c.asm"
INCLUDE "audio/sfx/sfx_08_5d.asm"
INCLUDE "audio/sfx/sfx_08_5e.asm"
INCLUDE "audio/sfx/sfx_08_5f.asm"
INCLUDE "audio/sfx/sfx_08_60.asm"
INCLUDE "audio/sfx/sfx_08_61.asm"
INCLUDE "audio/sfx/sfx_08_62.asm"
INCLUDE "audio/sfx/sfx_08_63.asm"
INCLUDE "audio/sfx/sfx_08_64.asm"
INCLUDE "audio/sfx/sfx_08_65.asm"
INCLUDE "audio/sfx/sfx_08_66.asm"
INCLUDE "audio/sfx/sfx_08_67.asm"
INCLUDE "audio/sfx/sfx_08_68.asm"
INCLUDE "audio/sfx/sfx_08_69.asm"
INCLUDE "audio/sfx/sfx_08_6a.asm"
INCLUDE "audio/sfx/sfx_08_6b.asm"
INCLUDE "audio/sfx/sfx_08_6c.asm"
INCLUDE "audio/sfx/sfx_08_6d.asm"
INCLUDE "audio/sfx/sfx_08_6e.asm"
INCLUDE "audio/sfx/sfx_08_6f.asm"
INCLUDE "audio/sfx/sfx_08_70.asm"
INCLUDE "audio/sfx/sfx_08_71.asm"
INCLUDE "audio/sfx/sfx_08_72.asm"
INCLUDE "audio/sfx/sfx_08_73.asm"
INCLUDE "audio/sfx/sfx_08_74.asm"
INCLUDE "audio/sfx/sfx_08_75.asm"
INCLUDE "audio/sfx/sfx_08_76.asm"
INCLUDE "audio/sfx/sfx_08_unused.asm"
INCLUDE "audio/sfx/sfx_08_1d.asm"
INCLUDE "audio/sfx/sfx_08_37.asm"
INCLUDE "audio/sfx/sfx_08_38.asm"
INCLUDE "audio/sfx/sfx_08_25.asm"
INCLUDE "audio/sfx/sfx_08_39.asm"
INCLUDE "audio/sfx/sfx_08_17.asm"
INCLUDE "audio/sfx/sfx_08_23.asm"
INCLUDE "audio/sfx/sfx_08_24.asm"
INCLUDE "audio/sfx/sfx_08_14.asm"
INCLUDE "audio/sfx/sfx_08_22.asm"
INCLUDE "audio/sfx/sfx_08_1a.asm"
INCLUDE "audio/sfx/sfx_08_1b.asm"
INCLUDE "audio/sfx/sfx_08_19.asm"
INCLUDE "audio/sfx/sfx_08_1f.asm"
INCLUDE "audio/sfx/sfx_08_20.asm"
INCLUDE "audio/sfx/sfx_08_16.asm"
INCLUDE "audio/sfx/sfx_08_21.asm"
INCLUDE "audio/sfx/sfx_08_15.asm"
INCLUDE "audio/sfx/sfx_08_1e.asm"
INCLUDE "audio/sfx/sfx_08_1c.asm"
INCLUDE "audio/sfx/sfx_08_18.asm"
INCLUDE "audio/sfx/sfx_08_2d.asm"
INCLUDE "audio/sfx/sfx_08_2a.asm"
INCLUDE "audio/sfx/sfx_08_2f.asm"
INCLUDE "audio/sfx/sfx_08_26.asm"
INCLUDE "audio/sfx/sfx_08_27.asm"
INCLUDE "audio/sfx/sfx_08_28.asm"
INCLUDE "audio/sfx/sfx_08_32.asm"
INCLUDE "audio/sfx/sfx_08_29.asm"
INCLUDE "audio/sfx/sfx_08_2b.asm"
INCLUDE "audio/sfx/sfx_08_30.asm"
INCLUDE "audio/sfx/sfx_08_2e.asm"
INCLUDE "audio/sfx/sfx_08_31.asm"
INCLUDE "audio/sfx/sfx_08_2c.asm"
INCLUDE "audio/sfx/sfx_08_33.asm"
INCLUDE "audio/sfx/sfx_08_34.asm"
INCLUDE "audio/sfx/sfx_08_35.asm"
INCLUDE "audio/sfx/sfx_08_36.asm"


SECTION "Sound Effects 3", ROMX, BANK[AUDIO_3]
INCLUDE "audio/sfx/sfx_1f_01.asm"
INCLUDE "audio/sfx/sfx_1f_02.asm"
INCLUDE "audio/sfx/sfx_1f_03.asm"
INCLUDE "audio/sfx/sfx_1f_04.asm"
INCLUDE "audio/sfx/sfx_1f_05.asm"
INCLUDE "audio/sfx/sfx_1f_06.asm"
INCLUDE "audio/sfx/sfx_1f_07.asm"
INCLUDE "audio/sfx/sfx_1f_08.asm"
INCLUDE "audio/sfx/sfx_1f_09.asm"
INCLUDE "audio/sfx/sfx_1f_0a.asm"
INCLUDE "audio/sfx/sfx_1f_0b.asm"
INCLUDE "audio/sfx/sfx_1f_0c.asm"
INCLUDE "audio/sfx/sfx_1f_0d.asm"
INCLUDE "audio/sfx/sfx_1f_0e.asm"
INCLUDE "audio/sfx/sfx_1f_0f.asm"
INCLUDE "audio/sfx/sfx_1f_10.asm"
INCLUDE "audio/sfx/sfx_1f_11.asm"
INCLUDE "audio/sfx/sfx_1f_12.asm"
INCLUDE "audio/sfx/sfx_1f_13.asm"
Music1f_WavePointers: INCLUDE "audio/wave_instruments.asm"
INCLUDE "audio/sfx/sfx_1f_3f.asm"
INCLUDE "audio/sfx/sfx_1f_56.asm"
INCLUDE "audio/sfx/sfx_1f_57.asm"
INCLUDE "audio/sfx/sfx_1f_58.asm"
INCLUDE "audio/sfx/sfx_1f_3c.asm"
INCLUDE "audio/sfx/sfx_1f_59.asm"
INCLUDE "audio/sfx/sfx_1f_5a.asm"
INCLUDE "audio/sfx/sfx_1f_5b.asm"
INCLUDE "audio/sfx/sfx_1f_5c.asm"
INCLUDE "audio/sfx/sfx_1f_40.asm"
INCLUDE "audio/sfx/sfx_1f_5d.asm"
INCLUDE "audio/sfx/sfx_1f_3d.asm"
INCLUDE "audio/sfx/sfx_1f_43.asm"
INCLUDE "audio/sfx/sfx_1f_3e.asm"
INCLUDE "audio/sfx/sfx_1f_44.asm"
INCLUDE "audio/sfx/sfx_1f_45.asm"
INCLUDE "audio/sfx/sfx_1f_46.asm"
INCLUDE "audio/sfx/sfx_1f_47.asm"
INCLUDE "audio/sfx/sfx_1f_48.asm"
INCLUDE "audio/sfx/sfx_1f_49.asm"
INCLUDE "audio/sfx/sfx_1f_4a.asm"
INCLUDE "audio/sfx/sfx_1f_4b.asm"
INCLUDE "audio/sfx/sfx_1f_4c.asm"
INCLUDE "audio/sfx/sfx_1f_4d.asm"
INCLUDE "audio/sfx/sfx_1f_4e.asm"
INCLUDE "audio/sfx/sfx_1f_4f.asm"
INCLUDE "audio/sfx/sfx_1f_50.asm"
INCLUDE "audio/sfx/sfx_1f_51.asm"
INCLUDE "audio/sfx/sfx_1f_52.asm"
INCLUDE "audio/sfx/sfx_1f_53.asm"
INCLUDE "audio/sfx/sfx_1f_54.asm"
INCLUDE "audio/sfx/sfx_1f_55.asm"
INCLUDE "audio/sfx/sfx_1f_5e.asm"
INCLUDE "audio/sfx/sfx_1f_5f.asm"
INCLUDE "audio/sfx/sfx_1f_60.asm"
INCLUDE "audio/sfx/sfx_1f_61.asm"
INCLUDE "audio/sfx/sfx_1f_62.asm"
INCLUDE "audio/sfx/sfx_1f_63.asm"
INCLUDE "audio/sfx/sfx_1f_64.asm"
INCLUDE "audio/sfx/sfx_1f_65.asm"
INCLUDE "audio/sfx/sfx_1f_66.asm"
INCLUDE "audio/sfx/sfx_1f_67.asm"
INCLUDE "audio/sfx/sfx_1f_unused.asm"
INCLUDE "audio/sfx/sfx_1f_1d.asm"
INCLUDE "audio/sfx/sfx_1f_37.asm"
INCLUDE "audio/sfx/sfx_1f_38.asm"
INCLUDE "audio/sfx/sfx_1f_25.asm"
INCLUDE "audio/sfx/sfx_1f_39.asm"
INCLUDE "audio/sfx/sfx_1f_17.asm"
INCLUDE "audio/sfx/sfx_1f_23.asm"
INCLUDE "audio/sfx/sfx_1f_24.asm"
INCLUDE "audio/sfx/sfx_1f_14.asm"
INCLUDE "audio/sfx/sfx_1f_22.asm"
INCLUDE "audio/sfx/sfx_1f_1a.asm"
INCLUDE "audio/sfx/sfx_1f_1b.asm"
INCLUDE "audio/sfx/sfx_1f_19.asm"
INCLUDE "audio/sfx/sfx_1f_1f.asm"
INCLUDE "audio/sfx/sfx_1f_20.asm"
INCLUDE "audio/sfx/sfx_1f_16.asm"
INCLUDE "audio/sfx/sfx_1f_21.asm"
INCLUDE "audio/sfx/sfx_1f_15.asm"
INCLUDE "audio/sfx/sfx_1f_1e.asm"
INCLUDE "audio/sfx/sfx_1f_1c.asm"
INCLUDE "audio/sfx/sfx_1f_18.asm"
INCLUDE "audio/sfx/sfx_1f_2d.asm"
INCLUDE "audio/sfx/sfx_1f_2a.asm"
INCLUDE "audio/sfx/sfx_1f_2f.asm"
INCLUDE "audio/sfx/sfx_1f_26.asm"
INCLUDE "audio/sfx/sfx_1f_27.asm"
INCLUDE "audio/sfx/sfx_1f_28.asm"
INCLUDE "audio/sfx/sfx_1f_32.asm"
INCLUDE "audio/sfx/sfx_1f_29.asm"
INCLUDE "audio/sfx/sfx_1f_2b.asm"
INCLUDE "audio/sfx/sfx_1f_30.asm"
INCLUDE "audio/sfx/sfx_1f_2e.asm"
INCLUDE "audio/sfx/sfx_1f_31.asm"
INCLUDE "audio/sfx/sfx_1f_2c.asm"
INCLUDE "audio/sfx/sfx_1f_33.asm"
INCLUDE "audio/sfx/sfx_1f_34.asm"
INCLUDE "audio/sfx/sfx_1f_35.asm"
INCLUDE "audio/sfx/sfx_1f_36.asm"

SECTION "SFX 31", ROMX, BANK[AUDIO_6]
INCLUDE "audio/sfx/sfx_31_drumset.asm"
Music31_WavePointers:
	dw .wave0
	dw .wave1
	dw .wave2
	dw .wave3
	dw .wave4
	dw .wave5 ; used in the Lavender Town and Pokemon Tower themes
	dw .wave5 ; unused
	dw .wave5 ; unused
	dw .wave5 ; unused

; these are the definitions for the channel 3 instruments
; each instrument definition is made up of 32 points (nibbles) that form
; the graph of the wave
; the current instrument is copied to $FF30
.wave0
	db $02,$46,$8A,$CE,$FF,$FE,$ED,$DC,$CB,$A9,$87,$65,$44,$33,$22,$11

.wave1
	db $02,$46,$8A,$CE,$EF,$FF,$FE,$EE,$DD,$CB,$A9,$87,$65,$43,$22,$11

.wave2
	db $13,$69,$BD,$EE,$EE,$FF,$FF,$ED,$DE,$FF,$FF,$EE,$EE,$DB,$96,$31

.wave3
	db $35,$BE,$FE,$DA,$85,$32,$20,$88,$01,$12,$34,$56,$67,$8A,$AC,$D7

.wave4
	db $00,$00,$05,$55,$55,$5d,$dd,$dd,$d0,$11,$11,$11,$09,$99,$99,$90

; duty 5 reads from sfx data
.wave5



SECTION "Audio Engine 1", ROMX, BANK[AUDIO_1]
PlayBattleMusic:: ; 0x90c6
	xor a
	ld [wMusicHeaderPointer], a
	ld [wLowHealthAlarm], a
	dec a
	ld [wc0ee], a
	call PlaySound ; stop music
	call DelayFrame
	ld a, [W_GYMLEADERNO]
	and a
	jr z, .notGymLeaderBattle
	ld a, Mus_GymLeaderBattle
	jr .playSong
.notGymLeaderBattle
	ld a, [W_CUROPPONENT]
	cp $c8
	jr c, .wildBattle
	cp LUMI + $c8
	jr z, .LumiBattle
	cp MASKEDLUMI + $c8
	jr z, .MaskedBattle
	cp TRON_SILVUMI + $c8
	jr z, .TronBattle
	cp SONY3 + $c8
	jr z, .finalBattle
	cp HAIDEN + $c8
	jr z, .HaidenBattle
	cp LANCE + $c8
	jr z, .LanceBattle
	cp LORELEI + $c8	; elite 4 now plays gym leader battle theme
	jr z, .gymBattle
	cp AGATHA + $c8
	jr z, .gymBattle
	cp BRUNO + $c8
	jr z, .gymBattle
	ld a, [W_GYMLEADERNO]
	and a
	jr z, .normalTrainerBattle
.gymBattle
	ld a, Mus_GymLeaderBattle
	jr .playSong
.TronBattle
	ld a, Mus_SpecialBattle
	jr .playSong
.MaskedBattle
	ld a, Mus_MaskedBattle
	jr .playSong
.normalTrainerBattle
	ld a, Mus_TrainerBattle
	jr .playSong
.specialBattle
	ld a, Mus_SpecialBattle
	jr .playSong
.HaidenBattle
	ld a, Mus_HaidenBattle
	jr .playSong
.LumiBattle
	ld a, [W_TRAINERNO]
	cp 1				; is Lumi's rematch?
	jr z, .normalTrainerBattle	; normal music if yes
	ld a, Mus_ClubLeaderBattle
	jr .playSong
.finalBattle
	ld a, [wBeatenChamp]	; did we beat the game yet? (rematch)
	bit 0, a
	jr z, .normalfinal
	ld a, Mus_WCS
	jr .playSong
.normalfinal
	ld a, Mus_FinalBattle
	jr .playSong
.wildBattle
	ld a, Mus_WildBattle
	jr .playSong
.LanceBattle
	ld a, Mus_LanceBattle ; this ain't just Red's theme ya know
.playSong
	jp PlayMusicEntry


INCLUDE "audio/engine_1.asm"


; an alternate start for MeetRival which has a different first measure
Music_RivalAlternateStart:: ; 0x9b47
	ld c, BANK(Music_MeetRival)
	ld a, MUSIC_MEET_RIVAL
	call PlayMusic
	ld hl, wc006
	ld de, Music_MeetRival_branch_b1a2
	call Music2_OverwriteChannelPointer
	ld de, Music_MeetRival_branch_b21d
	call Music2_OverwriteChannelPointer
	ld de, Music_MeetRival_branch_b2b5

Music2_OverwriteChannelPointer: ; 0x9b60
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	ret

; an alternate tempo for MeetRival which is slightly slower
Music_RivalAlternateTempo:: ; 0x9b65
	ld c, BANK(Music_MeetRival)
	ld a, MUSIC_MEET_RIVAL
	call PlayMusic
	ld hl, wc006
	ld de, Music_MeetRival_branch_b119
	jp Music2_OverwriteChannelPointer

; applies both the alternate start and alternate tempo
Music_RivalAlternateStartAndTempo:: ; 0x9b75
	call Music_RivalAlternateStart
	ld hl, wc006
	ld de, Music_MeetRival_branch_b19b
	jp Music2_OverwriteChannelPointer

; an alternate tempo for Cities1 which is used for the Hall of Fame room
Music_Cities1AlternateTempo:: ; 0x9b81
	ld a, $a
	ld [wcfc8], a
	ld [wcfc9], a
	ld a, $ff
	ld [wMusicHeaderPointer], a
	ld c, $64
	call DelayFrames
	ld c, BANK(Music_PalletTown)
	ld a, MUSIC_PALLET_TOWN
	call PlayMusic
	ld hl, wc006
	ld de, Music_PalletTown_Changetempo
	jp Music2_OverwriteChannelPointer


SECTION "Audio Engine 2", ROMX, BANK[AUDIO_2]
Music_DoLowHealthAlarm:: ; 2136e (8:536e)
	ld a, [wLowHealthAlarm]
	cp $ff
	jr z, .disableAlarm

	bit 7, a  ;alarm enabled?
	ret z     ;nope

	and $7f   ;low 7 bits are the timer.
	jr nz, .asm_21383 ;if timer > 0, play low tone.

	call .playToneHi
	ld a, 30 ;keep this tone for 30 frames.
	jr .asm_21395 ;reset the timer.

.asm_21383
	cp 20
	jr nz, .asm_2138a ;if timer == 20,
	call .playToneLo  ;actually set the sound registers.

.asm_2138a
	ld a, $86
	ld [wc02a], a ;disable sound channel?
	ld a, [wLowHealthAlarm]
	and $7f ;decrement alarm timer.
	dec a

.asm_21395
	; reset the timer and enable flag.
	set 7, a
	ld [wLowHealthAlarm], a
	ret

.disableAlarm
	xor a
	ld [wLowHealthAlarm], a  ;disable alarm
	ld [wc02a], a  ;re-enable sound channel?
	ld de, .toneDataSilence
	jr .playTone

;update the sound registers to change the frequency.
;the tone set here stays until we change it.
.playToneHi
	ld de, .toneDataHi
	jr .playTone

.playToneLo
	ld de, .toneDataLo

;update sound channel 1 to play the alarm, overriding all other sounds.
.playTone
	ld hl, rNR10 ;channel 1 sound register
	ld c, $5
	xor a

.copyLoop
	ld [hli], a
	ld a, [de]
	inc de
	dec c
	jr nz, .copyLoop
	ret

;bytes to write to sound channel 1 registers for health alarm.
;starting at FF11 (FF10 is always zeroed), so these bytes are:
;length, envelope, freq lo, freq hi
.toneDataHi
	db $A0,$E2,$50,$87

.toneDataLo
	db $B0,$E2,$EE,$86

;written to stop the alarm
.toneDataSilence
	db $00,$00,$00,$80


;INCLUDE "engine/menu/bills_pc.asm"

INCLUDE "audio/engine_2.asm"


Music_PokeFluteInBattle:: ; 22306 (8:6306)
	ld a, (SFX_08_46 - SFX_Headers_08) / 3 ; PokeFlute outside of battle
	call PlaySoundWaitForCurrent
	ld hl, wc00e
	ld de, SFX_08_PokeFlute_Ch1
	call Music8_OverwriteChannelPointer
	ld de, SFX_08_PokeFlute_Ch2
	call Music8_OverwriteChannelPointer
	ld de, SFX_08_PokeFlute_Ch3

Music8_OverwriteChannelPointer: ; 2231d (8:631d)
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	ret


SECTION "Audio Engine 3", ROMX, BANK[AUDIO_3]
Func_7d13b:: ; 7d13b (1f:513b)
	ld a, [$ffdc]
	ld c, $0
	ld hl, OwnedMonValues
.getSfxPointer
	cp [hl]
	jr c, .gotSfxPointer
	inc c
	inc hl
	jr .getSfxPointer
.gotSfxPointer
	push bc
	ld a, $ff
	ld [wc0ee], a
	call PlaySoundWaitForCurrent
	pop bc
	ld b, $0
	ld hl, PokedexRatingSfxPointers
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld c, [hl]
	call PlayMusic
	jp PlayDefaultMusic

PokedexRatingSfxPointers: ; 7d162 (1f:5162)
	db (SFX_1f_51 - SFX_Headers_1f) / 3, BANK(SFX_1f_51)
	db (SFX_02_41 - SFX_Headers_02) / 3, BANK(SFX_02_41)
	db (SFX_02_3a - SFX_Headers_02) / 3, BANK(SFX_02_3a)
	db (SFX_08_46 - SFX_Headers_08) / 3, BANK(SFX_08_46)
	db (SFX_08_3a - SFX_Headers_08) / 3, BANK(SFX_08_3a)
	db (SFX_02_42 - SFX_Headers_02) / 3, BANK(SFX_02_42)
	db (SFX_02_3b - SFX_Headers_02) / 3, BANK(SFX_02_3b)

OwnedMonValues: ; 7d170 (1f:5170)
	db 10, 40, 60, 90, 120, 150, $ff


INCLUDE "audio/engine_3.asm"

SECTION "Audio Engine 31", ROMX, BANK[AUDIO_6]
INCLUDE "audio/engine.asm"

SECTION "Music 1", ROMX, BANK[AUDIO_1]
INCLUDE "audio/music/pkmnhealed.asm"
INCLUDE "audio/music/routes1.asm"
INCLUDE "audio/music/routes2.asm"
INCLUDE "audio/music/routes3.asm"
INCLUDE "audio/music/routes4.asm"
INCLUDE "audio/music/indigoplateau.asm"
INCLUDE "audio/music/pallettown.asm"
INCLUDE "audio/music/cities1.asm"
INCLUDE "audio/sfx/sfx_02_3a.asm"
INCLUDE "audio/music/museumguy.asm"
INCLUDE "audio/music/meetprofoak.asm"
INCLUDE "audio/music/meetrival.asm"
INCLUDE "audio/sfx/sfx_02_41.asm"
INCLUDE "audio/sfx/sfx_02_3b.asm"
INCLUDE "audio/sfx/sfx_02_42.asm"
INCLUDE "audio/music/ssanne.asm"
INCLUDE "audio/music/cities2.asm"
INCLUDE "audio/music/celadon.asm"
INCLUDE "audio/music/cinnabar.asm"
INCLUDE "audio/music/vermilion.asm"
INCLUDE "audio/music/lavender.asm"
INCLUDE "audio/music/evolution_gsc.asm"
INCLUDE "audio/music/gym.asm"
INCLUDE "audio/music/pokecenter.asm"


SECTION "Music 2", ROMX, BANK[AUDIO_2]
INCLUDE "audio/sfx/sfx_08_pokeflute.asm"
INCLUDE "audio/sfx/sfx_08_unused2.asm"
INCLUDE "audio/music/gymleaderbattle.asm"
INCLUDE "audio/music/trainerbattle.asm"
INCLUDE "audio/music/wildbattlekanto.asm"
INCLUDE "audio/music/finalbattle.asm"
INCLUDE "audio/sfx/sfx_08_3a.asm"
INCLUDE "audio/sfx/sfx_08_3b.asm"
INCLUDE "audio/sfx/sfx_08_46.asm"
INCLUDE "audio/music/defeatedtrainer.asm"
INCLUDE "audio/music/defeatedwildmon.asm"
INCLUDE "audio/music/defeatedgymleader.asm"


SECTION "Music 3", ROMX, BANK[AUDIO_3]
INCLUDE "audio/music/bikeriding.asm"
INCLUDE "audio/music/dungeon1.asm"
INCLUDE "audio/music/gamecorner.asm"
INCLUDE "audio/music/titlescreen.asm"
INCLUDE "audio/sfx/sfx_1f_3a.asm"
INCLUDE "audio/music/dungeon2.asm"
INCLUDE "audio/music/dungeon3.asm"
INCLUDE "audio/music/cinnabarmansion.asm"
INCLUDE "audio/sfx/sfx_1f_41.asm"
INCLUDE "audio/sfx/sfx_1f_3b.asm"
INCLUDE "audio/sfx/sfx_1f_42.asm"
INCLUDE "audio/music/oakslab.asm"
INCLUDE "audio/music/pokemontower.asm"
INCLUDE "audio/music/silphco.asm"
INCLUDE "audio/music/meeteviltrainer.asm"
INCLUDE "audio/music/meetfemaletrainer.asm"
INCLUDE "audio/music/meetmaletrainer.asm"
INCLUDE "audio/music/introbattle.asm"
INCLUDE "audio/music/surfing.asm"
INCLUDE "audio/music/jigglypuffsong.asm"
INCLUDE "audio/music/halloffame.asm"
INCLUDE "audio/music/credits.asm"

SECTION "Music 31", ROMX, BANK[AUDIO_6]
INCLUDE "audio/music/touhou3_select.asm"
INCLUDE "audio/music/oceandriesup.asm"

SECTION "Bank2ESFXpointers", ROMX, BANK[AUDIO_4]
INCBIN	"audio/BANK08_DUPLICATE_SFXPOINTERS.hex"
INCLUDE "audio/headers/musicheaders2e.asm"

SECTION "Bank2ESFXdata1", DATA[$42FD], BANK[AUDIO_4]
INCBIN	"audio/BANK08_DUPLICATE_ENGINEANDSFX1.hex"
INCLUDE "audio/music/finalbattle_gsc.asm"
INCLUDE "audio/music/haidenbattle.asm"
INCLUDE "audio/music/unusedsong_redux.asm"
INCLUDE "audio/music/specialbattle.asm"
INCLUDE "audio/music/hoennchamp.asm"
INCLUDE "audio/music/halloffame_gsc.asm"

SECTION "Bank2ESFXdata2", DATA[$7479], BANK[AUDIO_4]
INCBIN	"audio/BANK08_DUPLICATE_ENGINEANDSFX2.hex"

SECTION "Bank2FSFXpointers", ROMX, BANK[AUDIO_5]
INCBIN	"audio/BANK08_DUPLICATE_SFXPOINTERS.hex"
INCLUDE "audio/headers/musicheaders2f.asm"

SECTION "Bank2FSFXdata1", DATA[$42FD], BANK[AUDIO_5]
INCBIN	"audio/BANK08_DUPLICATE_ENGINEANDSFX1.hex"
INCLUDE "audio/music/wcs.asm"
INCLUDE "audio/music/gymleaderpinch.asm"
INCLUDE "audio/music/ToyWarrior.asm"
INCLUDE "audio/music/masked.asm"

SECTION "Bank2FSFXdata2", DATA[$7479], BANK[AUDIO_5]
INCBIN	"audio/BANK08_DUPLICATE_ENGINEANDSFX2.hex"
INCLUDE "audio/music/ptcg_clubbattle.asm"

SECTION "PCM Data 1", ROMX, BANK[PCM_1]
HmmHmm_PCM::
	dw (HmmHmm_PCM_End - HmmHmm_PCM) / 16 
	INCBIN "yellow_pcm/jf/HMMHMM.gbw"
HmmHmm_PCM_End:

Ou_PCM::
	dw (Ou_PCM_End - Ou_PCM) / 16 
	INCBIN "yellow_pcm/jf/OU.gbw"
Ou_PCM_End: