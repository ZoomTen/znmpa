INCLUDE "constants.asm"

SECTION "GBS Header", ROM0 [$3e00]
GBSHeader:
	db "GBS" ; magic
	db 1 ; version
	db 58 ; no. of songs
	db 1 ; first song
	dw GBSMain
	dw GBSMain
	dw GBSPlay
	dw wStack
	db 0
	db 0
.Title:
	db "Zilo and Monty"
	ds .Title-@+32
.Author:
	db "ZoomTen"
	ds .Author-@+32
.Copyright:
	db "2015 ZoomTen"
	ds .Copyright-@+32

SECTION "GBS Main", ROM0[$3e70]
GBSMain:
; _PlayMusicEntry
	add a
	ld c, a
	xor a
	ld b, a
	ld hl, MusicEntries
	add hl, bc
	ld a, [hli]
	ld c, a
	ld a, [hl]
;PlayMusic:: ; 23a1 (0:23a1)
	ld b, a
	ld [wc0ee], a
	xor a
	ld [wMusicHeaderPointer], a
	ld a, c
	ld [wc0ef], a
	ld [wc0f0], a
	ld a, b
;PlaySound:: ; 23b1 (0:23b1)
	push hl
	push de
	push bc
	ld b, a
	ld a, [wc0ee]
	and a
	jr z, .asm_23c8
	xor a
	ld [wc02a], a
	ld [wc02b], a
	ld [wc02c], a
	ld [wc02d], a
.asm_23c8
	ld a, [wMusicHeaderPointer]
	and a
	jr z, .asm_23e3
	ld a, [wc0ee]
	and a
	jr z, .asm_2425
	xor a
	ld [wc0ee], a
	ld a, [wcfca]
	cp $ff
	jr nz, .asm_2414
	xor a
	ld [wMusicHeaderPointer], a
.asm_23e3
	xor a
	ld [wc0ee], a
	ld a, [H_LOADEDROMBANK]
	ld [$ffb9], a
	ld a, [wc0ef]
	ld [H_LOADEDROMBANK], a
	ld [$2000], a
	cp BANK(Func_9876)
	jr nz, .checkForBank08
	ld a, b
	call Func_9876
	jr .asm_240b
.checkForBank08
	cp BANK(Func2_9876)
	jr z, .bank31ye
	cp BANK(Func_22035)
	jr nz, .bank8dup
	ld a, b
	call Func_22035
	jr .asm_240b
.bank8dup				; !!!
	cp $4
	jr c, .bank1F
	ld a, b
	call $5B8D	;hard-coded Func_22035
	jr .asm_240b
.bank1F
	cp BANK(Func_7d8ea)
	ld a, b
	call Func_7d8ea
	jr .asm_240b
.bank31ye
	ld a, b
	call Func2_9876
.asm_240b
	ld a, [$ffb9]
	ld [H_LOADEDROMBANK], a
	ld [$2000], a
	jr .asm_2425
.asm_2414
	ld a, b
	ld [wcfca], a
	ld a, [wMusicHeaderPointer]
	ld [wcfc8], a
	ld [wcfc9], a
	ld a, b
	ld [wMusicHeaderPointer], a
.asm_2425
	pop bc
	pop de
	pop hl
	ret
GBSPlay:
	ld a, [wc0ef] ; music ROM bank
	ld [H_LOADEDROMBANK], a
	ld [MBC1RomBank], a
	cp BANK(Music2_UpdateMusic)
	jr nz, .notbank2
.bank2
	call Music2_UpdateMusic
	ret
.notbank2
	cp BANK(Music31_UpdateMusic)
	jr z, .music31
	cp BANK(Music8_UpdateMusic)
	jr nz, .bank8duplicate
.bank8
	call Music8_UpdateMusic
	ret
.bank8duplicate				;!!!
	cp $4
	jr c, .bank1F
	call $53D1	;hard-coded Music8_UpdateMusic
	ret
.bank1F
	call Music1f_UpdateMusic
	ret
.music31
	call Music31_UpdateMusic

INCLUDE "data/musicentries.asm"
