_Route6JinxWannaBattle:: ; 8dc38 (23:5c38)
	text "JINX: Hey buddy!"
	para "Yes, we're"
	line "#MON trainers"
	cont "now!"
	para "Wanna battle?"
	done

_Route6JinxYes:: ; 8dc38 (23:5c38)
	text "I'll take you"
	line "down!"
	done

_Route6JinxNo:: ; 8dc38 (23:5c38)
	text "Maybe another"
	line "time, sorry!"
	done

_Route6JinxAlreadyBattled:: ; 8dc38 (23:5c38)
	text "JINX: I'm going"
	line "to be the very"
	cont "best! Like no one"
	cont "ever was..."
	done

_Route6LumiWannaBattle:: ; 8dc38 (23:5c38)
	text "LUMI: Hello"
	line $52, "!"
	para "Guess who just"
	line "became trainers?"
	para "That's right!"
	para "We want to see"
	line "how good we are,"
	cont "care for a battle?"
	done

_Route6LumiYes:
	text "YUS!"
	done

_Route6LumiNo:
	text "Aww, maybe next"
	line "time."
	done

_Route6LumiEndBattle:
	text "Yep, we"
	line "need to practice"
	cont "more."
	prompt

_Route6JinxEndBattle:
	text "Well, looks"
	line "like I'll have to"
	cont "try harder, then!"
	prompt

_Route6LumiAlreadyBattled:
	text "LUMI: Ooooouuuuuuh"
	line "moooooouuuuuuuuuh"
	para $52, ": Ooooooooooooooooooooouuuuuuuuuuuuuuuuh moooooooooooooooooouuuuuuuuuuuuuh"
	para "LUMI: STAHP STAHP"
	line "YOU'RE OVERFLOW-"
	cont "ING THE TEXT BOX"
	cont "XDDDDDD"
	done
