Music_Lavender_Ch1:: ; bb58 (2:7b58)
	tempo 152
Music_Lavender_notempo:
	volume 7, 7
	duty 1
	toggleperfectpitch
	vibrato 0, 8, 8
	notetype 12, 8, 7
.rest	
	rest 16
	loopchannel 4, .rest
	notetype 12, 10, 7

Music_Lavender_branch_bb6b::
	octave 3
	callchannel Music_Lavender_B1
	G_ 8
	G_ 8
	F# 8
	F# 8
	B_ 4
	G_ 4
	F# 4
	B_ 4
	octave 4
	C_ 8
	C_ 8
	octave 3
	callchannel Music_Lavender_B1
	G_ 8
	G_ 8
	F# 8
	F# 8
	B_ 4
	G_ 4
	F# 4
	B_ 4
	C_ 8
	C_ 8
.rest	rest 16
	loopchannel 4, .rest
	loopchannel 0, Music_Lavender_branch_bb6b


Music_Lavender_Ch2:: ; bb9e (2:7b9e)
	vibrato 0, 3, 4
	duty 3
	notetype 12, 9, 1

Music_Lavender_branch_bba5::
	octave 5
	C_ 4
	G_ 4
	B_ 4
	F# 4
	loopchannel 0, Music_Lavender_branch_bba5


Music_Lavender_Ch3:: ; bbae (2:7bae)
	vibrato 4, 1, 1
	notetype 12, 3, 5
.rest
	rest 16
	loopchannel 4, .rest
	notetype 12, 2, 5

Music_Lavender_branch_bbb9::
.loop1
	octave 4
	E_ 16
	D_ 16
	C_ 16
	E_ 4
	C_ 4
	octave 3
	B_ 4
	octave 4
	E_ 4
	loopchannel 4, .loop1
; LEL LAVENDER TOWN FREQUENCY XDDDDDDDDD
	notetype 12, 3, 5
	octave 6
	callchannel Music_Lavender_B2
	notetype 12, 2, 5
	callchannel Music_Lavender_B2
	octave 7
	callchannel Music_Lavender_B2
	octave 4
	E_ 4
	G_ 4
	F# 4
	B_ 4
.loopykun
	E_ 16
	D_ 16
	C_ 16
	E_ 4
	C_ 4
	octave 3
	B_ 4
	octave 4
	E_ 4
	loopchannel 3, .loopykun
	notetype 12, 2, 5
	octave 6
	B_ 4
	G_ 4
	F# 4
	B_ 4
	octave 7
	B_ 4
	G_ 4
	F# 4
	B_ 4
	octave 8
	B_ 4
	G_ 4
	F# 4
	B_ 4
	octave 4
	E_ 4
	G_ 4
	F# 4
	B_ 4
	loopchannel 0, Music_Lavender_branch_bbb9


Music_Lavender_Ch4:: ; bc21 (2:7c21)
	dspeed 12
.rest	rest 16
	loopchannel 4, .rest

Music_Lavender_branch_bc26::
	triangle2 8
	loopchannel 0, Music_Lavender_branch_bc26
; 0xbc2e

Music_Lavender_B1:
	G_ 8
	G_ 8
	E_ 8
	E_ 8
	G_ 4
	F# 4
	E_ 4
	B_ 4
	C# 8
	C# 8
	endchannel

Music_Lavender_B2:
	B_ 4
	G_ 4
	F# 4
	B_ 4
	endchannel