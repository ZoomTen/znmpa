; battletheme.flp

Music_SpecialBattle_Ch1:
	tempo 112
	volume 7, 7
	duty 3
	vibrato 6, 3, 4
	toggleperfectpitch
	notetype 12, 11, 5
	octave 4
	B_ 1
	A# 1
	A_ 1
	G# 1
	G_ 1
	F# 1
	F_ 1
	E_ 1
	D# 1
	D_ 1
	C# 1
	C_ 1
	octave 3
	B_ 1
	A# 1
	A_ 1
	G# 1
	octave 4
	D_ 8
	C# 4
	F# 2
	D_ 2 
.pattern1
	callchannel Music_SpecialBattle_Ch1_sub0
	F# 2
	rest 2
	callchannel Music_SpecialBattle_Ch1_sub0
	F# 2
	G_ 1
	A_ 1	
	callchannel Music_SpecialBattle_Ch1_sub1
	F# 2
	D_ 1
	C# 1
	callchannel Music_SpecialBattle_Ch1_sub1
	A_ 2
	rest 2
.looppoint
	callchannel Music_SpecialBattle_Ch1_sub2
	B_ 6
	octave 4
	D_ 6
	C# 4
	F# 2
	rest 4
	D_ 2
	rest 4
	F# 2
	rest 2
	callchannel Music_SpecialBattle_Ch1_sub2
	B_ 6
	octave 4
	D_ 6
	octave 3
	A_ 4
	octave 4
	C_ 6
	C# 6
	octave 3
	A_ 4
	F# 16
	E_ 16
	A_ 12
	B_ 4
	octave 4
	C# 4
	octave 3
	B_ 8
	G_ 1
	A_ 1
	B_ 1
	A_ 1
	F# 2
	rest 2
	F# 2
	rest 2
	F# 2
	rest 2
	F# 2
	rest 2
	G_ 2
	rest 2
	G_ 2
	rest 2
	G_ 2
	rest 2
	G_ 2
	E_ 2
	A_ 2
	rest 2
	A_ 2
	rest 2
	A_ 2
	rest 2
	A_ 2
	rest 2
	B_ 2
	rest 2
	B_ 2
	rest 2
	B_ 2
	rest 2
	G_ 1
	A_ 1
	B_ 1
	octave 4
	C# 1
	octave 3
	D_ 16
	E_ 6
	D_ 6
	E_ 2
	C# 2
	F# 16
	G_ 12
	E_ 1
	F# 1
	G_ 1
	F# 1
	D_ 16
	E_ 6
	D_ 6
	E_ 2
	C# 2
	F# 16
	G_ 12
	B_ 4
	F# 6
	G_ 6
	F# 4
	loopchannel 0, .pattern1
	
Music_SpecialBattle_Ch1_sub0:
	octave 2
	B_ 2
	rest 4
	octave 3
	D_ 2
	rest 4
	C# 2
	rest 2
	F# 2
	rest 4
	D_ 2
	rest 4
	endchannel

Music_SpecialBattle_Ch1_sub1:
	octave 3
	B_ 2
	rest 4
	octave 4
	D_ 2
	rest 4
	C# 2
	rest 2
	F# 2
	rest 4
	D_ 2
	rest 4
	endchannel

Music_SpecialBattle_Ch1_sub2:
	octave 3
	F# 4
	D_ 2
	octave 2
	B_ 4
	octave 3
	D_ 2
	F# 4
	G_ 4
	F# 2
	E_ 4
	F# 2
	G_ 4
	endchannel
	
Music_SpecialBattle_Ch2:
	duty 3
	vibrato 10, 2, 5
	notetype 12, 12, 5
	octave 3
	F# 4
	rest 2
	G_ 4
	rest 2
	F# 4
	A_ 4
	rest 2
	F# 4
	rest 2
	A# 2
	B_ 2
.pattern1
	octave 2
	F# 2
	rest 4
	A_ 2
	rest 4
	F# 2
	rest 2
	octave 3
	D_ 2
	rest 4
	octave 2
	B_ 2
	rest 4
	octave 3
	D_ 2
	rest 2
	loopchannel 2, .pattern1
.pattern2
	octave 3
	F# 2
	rest 4
	A_ 2
	rest 4
	F# 2
	rest 2
	octave 4
	D_ 2
	rest 4
	octave 3
	B_ 2
	rest 4
	octave 4
	D_ 2
	rest 2
	loopchannel 2, .pattern2
.looppoint
	callchannel Music_SpecialBattle_Ch2_sub0
	F# 6
	F# 6
	A_ 2
	G_ 2
	F# 6
	E_ 6
	F# 4
	callchannel Music_SpecialBattle_Ch2_sub0
	octave 4
	F# 6
	F# 6
	F# 4
	G_ 6
	F# 6
	C# 4
	octave 3
	B_ 6
	A_ 6
	B_ 4
	G_ 6
	F# 6
	G_ 4
	E_ 6
	D_ 6
	E_ 4
	A_ 4
	G_ 4
	F# 4
	E_ 4
	B_ 6
	A_ 6
	B_ 4
	octave 4
	C# 6
	octave 3
	B_ 6
	octave 4
	C# 4
	D_ 6
	octave 3
	B_ 6
	octave 4
	D_ 4
	E_ 4
	D_ 4
	C# 4
	E_ 4
	F# 6
	E_ 6
	F# 4
	D_ 6
	C# 6
	D_ 4
	octave 3
	B_ 6
	A_ 6
	B_ 4
	octave 4
	E_ 4
	D_ 4
	C# 4
	octave 3
	B_ 4
	octave 4
	F# 6
	E_ 6
	F# 4
	G_ 6
	F# 6
	G_ 4
	A_ 6
	F# 6
	A_ 4
	B_ 4
	A_ 4
	G_ 4
	B_ 2
	A_ 2
	F# 16
