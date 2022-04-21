; BATTEM (Battle Emulator), aka a really dumb decoding thing.

; Mapping of BATTEM variables:
; 	wBattemVars:
;		bits 0 - 3 = first number (trainer/pkmn ID)
;		bit 4      = External index?
; 	wBattemVars+1:
;		bits 4 - 7 = second number (trainer/pkmn ID)
;		bits 0 - 3 = third number (trainer instance / pkmn level div 6)
; 	wBattemVars+2:
;		bits 4 - 6 = used for check
;		bits 0 - 3 = cursor position
; 	wBattemVars+3:
;		backup of wBattemVars+2

BattemMenu_Main::
	hlCoord 1, $e
	ld de, BattemInstructions
	call PlaceString
.printarrow
	hlCoord 8, 7
	ld a, [wBattemVars+2]		; get relative arrow position
	add a, l
	ld l, a
	ld a, $C0			; load arrow tile
	ld [hl], a			; place tile
.printmodevar
	hlCoord 8, 6
	ld a, [wBattemVars]
	bit 4, a			; check if the external index bit is set
	jr nz, .printletterX		; if it is, print "X"	(for external index)
	ld a, "I"			; else, print "I" (for internal index)
	ld [hli],a			; next character
	jr .printfirstletter
.printletterX
	ld a, "X"
	ld [hli],a			; next character
.printfirstletter
	ld a, [wBattemVars]		; first letter
	res 4, a			; clear bit locally
	add a, $80			; convert into alphabet
	ld [hli],a			; next character
.printsecondletter
	ld a, [wBattemVars+1]		; second letter
	and a, %11110000		; only fetch the higher bits
	swap a				; convert into alphabet
	add a, $80
	ld [hli],a			; next character
.printthirdletter
	ld a, [wBattemVars+1]		; third letter
	and a, %00001111		; only fetch lower bits
	add a, $80			; convert into alphabet
	ld [hl],a			; done

BattemMenu_GetJoypad:
	call JoypadLowSensitivity	; get joypad
	ld a,[hJoy5]
	ld b,a
	and a,%11111011 ; any key besides select pressed?
	jr z,BattemMenu_GetJoypad
	bit 0,b ; A button pressed?
	jr nz,BattemMenu_Confirm
	bit 1,b ; B button pressed?
	jr nz,BattemMenu_Exit
	jr BattemMenu_CheckDPAD
	
BattemMenu_Exit:
	xor a				; clear variables
	ld [wBattemVars], a
	ld [wBattemVars+1], a
	ld [wBattemVars+2], a
	ret
	
BattemMenu_Confirm:
	jp BattemConfirmScreen		; EVERYBODY F***ING JUMP!
	
BattemMenu_CheckDPAD:
	bit 5,b ; Left pressed?
	jp nz,.pressedLeft
	bit 6,b ; Up pressed?
	jp nz,.pressedUp
	bit 7,b ; Down pressed?
	jp nz,.pressedDown
	jp .pressedRight
	
.pressedLeft
	call BattemMenu_BlankOutArrowTile
	ld a, [wBattemVars+2]
	and a				; check if zero
	jr nz, .contleft		
	ld a, 3				; set cursor position to max
	ld [wBattemVars+2], a
	jp BattemMenu_Main		; refresh view
.contleft
	dec a
	ld [wBattemVars+2], a
	jp BattemMenu_Main		; refresh view
	
.pressedRight
	call BattemMenu_BlankOutArrowTile
	ld a, [wBattemVars+2]
	cp 3				; check if we're at max
	jr nz, .contright
	xor a				; clear cursor position
	ld [wBattemVars+2], a
	jp BattemMenu_Main		; refresh view
.contright
	inc a
	ld [wBattemVars+2], a
	jp BattemMenu_Main		; refresh view
	
.pressedUp
	ld a, [wBattemVars+2]		; load cursor position
	and a
	jp z, .changeindexflag
	cp 1
	jp z, .firstup
	cp 2
	jp z, .secondup
	cp 3
	jp z, .thirdup
	jp BattemMenu_Main
	
.changeindexflag
	ld a, [wBattemVars]
	bit 4, a			; is bit 4 set?
	jr nz, .resetindexbit		; reset if it is
	set 4, a			; otherwise, set bit 4
	jr .indexcont
.resetindexbit
	res 4, a
.indexcont
	ld [wBattemVars], a
	jp BattemMenu_Main
	
.firstup
	ld a, [wBattemVars]		; load first byte 
	ld b, a				; save for later
	res 4, a
	xor a, %00001111		; check if maximum
	ld a, b				; reload saved byte
	jr nz, .firstcont		; if we're not on maximum, keep incrementing
	ld a, [wBattemVars]		; reload byte
	res 0, a			; clear all first number bits
	res 1, a
	res 2, a
	res 3, a
	ld [wBattemVars], a
	jp BattemMenu_Main		; refresh
