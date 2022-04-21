VermilionCity_h: ; 0x18998 to 0x189ba (34 bytes) (bank=6) (id=5)
	db OVERWORLD ; tileset
	db VERMILION_CITY_HEIGHT, VERMILION_CITY_WIDTH ; dimensions (y, x)
	dw VermilionCityBlocks, VermilionCityTextPointers, VermilionCityScript ; blocks, texts, scripts
	db NORTH | EAST ; connections
	NORTH_MAP_CONNECTION ROUTE6_LINK, ROUTE_6_LINK_WIDTH, ROUTE_6_LINK_HEIGHT, 5, 0, ROUTE_6_LINK_WIDTH, Route6LinkBlocks
	EAST_MAP_CONNECTION ROUTE_11, ROUTE_11_WIDTH, 4, 0, ROUTE_11_HEIGHT, Route11Blocks, VERMILION_CITY_WIDTH
	dw VermilionCityObject ; objects
