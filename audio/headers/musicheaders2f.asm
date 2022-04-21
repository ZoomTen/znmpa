Music_WCSBattle::
	db ( $80 | CH0 )
	dw WCS_Ch1
	db CH1
	dw WCS_Ch2
	db CH2
	dw WCS_Ch3
	
Music_GymLeaderPinch::
	db ( $80 | CH0 )
	dw Pinch_Ch1
	db CH1
	dw Pinch_Ch2
	db CH2
	dw Pinch_Ch3
	
Music_MaskedBattle::
	db ( $80 | CH0 )
	dw MaskedBattle_Ch1
	db CH1
	dw MaskedBattle_Ch2
	db CH2
	dw MaskedBattle_Ch3
	
Music_ToyWarrior::
	db ( $C0 | CH0 )
	dw Music_ToyWarrior_Ch1
	db CH1
	dw Music_ToyWarrior_Ch2
	db CH2
	dw Music_ToyWarrior_Ch3
	db CH3
	dw Music_ToyWarrior_Ch4
	
Music_ClubBattle::
	db $80
	dw ClubBattle_Ch1
	db CH1
	dw ClubBattle_Ch2
	db CH2
	dw ClubBattle_Ch3