.firstcont
	inc a
	ld [wBattemVars], a
	jp BattemMenu_Main		; refresh
	
.secondup
	ld a, [wBattemVars+1]		; load second byte (second number)
	ld b, a
	res 0, a			; clear all lower bits
	res 1, a
	res 2, a
	res 3, a
	xor a, %11110000		; check if maximum
	ld a, b
	jr nz, .secondcont		; if not, keep adding
	ld a, [wBattemVars+1]
	res 4, a			; clear all second number bits
	res 5, a
	res 6, a
	res 7, a
	ld [wBattemVars+1], a
	jp BattemMenu_Main		; refresh
.secondcont
	add a, %00010000		; add byte
	ld [wBattemVars+1], a
	jp BattemMenu_Main		; refresh
	
.thirdup
	ld a, [wBattemVars+1]		; load second byte (third number)
	ld b, a
	res 4, a			; clear all higher bits
	res 5, a
	res 6, a
	res 7, a
	xor a, %00001111		; check if maximum
	ld a, b
	jr nz, .thirdcont		; if not, keep incrementing
	ld a, [wBattemVars+1]
	res 0, a			; clear all third number bits
	res 1, a
	res 2, a
	res 3, a
	ld [wBattemVars+1], a
	jp BattemMenu_Main		; refresh
.thirdcont
	inc a
	ld [wBattemVars+1], a
	jp BattemMenu_Main		; refresh
	
.pressedDown
	ld a, [wBattemVars+2]		; load cursor position
	and a
	jp z, .changeindexflag
	cp 1
	jp z, .firstdown
	cp 2
	jp z, .seconddown
	cp 3
	jp z, .thirddown
	jp BattemMenu_Main
	
.firstdown
	ld a, [wBattemVars]		; load first byte 
	ld b, a				; save for later
	res 4, a
	and a				; check if zero
	ld a, b
	jr nz, .firstcont2		; if not, keep decrementing
	set 3, a			; set all first number bits
	set 2, a
	set 1, a
	set 0, a
	ld [wBattemVars], a
	jp BattemMenu_Main		; refresh
.firstcont2
	dec a
	ld [wBattemVars], a
	jp BattemMenu_Main		; refresh
	
.seconddown
	ld a, [wBattemVars+1]		; load second byte (second number)
	ld b, a
	res 0, a			; clear all lower bits
	res 1, a
	res 2, a
	res 3, a
	and a				; check if zero
	ld a, b
	jr nz, .secondcont2		; if not, keep subtracting
	set 4, a			; set all second number bits
	set 5, a
	set 6, a
	set 7, a
	ld [wBattemVars+1], a
	jp BattemMenu_Main		; refresh
.secondcont2
	sub a, %00010000
	ld [wBattemVars+1], a
	jp BattemMenu_Main		; refresh
	
.thirddown
	ld a, [wBattemVars+1]		; load second byte (third number)
	ld b, a
	res 4, a			; clear all higher bits
	res 5, a
	res 6, a
	res 7, a
	and a				; check if zero
	ld a, b
	jr nz, .thirdcont2		; if not, keep decrementing
	set 0, a			; set all third number bits
	set 1, a
	set 2, a
	set 3, a
	ld [wBattemVars+1], a
	jp BattemMenu_Main		; refresh
.thirdcont2
	dec a
	ld [wBattemVars+1], a
	jp BattemMenu_Main		; refresh
	
BattemMenu_BlankOutArrowTile:
	hlCoord 8, 7
	ld a, [wBattemVars+2]		; get relative cursor position
	add a, l			; get actual position
	ld l, a
	ld a, $7f			; blank tile
	ld [hl], a			; clear current tile
	ret
	
BattemConfirmScreen:
	ld hl, BattemConfirmText
	call PrintText
	hlCoord 14, 7
	ld bc,$080f
	ld a,TWO_OPTION_MENU
	ld [wTextBoxID],a
	call DisplayTextBoxID		; yes/no menu
	ld a,[wCurrentMenuItem]
	and a				; selected yes?
	jr z,BattemExecuteBattle	; execute battle if we do
	hlCoord 1, $d			; else we clear message box
	ld c, $11
	ld b, 3
	call ClearScreenArea
	jp BattemMenu_Main		; and go back to the beginning
	
BattemExecuteBattle:
; Code-checking function.

; Checks code to a table which defines
; illegal codes.

