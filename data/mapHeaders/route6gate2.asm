Route6_Gate2_h:
	db GATE ; tileset
	db ROUTE_8_GATE_HEIGHT, ROUTE_8_GATE_WIDTH ; dimensions (y, x)
	dw Route6Gate2Blocks, Route6Gate2TextPointers, Route6Gate2Script
	db $00 ; connections
	dw Route6Gate2Object ; objects
