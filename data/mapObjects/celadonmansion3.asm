CeladonMansion3Object: ; 0x487ff (size=72)
	db $f ; border block

	db $4 ; warps
	db $1, $6, $0, CELADON_MANSION_2
	db $1, $7, $0, CELADON_MANSION_4
	db $1, $2, $1, CELADON_MANSION_4
	db $1, $4, $3, CELADON_MANSION_2

	db $5 ; signs
	db $3, $0, $5 ; CeladonMansion3Text5
	db $3, $1, $5 ; CeladonMansion3Text5
	db $3, $3, $2 ; CeladonMansion3Text6
	db $3, $4, $2 ; CeladonMansion3Text6
	db $9, $4, $3 ; CeladonMansion3Text8

	db $1 ; people
	db SPRITE_LAPRAS_GIVER, $3 + 4, $2 + 4, $ff, $ff, $4 ; person

	; warp-to
	EVENT_DISP CELADON_MANSION_3_WIDTH, $1, $6 ; CELADON_MANSION_2
	EVENT_DISP CELADON_MANSION_3_WIDTH, $1, $7 ; CELADON_MANSION_4
	EVENT_DISP CELADON_MANSION_3_WIDTH, $1, $2 ; CELADON_MANSION_4
	EVENT_DISP CELADON_MANSION_3_WIDTH, $1, $4 ; CELADON_MANSION_2
