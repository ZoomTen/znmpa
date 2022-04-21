GlaceonBaseStats:
db DEX_GLACEON ; pokedex id
db 65 ; base hp
db 60 ; base attack
db 110 ; base defense
db 130 ; base speed
db 120 ; base special
db ICE ; species type 1
db ICE ; species type 2
db 45 ; catch rate
db 184 ; base exp yield
INCBIN "pic/bmon/glaceon.pic",0,1 ; 77, sprite dimensions
dw GlaceonPicFront
dw GlaceonPicBack
; attacks known at lvl 0
db TACKLE
db TAIL_WHIP
db 0
db 0
db 0 ; growth rate
; learnset
db %10100100
db %01000011
db %00111000
db %11000000
db %00000011
db %00001000
db %00000110
db 0 ; padding