;	ld a, [wBattemVars+2]		; saves the cursor byte
;	ld [wBattemVars+3], a		; since it's going to be used for error-checking bits
;	hlCoord 8,6			; we're gonna read from tile buffers
;	ld de, BattemIllegalCodes	; and look up a huge-ass table of illegal codes
;.first
;	ld a, [hl]			; read first tile character
;	ld b, a				; save it
;	ld a, [de]			; read first error character
;	cp a, b				; compare
;	jp nz, .second			; if it isn't the same, jump to second check
;	ld a, [wBattemVars+2]		
;	set 4, a			; set first error bit
;	ld [wBattemVars+2],a
;.second
;	inc hl				; move to the next tile character
;	inc de				; move to the next error character
;	ld a, [hl]			; do the same shit
;	ld b, a
;	ld a, [de]
;	cp a, b
;	jp nz, .third
;	ld a, [wBattemVars+2]
;	set 5, a			; set second bit
;	ld [wBattemVars+2],a
;.third
;	inc hl				; ditto
;	inc de
;	ld a, [hl]
;	ld b, a
;	ld a, [de]
;	cp a, b
;	jp nz, .checkagain		; this time, we jump to the real error check
;	ld a, [wBattemVars+2]
;	set 6, a			; set third bit
;.checkagain
;	ld [wBattemVars+2],a		; load byte
;	res 0,a				; clear lower bits
;	res 1,a
;	res 2,a
;	res 3,a
;	xor a, %01110000		; all error bits set?
;	jp z, .error			; state an error
;	ld a, [wBattemVars+2]		; if not
;	res 4,a				; reset all bits to check errors again
;	res 5,a
;	res 6,a
;	res 7,a
;	ld [wBattemVars+2],a
;	hlCoord 8,6
;	inc de				; read next error byte
;	ld a, [de]
;	cp "@"				; check if we've reached the end of table
;					; (in other words, no results found)
;	jr z, .pass			; execute battle
;	jp .first			; scan table again if we aren't
	
.pass					; if no errors found
	ld a, [wBattemVars]
	bit 4, a			; is "external index" bit set?
	jr nz, .externalindex		; jump if we do
	jr .fetchopponent
.externalindex
	ld a, $FF
	ld [W_CUROPPONENT],a
.fetchopponent				; parses second and third numbers to form
					; pokemon/trainer ID
	ld a, [wBattemVars]
	and a, %00001111		; read first number
	swap a				; move to high nybble
	ld b, a
	ld a, [wBattemVars+1]
	and a, %11110000		; read second number
	swap a				; move to lower nybble
	add a,b				; form the ID
	ld b, a
	ld a, [wBattemVars]		; read from first byte
	bit 4, a			; external bit set?
	ld a, b
	jr z, .storeinternal		; store in W_CUROPPONENT if it isn't
	ld [wSecondTrainerIndex],a	; else, store in wSecondTrainerIndex
	jr .loadinstance		; parse index
.storeinternal
	ld [W_CUROPPONENT],a
.loadinstance
	cp $C8				; check for seperator
	jr c, .wildpoke			; if lower, make it load wild pkmn level instead
	ld a, [wBattemVars+1]
	and a, %00001111		; grab instance number
	inc a				; make it start from 1
	ld [W_TRAINERNO],a		; store
	jr .done			; finished
.wildpoke
	ld a, [wBattemVars+1]
	and a, %00001111		; grab level
	inc a				; make it start from 1
	ld [H_MULTIPLICAND+2], a
	ld a, 6
	ld [H_MULTIPLIER], a
	call Multiply			; multiply by 6
	ld a, [H_PRODUCT+3]		; take product
	ld [W_CURENEMYLVL], a		; store
	
.done
	ld hl, BattemDoneText
	call PrintText
	jp BattemMenu_Exit
	
;.error
;	ld hl, BattemErrorText
;	call PrintText
;	ld a,[wBattemVars+3]
;	ld [wBattemVars+2], a		; restore backed up byte
;	xor a				; clear backup
;	ld [wBattemVars+3], a
;	hlCoord 1, $d
;	ld c, $11
;	ld b, 3
;	call ClearScreenArea
;	jp BattemMenu_Main

BattemInstructions:
;	         XXXXXXXXXXXXXXXXXX
	db	"A to confirm"
	next	"B to cancel"
	done
	
BattemConfirmText:
	text	"Is this correct?"
	done
;	         XXXXXXXXXXXXXXXXX	
BattemDoneText:
	text	"The battle will"
	line	"initiate once the"
	cont	"start menu is"
	cont	"closed."
	prompt
	
;BattemErrorText:
;	text	"Illegal code!"
;	line	"Please try"
;	cont	"another one."
;	prompt
	
;INCLUDE "data/battem_invalid_codes.asm"