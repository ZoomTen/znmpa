Route6LinkScript: ; 1e1c7 (7:61c7)
	ld a, HS_ROUTE6_LUMI
	ld [wcc4d], a
	predef HideObject
	jp EnableAutoTextBoxDrawing

Route6LinkTextPointers: ; 59b84 (16:5b84)
	dw Route6LinkText1

Route6LinkText1:
	text "Object event."
	para "Haha, just kid-"
	line "ding! I ain't a"
	cont "weirdo!" 
	done
