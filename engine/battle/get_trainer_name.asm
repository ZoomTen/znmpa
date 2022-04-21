GetTrainerName_: ; 13a58 (4:7a58)
	ld hl, W_GRASSRATE
	ld a, [wLinkState]
	and a
	jr nz, .rival
	ld hl, W_RIVALNAME
	ld a, [W_TRAINERCLASS]
	cp SONY1
	jr z, .rival
	cp SONY2
	jr z, .rival
;	cp SONY3
;	jr z, .rival
	cp MOCHA
	jr z, .mocha
.normal
	ld [wd0b5], a
	ld a, TRAINER_NAME
	ld [wNameListType], a
	ld a, BANK(TrainerNames)
	ld [wPredefBank], a
	call GetName
	ld hl, wcd6d
.rival
	ld de, W_TRAINERNAME
	ld bc, $d
	jp CopyData
.mocha
	ld a, [W_ROUTE2CURSCRIPT]
	cp 3				; have we finished encountering Mocha on Route 2?
	jr nz, .loadunknown		; if we didn't, load "???" as Mocha's name
	ld a, [W_TRAINERCLASS]		; otherwise,
	jr .normal			; load Mocha's actual name
.loadunknown
	ld hl, W_TRAINERNAME
	ld a, "?"
	ld [hli],a
	ld [hli],a
	ld [hli],a			; load "???"
	ld a, "@"
	ld [hl],a
	ret