.beforeloop
	octave 2
	F# 2
	rest 4
	A_ 2
	rest 4
	F# 2
	rest 2
	octave 3
	D_ 2
	rest 4
	octave 2
	B_ 2
	rest 4
	octave 3
	D_ 2
	rest 2
	octave 2
	F# 2
	rest 4
	A_ 2
	rest 4
	F# 2
	rest 2
	octave 3
	D_ 2
	rest 4
	octave 2
	B_ 2
	rest 4
	octave 3
	D_ 2
	octave 2
	F# 2
.end
	octave 3
	F# 2
	rest 2
	octave 2
	A_ 2
	octave 3
	A_ 2
	rest 2
	octave 2
	F# 2
	octave 3
	F# 2
	D_ 2
	octave 4
	D_ 2
	rest 2
	octave 2
	B_ 2
	octave 3
	B_ 2
	rest 2
	octave 3
	D_ 2
	octave 4
	D_ 2
	octave 2
	F# 2
	loopchannel 2, .end
	loopchannel 0, .looppoint
	
Music_SpecialBattle_Ch2_sub0:
	octave 3
	B_ 6
	F# 6
	octave 4
	D_ 2
	C# 2
	octave 3
	B_ 4
	octave 4
	C# 4
	octave 3
	A_ 4
	B_ 4
	endchannel
	
Music_SpecialBattle_Ch3:
	vibrato 0, 2, 0
	notetype 12, 1, 4
	octave 2
	F# 16
	G# 8
	F# 2
	G_ 2
	A_ 2
	octave 3
	C# 2
.loop0
	octave 2
	rest 2
	F# 2
	loopchannel 7, .loop0
	G_ 2
	G_ 2
.loop1
	octave 2
	rest 2
	F# 2
	loopchannel 7, .loop1
	G_ 2
	A_ 2
.loop2
	octave 1
	B_ 2
	octave 2
	F# 2
	loopchannel 7, .loop2
	G_ 2
	G_ 2
.loop3
	octave 1
	B_ 2
	octave 2
	F# 2
	loopchannel 7, .loop3
	G_ 2
	D_ 2
.looppoint
	callchannel Music_SpecialBattle_Ch3_sub0
	octave 1
	B_ 2
	octave 2
	F# 2
	octave 1
	B_ 2
	octave 2
	F# 2
	octave 1
	B_ 2
	octave 2
	F# 2
	octave 1
	B_ 2
	octave 2
	E_ 2
	callchannel Music_SpecialBattle_Ch3_sub0
	octave 2
	C_ 2
	G_ 2
	C_ 2
	G_ 2
	C# 2
	G_ 2
	C# 2
	G_ 2
.loop4
	octave 2
	D_ 2
	F# 2
	D_ 2
	F# 2
	D_ 2
	F# 2
	D_ 2
	octave 1
	B_ 2
	octave 2
	D_ 2
	G_ 2
	D_ 2
	G_ 2
	D_ 2
	G_ 2
	D_ 2
	octave 1
	B_ 2
	octave 2
	E_ 2
	A_ 2
	E_ 2
	A_ 2
	E_ 2
	A_ 2
	E_ 2
	A_ 2
	F# 2
	B_ 2
	F# 2
	B_ 2
	F# 2
	B_ 2
	F# 2
	B_ 2
	loopchannel 2, .loop4
	G_ 16
	A_ 16
	F# 16
	B_ 4
	A_ 4
	G_ 4
	E_ 4
	F# 16
	G_ 16
	A_ 16
	B_ 4
	A_ 4
	G_ 4
	B_ 4
.loop5
	octave 1
	F# 2
	octave 2
	F# 2
	loopchannel 4, .loop5
.loop6
	octave 1
	B_ 2
	octave 2
	F# 2
	loopchannel 7, .loop6
	G_ 2
	G_ 2
.loop7
	octave 1
	B_ 2
	octave 2
	F# 2
	loopchannel 7, .loop7
	G_ 2
	D_ 2
	loopchannel 0, .loop2
	
Music_SpecialBattle_Ch3_sub0:
	octave 1
	B_ 2
	octave 2
	F# 2
	octave 1
	B_ 2
	octave 2
	F# 2
	octave 1
	B_ 2
	octave 2
	F# 2
	octave 1
	B_ 2
	octave 2
	F# 2
	octave 1
	B_ 2
	octave 2
	G_ 2
	octave 1
	B_ 2
	octave 2
	G_ 2
	octave 1
	B_ 2
	octave 2
	G_ 2
	octave 1
	B_ 2
	octave 2
	A_ 2
	octave 1
	B_ 2
	octave 2
	F# 2
	octave 1
	B_ 2
	octave 2
	F# 2
	octave 1
	B_ 2
	octave 2
	F# 2
	octave 1
	B_ 2
	octave 2
	F# 2
	endchannel
	
Music_SpecialBattle_Ch4:
	dspeed 12
	snare1 8
	snare1 8
	snare1 8
	snare1 8
	snare1 8
	snare1 8
	snare1 8
	snare1 4
	snare1 4
	loopchannel 0, Music_SpecialBattle_Ch4
