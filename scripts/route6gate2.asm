Route6Gate2Script: ; 1e1c7 (7:61c7)
	jp EnableAutoTextBoxDrawing

Route6Gate2TextPointers: ; 59b84 (16:5b84)
	dw Route6Gate2Text1

Route6Gate2Text1:
;	      XXXXXXXXXXXXXXXXXX
	text "I'm on guard duty."
	para "Lucky for you, the"
	line "road's open."
	para "Drinks? No, thank"
	line "you. I don't feel"
	cont "thirsty."
	done
