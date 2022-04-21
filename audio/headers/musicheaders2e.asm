Music_GSC_ChampBattle::
	db ( $80 | CH0 )
	dw Music_ChampionBattle_Ch1
	db CH1
	dw Music_ChampionBattle_Ch2
	db CH2
	dw Music_ChampionBattle_Ch3
	
Music_Unused::
	db ( $80 | CH0 )
	dw Music_UnusedSong_Ch1
	db CH1
	dw Music_UnusedSong_Ch2
	db CH2
	dw Music_UnusedSong_Ch3

Music_HaidenBattle::			; Dragon Fight (Fairy Tail)
	db ( $80 | CH0 )
	dw Music_HaidenBattle_Ch1
	db CH1
	dw Music_HaidenBattle_Ch2
	db CH2
	dw Music_HaidenBattle_Ch3
	
Music_SpecialBattle::
	db ( $80 | CH0 )
	dw Music_SpecialBattle_Ch1
	db CH1
	dw Music_SpecialBattle_Ch2
	db CH2
	dw Music_SpecialBattle_Ch3

Music_StevenBattle::
	db ( $80 | CH0 )
	dw HoennChamp_Ch1
	db CH1
	dw HoennChamp_Ch2
	db CH2
	dw HoennChamp_Ch3

Music_HallOfFame2::
	db ( $C0 | CH0 )
	dw Music_HallOfFame2_Ch1
	db CH1
	dw Music_HallOfFame2_Ch2
	db CH2
	dw Music_HallOfFame2_Ch3
	db CH3
	dw Music_HallOfFame2_Ch4