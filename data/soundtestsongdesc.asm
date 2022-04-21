SoundTestSongDescriptions:
	dw ST_NullSongDescription	; 000
	dw ST_NullSongDescription	; 001
	dw ST_NullSongDescription	; 002
	dw ST_NullSongDescription	; 003
	dw ST_NullSongDescription	; 004
	dw ST_NullSongDescription	; 005
	dw ST_NullSongDescription	; 006
	dw ST_NullSongDescription	; 007
	dw ST_Song008Description	; 008
	dw ST_NullSongDescription	; 009
	dw ST_NullSongDescription	; 010
	dw ST_NullSongDescription	; 011
	dw ST_NullSongDescription	; 012
	dw ST_PortSongDescription	; 013
	dw ST_NullSongDescription	; 014
	dw ST_NullSongDescription	; 015
	dw ST_NullSongDescription	; 016
	dw ST_NullSongDescription	; 017
	dw ST_NullSongDescription	; 018
	dw ST_NullSongDescription	; 019
	dw ST_NullSongDescription	; 020
	dw ST_NullSongDescription	; 021
	dw ST_Song022Description	; 022
	dw ST_Song023Description	; 023
	dw ST_NullSongDescription	; 024
	dw ST_PortSongDescription	; 025
	dw ST_Song026Description	; 026
	dw ST_NullSongDescription	; 027
	dw ST_NullSongDescription	; 028
	dw ST_NullSongDescription	; 029
	dw ST_NullSongDescription	; 030
	dw ST_NullSongDescription	; 031
	dw ST_PortSongDescription	; 032
	dw ST_NullSongDescription	; 033
	dw ST_NullSongDescription	; 034
	dw ST_NullSongDescription	; 035
	dw ST_NullSongDescription	; 036
	dw ST_NullSongDescription	; 037
	dw ST_Song038Description	; 038
	dw ST_NullSongDescription	; 039
	dw ST_NullSongDescription	; 040
	dw ST_NullSongDescription	; 041
	dw ST_NullSongDescription	; 042
	dw ST_Song043Description	; 043
	dw ST_NullSongDescription	; 044
	dw ST_NullSongDescription	; 045
	dw ST_NullSongDescription	; 046
	dw ST_NullSongDescription	; 047
	dw ST_Song048Description	; 048
	dw ST_Song049Description	; 049
	dw ST_NullSongDescription	; 050
	dw ST_Song051Description	; 051
	dw ST_Song052Description	; 052
	dw ST_NullSongDescription	; 053
	dw ST_NullSongDescription	; 054
	dw ST_NullSongDescription	; 055
	dw ST_NullSongDescription	; 056
	dw ST_NullSongDescription	; 057
	
ST_NullSongDescription:
	db	"No description"
	next	"given."
	done

ST_PortSongDescription:
	db	"This song is"
	next	"converted into"
	next	"R/B/G/Y format"
	next	"from another game."
	done

ST_Song008Description:
	;	 XXXXXXXXXXXXXXXXXX
	db	"HIGH FREQUENCIES"
	next	"MAKE YOU GO KILL"
	next	"URSELF XDDDD"
	next	" "
	next	"...Really?"
	done
	
ST_Song022Description:
	;	 XXXXXXXXXXXXXXXXXX
	db	"Originally I"
	next	"wanted to use my"
	next	"own battle theme,"
	next	"but I figured,"
	next	"it's KANTO. Also I"
	next	"fixed a loop bug."
	done
	
ST_Song023Description:
	;	 XXXXXXXXXXXXXXXXXX
	db	"I don't even know"
	next	"what this will be"
	next	"used for. Maybe"
	next	"for LUMI's rematch"
	next	"theme?"
	done
	
ST_Song026Description:
	;	 XXXXXXXXXXXXXXXXXX
	db	"Used in HAIDEN's"
	next	"secret battle."
	done

ST_Song038Description:
	;	 XXXXXXXXXXXXXXXXXX
	db	"This theme. It's"
	next	"freaking. Epic."
	done
	
ST_Song043Description:
	;	 XXXXXXXXXXXXXXXXXX
	db	"get spook'd"
	next	"white hands."
	next	"buried alive."
	next	"ghost model."
	next	"dat vibrato tho"
	done
	
ST_Song048Description:
	;	 XXXXXXXXXXXXXXXXXX
	db	"This song is just"
	next	"amazing. I fixed"
	next	"it, because it"
	next	"needs it. :3"
	next	"Yes, it's unused."
	done
	
ST_Song049Description:
	;	 XXXXXXXXXXXXXXXXXX
	db	"This song is left"
	next	"unused for now."
	next	"It sounds really"
	next	"messed up,"
	next	"especially beyond"
	next	"the loop point!"
	done
	
ST_Song051Description:
	;	 XXXXXXXXXXXXXXXXXX
	db	"Yay for #MID!"
	next	"Used in THETA's"
	next	"rematch battle."
	done
	
ST_Song052Description:
	;	 XXXXXXXXXXXXXXXXXX
	db	"According to the"
	next	"OST, the official"
	next	"name of this track"
	next	"is 'Victory Lies"
	next	"Before You!' but"
	next	"it couldn't fit."
	done