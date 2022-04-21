_OakSpeechText1::
;	      XXXXXXXXXXXXXXXX
	text "Hello there!"
	
	para "Welcome to the"
	line "world of #MON!"
	
	para "My name is"
	line "PROF.OAK."
	
	para "Everyone knows"
	line "me as the"
	cont "#MON PROF.!"
	prompt

_OakSpeechText2A::
	;     XXXXXXXXXXXXXXXX
	text "What in the"
	line "world is THAT?!@@"

_OakSpeechText2B::
	db $00
	db $51
	;     XXXXXXXXXXXXXXXX
	db   "Er-hem, as I was"
	line "saying..."
	para "In this world,"
	line "live creatures"
	cont "known as #MON."
	
	para "To some people,"
	line "#MON are pets."

	para "Some people use"
	line "it for fights."

	para "As for myself..."
	
	para "I study #MON"
	line "as a profession."
	prompt

_IntroduceRivalText::
	text "Who's this little"
	line "fellow you're"
	cont "carrying along?"

	para "I believe ", $53
	line "was his name?"

	para "He seems to be"
	line "a nice person!"
	prompt

_OakSpeechText3::
	text "So ", $52, "."

	para "Ready for the"
	line "big adventure?"
	;     XXXXXXXXXXXXXXXX
	para "An exciting jour-"
	line "ney with #MON"
	cont "awaits!"
	para "See you at my"
	line "LAB!"
	done

