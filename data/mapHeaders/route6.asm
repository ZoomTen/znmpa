Route6_h: ; 0x58000 to 0x58022 (34 bytes) (id=17)
	db OVERWORLD ; tileset
	db ROUTE_6_HEIGHT, ROUTE_6_WIDTH ; dimensions (y, x)
	dw Route6Blocks, Route6TextPointers, Route6Script ; blocks, texts, scripts
	db NORTH | EAST ; connections
	NORTH_MAP_CONNECTION SAFFRON_CITY, SAFFRON_CITY_WIDTH, SAFFRON_CITY_HEIGHT, -3, 2, SAFFRON_CITY_WIDTH - 4, SaffronCityBlocks
	EAST_MAP_CONNECTION ROUTE6_LINK, ROUTE_6_LINK_WIDTH, 16, 0, ROUTE_6_LINK_HEIGHT, Route6LinkBlocks, ROUTE_6_WIDTH
	dw Route6Object ; objects
