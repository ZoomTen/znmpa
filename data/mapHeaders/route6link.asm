Route6_Link_h:
	db OVERWORLD ; tileset
	db ROUTE_6_LINK_HEIGHT, ROUTE_6_LINK_WIDTH ; dimensions (y, x)
	dw Route6LinkBlocks, Route6LinkTextPointers, Route6LinkScript
	db SOUTH | WEST ; connections
	SOUTH_MAP_CONNECTION VERMILION_CITY, VERMILION_CITY_WIDTH, -5, 0, VERMILION_CITY_WIDTH, VermilionCityBlocks, ROUTE_6_LINK_WIDTH, ROUTE_6_LINK_HEIGHT
	WEST_MAP_CONNECTION ROUTE_6, ROUTE_6_WIDTH, 0, 16, ROUTE_6_HEIGHT, Route6Blocks, ROUTE_6_LINK_WIDTH
	dw Route6LinkObject ; objects
