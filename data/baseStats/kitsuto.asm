KitsutoBaseStats:
db DEX_KITSUTO; pokedex id
db 102 ; base hp
db 111 ; base attack
db 90 ; base defense
db 123 ; base speed
db 100 ; base special
db NORMAL ; species type 1
db FLYING ; species type 2
db 3 ; catch rate
db 145 ; base exp yield
INCBIN "pic/bmon/kitsuto.pic",0,1 ; 77, sprite dimensions
dw KitsutoPicFront
dw KitsutoPicBack
; attacks known at lvl 0
db TACKLE
db GROWL
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
