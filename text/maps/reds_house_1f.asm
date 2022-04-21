_LumiArriveText::
;	      XXXXXXXXXXXXXXXXXX
	text "LUMI: Hi ", $52, "!"
	line "We decided to"
	cont "travel around this"
	cont "region for a while"
	cont "and we thought"
	cont "everything is nice"
	cont "here!"
	para "We're staying at"
	line "your house to take"
	cont "a quick rest if"
	cont "that's okay with"
	cont "you."
;	      XXXXXXXXXXXXXXXXXX
	done

_JinxArriveText::
;	      XXXXXXXXXXXXXXXXX
	text "JINX: Hello,"
	line $52, "!"
	done

_MomHealText1::
IF DEF(_YELLOW)
	text "MOM: ",$52,", if"
	line "your drive your"
	cont "#MON too hard,"
	cont "they'll dislike"
	cont "you."

	para "You should take a"
	line "rest."
	prompt
ELSE
	text "MOM: ",$52,"!"
	line "You should take a"
	cont "quick rest."
	prompt
ENDC

_MomHealText2::
	text "MOM: Oh good!"
	line "You and your"
	cont "#MON are"
	cont "looking great!"
	cont "Take care now!"
	done

_StandByMeText::
;	      XXXXXXXXXXXXXXXXXX
	text "There's a movie"
	line "on TV. A strange"
	cont "-looking rat is"		; LITTLE KING JOHN
	cont "searching for land"
	cont "to build his new"
	cont "kingdom."

	para "I better go too."
	done

_TVWrongSideText::
;	      XXXXXXXXXXXXXXXXXX
	text "I can't see a"		; literal translation
	line "thing! Oh, wait,"		; from Pokemon R/G
	cont "I'm looking at the"
	cont "wrong side."
	done

