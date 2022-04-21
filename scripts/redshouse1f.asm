RedsHouse1FScript: ; 48168 (12:4168)
	jp EnableAutoTextBoxDrawing

RedsHouse1FTextPointers: ; 4816b (12:416b)
	dw RedsHouse1FText1
	dw RedsHouse1FText2
	dw RedsHouse1FText3

RedsHouse1FText1:
	TX_FAR _LumiArriveText
	db "@"

RedsHouse1FText2:
	TX_FAR _JinxArriveText
	db "@"

RedsHouse1FText3: ; 0x481c6 TV
	db 8
	ld a,[wSpriteStateData1 + 9]
	cp 4
	ld hl,TVWrongSideText
	jr nz,.done ; if player is not facing up
	ld hl,StandByMeText
.done
	call PrintText
	jp TextScriptEnd

StandByMeText: ; 481da (12:41da)
	TX_FAR _StandByMeText
	db "@"

TVWrongSideText: ; 481df (12:41df)
	TX_FAR _TVWrongSideText
	db "@"
