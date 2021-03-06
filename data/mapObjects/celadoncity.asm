CeladonCityObject: ; 0x18022 (size=189)
	db $f ; border block

	db $d ; warps
	db $d, $8, $0, CELADON_MART_1
	db $d, $a, $2, CELADON_MART_1
	db $9, $18, $0, CELADON_MANSION_1
	db $3, $18, $2, CELADON_MANSION_1
	db $3, $19, $2, CELADON_MANSION_1
	db $9, $29, $0, CELADON_POKECENTER
	db $1b, $c, $0, CELADON_GYM
	db $13, $1c, $0, GAME_CORNER
	db $13, $27, $0, CELADON_MART_5 ; beta warp! no longer used
	db $13, $21, $0, CELADON_PRIZE_ROOM
	db $1b, $1f, $0, CELADON_DINER
	db $1b, $23, $0, CELADON_HOUSE
	db $1b, $2b, $0, CELADON_HOTEL

	db $9 ; signs
	db $f, $1b, $a ; CeladonCityText10
	db $f, $13, $b ; CeladonCityText11
	db $9, $2a, $c ; PokeCenterSignText
	db $1d, $d, $d ; CeladonCityText13
	db $9, $15, $e ; CeladonCityText14
	db $d, $c, $f ; CeladonCityText15
	db $15, $27, $10 ; CeladonCityText16
	db $15, $21, $11 ; CeladonCityText17
	db $15, $1b, $12 ; CeladonCityText18

	db $a ; people
	db SPRITE_LITTLE_GIRL, $11 + 4, $8 + 4, $fe, $0, $1 ; person
	db SPRITE_OLD_PERSON, $1c + 4, $b + 4, $ff, $d1, $2 ; person
	db SPRITE_GIRL, $13 + 4, $e + 4, $fe, $1, $3 ; person
	db SPRITE_OLD_PERSON, $16 + 4, $19 + 4, $ff, $d0, $4 ; person
	db SPRITE_OLD_PERSON, $10 + 4, $16 + 4, $ff, $d0, $5 ; person
	db SPRITE_FISHER2, $c + 4, $20 + 4, $ff, $d2, $6 ; person
	db SPRITE_SLOWBRO, $c + 4, $1e + 4, $ff, $d3, $7 ; person
	db SPRITE_ROCKET, $1d + 4, $20 + 4, $fe, $2, $8 ; person
	db SPRITE_ROCKET, $e + 4, $2a + 4, $fe, $2, $9 ; person
	db SPRITE_OLD_PERSON, $c + 4, $11 + 4, $fe, $d0, 19 ; person

	; warp-to
	EVENT_DISP CELADON_CITY_WIDTH, $d, $8 ; CELADON_MART_1
	EVENT_DISP CELADON_CITY_WIDTH, $d, $a ; CELADON_MART_1
	EVENT_DISP CELADON_CITY_WIDTH, $9, $18 ; CELADON_MANSION_1
	EVENT_DISP CELADON_CITY_WIDTH, $3, $18 ; CELADON_MANSION_1
	EVENT_DISP CELADON_CITY_WIDTH, $3, $19 ; CELADON_MANSION_1
	EVENT_DISP CELADON_CITY_WIDTH, $9, $29 ; CELADON_POKECENTER
	EVENT_DISP CELADON_CITY_WIDTH, $1b, $c ; CELADON_GYM
	EVENT_DISP CELADON_CITY_WIDTH, $13, $1c ; GAME_CORNER
	EVENT_DISP CELADON_CITY_WIDTH, $13, $27 ; CELADON_MART_5
	EVENT_DISP CELADON_CITY_WIDTH, $13, $21 ; CELADON_PRIZE_ROOM
	EVENT_DISP CELADON_CITY_WIDTH, $1b, $1f ; CELADON_DINER
	EVENT_DISP CELADON_CITY_WIDTH, $1b, $23 ; CELADON_HOUSE
	EVENT_DISP CELADON_CITY_WIDTH, $1b, $2b ; CELADON_HOTEL
