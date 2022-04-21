Route6LinkObject: ; 0x1e247 (size=42)
	db $43 ; border block

	db $2 ; warps
	db $6, $2, $2, ROUTE6_GATE2
	db $7, $2, $3, ROUTE6_GATE2

	db $0 ; signs

	db $1 ; people
	db SPRITE_GUARD, $1 + 4, $2 + 4, $ff, $d0, $1 ; person

	; warp-to
	EVENT_DISP ROUTE_6_LINK_WIDTH, $6, $2
	EVENT_DISP ROUTE_6_LINK_WIDTH, $7, $2
