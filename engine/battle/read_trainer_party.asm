ReadTrainer: ; 39c53 (e:5c53)

; don't change any moves in a link battle
	ld a,[wLinkState]
	and a
	ret nz

; set [wEnemyPartyCount] to 0, [wEnemyPartyMons] to FF
; XXX first is total enemy pokemon?
; XXX second is species of first pokemon?
	ld hl,wEnemyPartyCount
	xor a
	ld [hli],a
	dec a
	ld [hl],a

; get the pointer to trainer data for this class
;	ld a,[W_CUROPPONENT]
;	cp $FF	; are we at the limit?
;	jr z, .secondtable
;.firsttable
;	sub $C9 ; convert value from pokemon to trainer
;	add a,a
;	ld hl,TrainerDataPointers
;	jr .continue
;.secondtable
;	ld a, [wSecondTrainerIndex]
;	add a, a
;	ld hl,TrainerDataPointers2
;.continue
	ld a,[W_TRAINERCLASS]
	dec a
	add a, a
	ld hl,TrainerDataPointers
	ld c,a
	ld b,0
	add hl,bc ; hl points to trainer class
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,[W_TRAINERNO]
	ld b,a
; At this point b contains the trainer number,
; and hl points to the trainer class.
; Our next task is to iterate through the trainers,
; decrementing b each time, until we get to the right one.
.outer
	dec b
	jr z,.IterateTrainer
.inner
	ld a,[hli]
	and a
	jr nz,.inner
	jr .outer

; if the first byte of trainer data is FF,
; - each pokemon has a specific level
;      (as opposed to the whole team being of the same level)
; - if [W_LONEATTACKNO] != 0, one pokemon on the team has a special move
; else the first byte is the level of every pokemon on the team
.IterateTrainer
	ld a,[hli]
	cp $FF ; is the trainer special?
	jr z,.SpecialTrainer ; if so, check for special moves
	ld [W_CURENEMYLVL],a
.LoopTrainerData
	ld a,[hli]
	and a ; have we reached the end of the trainer data?
	jr z,.FinishUp
	ld [wcf91],a ; write species somewhere (XXX why?)
	ld a,1
	ld [wcc49],a
	push hl
	call AddPartyMon
	pop hl
	jr .LoopTrainerData
.SpecialTrainer
; if this code is being run:
; - each pokemon has a specific level
;      (as opposed to the whole team being of the same level)
; - if [W_LONEATTACKNO] != 0, one pokemon on the team has a special move
	ld a,[hli]
	and a ; have we reached the end of the trainer data?
	jr z,.AddLoneMove
	ld [W_CURENEMYLVL],a
	ld a,[hli]
	ld [wcf91],a
	ld a,1
	ld [wcc49],a
	push hl
	call AddPartyMon
	pop hl
	jr .SpecialTrainer
.AddLoneMove
; does the trainer have a single monster with a different move
	ld a,[W_LONEATTACKNO] ; Brock is 01, Misty is 02, Erika is 04, etc
	and a
	jr z,.AddTeamMove
	dec a
	add a,a
	ld c,a
	ld b,0
	ld hl,LoneMoves
	add hl,bc
	ld a,[hli]
	ld d,[hl]
	ld hl,wEnemyMon1Moves + 2
	ld bc,wEnemyMon2 - wEnemyMon1
	call AddNTimes
	ld [hl],d
	jr .FinishUp
.AddTeamMove
; check if our trainer's team has special moves

; get trainer class number
	ld a,[W_TRAINERCLASS]
;	cp $FF
;	jr z, .secondindex
;	sub $C8
	ld b,a
	ld hl,TeamMoves
;	jr .IterateTeamMoves
;.secondindex
;	ld a,[wSecondTrainerIndex]
;	ld b,a
;	ld hl,TeamMoves
; iterate through entries in TeamMoves, checking each for our trainer class
.IterateTeamMoves
	ld a,[hli]
	cp b
	jr z,.GiveTeamMoves ; is there a match?
	inc hl ; if not, go to the next entry
	inc a
	jr nz,.IterateTeamMoves

; no matches found. is this trainer champion rival?
	ld a,b
	cp SONY3
	jr z,.ChampionRival
	jr .FinishUp ; nope
.GiveTeamMoves
	ld a,[hl]
	ld [wEnemyMon5Moves + 2],a
	jr .FinishUp
.ChampionRival ; give moves to his team

; pidgeot
	ld a,SKY_ATTACK
	ld [wEnemyMon1Moves + 2],a

; starter
	ld a,[W_RIVALSTARTER]
	cp STARTER3
	ld b,MEGA_DRAIN
	jr z,.GiveStarterMove
	cp STARTER1
	ld b,FIRE_BLAST
	jr z,.GiveStarterMove
	ld b,BLIZZARD ; must be squirtle
.GiveStarterMove
	ld a,b
	ld [wEnemyMon6Moves + 2],a
.FinishUp
; clear wAmountMoneyWon addresses
	xor a       
	ld de,wAmountMoneyWon
	ld [de],a
	inc de
	ld [de],a
	inc de
	ld [de],a
	ld a,[W_CURENEMYLVL]
	ld b,a
.LastLoop
; update wAmountMoneyWon addresses (money to win) based on enemy's level
	ld hl,wd047
	ld c,2 ; wAmountMoneyWon is a 3-byte number
	push bc
	predef AddBCDPredef
	pop bc
	inc de
	inc de
	dec b
	jr nz,.LastLoop ; repeat W_CURENEMYLVL times
	ret
