KitsarushiBaseStats:
db DEX_KITSARUSHI ; pokedex id
db 70 ; base hp
db 80 ; base attack
db 45 ; base defense
db 70 ; base speed
db 45 ; base special
db NORMAL ; species type 1
db NORMAL ; species type 2
db 3 ; catch rate
db 70 ; base exp yield
INCBIN "pic/bmon/kitsarushi.pic",0,1 ; 77, sprite dimensions
dw KitsarushiPicFront
dw KitsarushiPicBack
; attacks known at lvl 0
db TACKLE
db LEER
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
