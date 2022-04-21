RexPumkinBaseStats: ; 39286 (e:5286)
db DEX_REX_PUMKIN ; pokedex id
db 65 ; base hp
db 65 ; base attack
db 60 ; base defense
db 130 ; base speed
db 110 ; base special
db NORMAL ; species type 1
db NORMAL ; species type 2
db 255 ; catch rate
db 255 ; base exp yield
INCBIN "pic/bmon/pumkin.pic",0,1 ; 77, sprite dimensions
dw RexPumkinPicFront
dw RexPumkinPicBack
db TACKLE
db GROWL
db LOVELY_KISS
db HYPER_BEAM
db 0 ; growth rate
; learnset
db %10100000
db %01000011
db %10001000
db %11000001
db %11000011
db %00011000
db %01000010
db 0 ; padding
