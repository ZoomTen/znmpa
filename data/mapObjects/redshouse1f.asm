RedsHouse1FObject: ; 481e4 (12:41e4)
	db $0A ; border block

	db $3 ; warps
	db $7, $2, $0, $FF ; exit1
	db $7, $3, $0, $FF ; exit2
	db $1, $7, $0, REDS_HOUSE_2F ; staircase

	db $1 ; signs
	db $1, $3, $3 ; TV

	db $2 ; people
	map_spr_event SPRITE_LUMI, 4, 5, SPR_NOMOVE, $D2, 0, 1
	map_spr_event SPRITE_JINX, 5, 5, SPR_NOMOVE, $D2, 0, 2

	; warp-to
	EVENT_DISP REDS_HOUSE_1F_WIDTH, $7, $2
	EVENT_DISP REDS_HOUSE_1F_WIDTH, $7, $3
	EVENT_DISP REDS_HOUSE_1F_WIDTH, $1, $7
