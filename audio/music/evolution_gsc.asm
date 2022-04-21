Music_SafariZone_Ch1: ; f06ed
	tempo 132
	volume 7, 7
	vibrato 6, 3, 4
	toggleperfectpitch
	duty 2
	notetype 12, 9, 2
	octave 3
	pitchbend 0, $4a
	C_ 1
	pitchbend 0, $4a
	G_ 1
	pitchbend 0, $4a
	C_ 1
	pitchbend 0, $4a
	G_ 1
	rest 4
	duty 3
Music_Evolution_branch_f0713: ; f0713
	callchannel Music_Evolution_branch_f0737
	notetype 12, 10, 4
	F# 4
	callchannel Music_Evolution_branch_f0737
	notetype 12, 10, 4
	F# 4
	loopchannel 2, Music_Evolution_branch_f0713
	callchannel Music_Evolution_branch_f0743
	notetype 12, 10, 4
	G# 4
	callchannel Music_Evolution_branch_f0743
	notetype 12, 10, 4
	G# 4
	loopchannel 0, Music_Evolution_branch_f0713
; f0737

Music_Evolution_branch_f0737: ; f0737
	notetype 12, 10, 2
	octave 3
	C_ 4
	G_ 4
	C_ 4
	G_ 4
	C_ 4
	G_ 4
	C_ 4
	endchannel
; f0743

Music_Evolution_branch_f0743: ; f0743
	notetype 12, 10, 2
	octave 3
	D_ 4
	A_ 4
	D_ 4
	A_ 4
	D_ 4
	A_ 4
	D_ 4
	endchannel
; f074f

Music_SafariZone_Ch2: ; f074f
	duty 2
	vibrato 8, 2, 5
	notetype 12, 10, 2
	octave 4
	G_ 1
	D_ 1
	G_ 1
	D_ 1
	rest 4
	duty 3
Music_Evolution_branch_f0761: ; f0761
	callchannel Music_Evolution_branch_f0787
	notetype 12, 11, 5
	A_ 4
	callchannel Music_Evolution_branch_f0787
	notetype 12, 11, 5
	B_ 4
	loopchannel 2, Music_Evolution_branch_f0761
	callchannel Music_Evolution_branch_f0793
	notetype 12, 11, 5
	B_ 4
	callchannel Music_Evolution_branch_f0793
	notetype 12, 11, 5
	octave 4
	C# 4
	octave 3
	loopchannel 0, Music_Evolution_branch_f0761
; f0787

Music_Evolution_branch_f0787: ; f0787
	notetype 12, 11, 2
	octave 3
	G_ 4
	D_ 4
	G_ 4
	D_ 4
	G_ 4
	D_ 4
	G_ 4
	endchannel
; f0793

Music_Evolution_branch_f0793: ; f0793
	notetype 12, 11, 2
	octave 3
	A_ 4
	E_ 4
	A_ 4
	E_ 4
	A_ 4
	E_ 4
	A_ 4
	endchannel
; f079f

Music_SafariZone_Ch3: ; f079f
	notetype 12, 1, 1
	rest 8
Music_Evolution_branch_f07a3: ; f07a3
	callchannel Music_Evolution_branch_f07bf
	octave 3
	A_ 4
	callchannel Music_Evolution_branch_f07bf
	octave 3
	B_ 4
	loopchannel 2, Music_Evolution_branch_f07a3
	callchannel Music_Evolution_branch_f07d5
	octave 3
	B_ 4
	callchannel Music_Evolution_branch_f07d5
	octave 4
	C# 4
	loopchannel 0, Music_Evolution_branch_f07a3
; f07bf

Music_Evolution_branch_f07bf: ; f07bf
	octave 2
	A_ 2
	rest 2
	octave 3
	D_ 2
	rest 2
	octave 2
	A_ 2
	rest 2
	octave 3
	D_ 2
	rest 2
	octave 2
	A_ 2
	rest 2
	octave 3
	D_ 2
	rest 2
	octave 2
	A_ 2
	rest 2
	endchannel
; f07d5

Music_Evolution_branch_f07d5: ; f07d5
	octave 2
	B_ 2
	rest 2
	octave 3
	E_ 2
	rest 2
	octave 2
	B_ 2
	rest 2
	octave 3
	E_ 2
	rest 2
	octave 2
	B_ 2
	rest 2
	octave 3
	E_ 2
	rest 2
	octave 2
	A_ 2
	rest 2
	endchannel
; f07eb

Music_SafariZone_Ch4: ; f07eb
	dspeed 12
	rest 8
Music_Evolution_branch_f07f0: ; f07f0
	stereopanning %11010110
	mutedsnare4 6
	mutedsnare4 4
	stereopanning %01011110
	mutedsnare2 2
	mutedsnare2 2
	mutedsnare2 2
	loopchannel 0, Music_Evolution_branch_f07f0
; f07fd


