; sometimes it's necessary to add $C8 to these values
YOUNGSTER     EQU $01
BUG_CATCHER   EQU $02
LASS          EQU $03
SAILOR        EQU $04
JR__TRAINER_M EQU $05
JR__TRAINER_F EQU $06
POKEMANIAC    EQU $07
SUPER_NERD    EQU $08
HIKER         EQU $09
BIKER         EQU $0A
BURGLAR       EQU $0B
ENGINEER      EQU $0C
JUGGLER_X     EQU $0D
FISHER        EQU $0E
SWIMMER       EQU $0F
CUE_BALL      EQU $10
GAMBLER       EQU $11
BEAUTY        EQU $12
PSYCHIC_TR    EQU $13
ROCKER        EQU $14
JUGGLER       EQU $15
TAMER         EQU $16
BIRD_KEEPER   EQU $17
BLACKBELT     EQU $18
SONY1         EQU $19
PROF_OAK      EQU $1A
CHIEF         EQU $1B
SCIENTIST     EQU $1C
GIOVANNI      EQU $1D
ROCKET        EQU $1E
COOLTRAINER_M EQU $1F
COOLTRAINER_F EQU $20
BRUNO         EQU $21
BROCK         EQU $22
MISTY         EQU $23
LT__SURGE     EQU $24
ERIKA         EQU $25
KOGA          EQU $26
BLAINE        EQU $27
SABRINA       EQU $28
GENTLEMAN     EQU $29
SONY2         EQU $2A
SONY3         EQU $2B	; Theta
LORELEI       EQU $2C
CHANNELER     EQU $2D
AGATHA        EQU $2E
LANCE         EQU $2F
LUMI          EQU $30
JINX          EQU $31
HAIDEN        EQU $32
MOCHA	      EQU $33
TRON_SILVUMI  EQU $34
MWAH	      EQU $35
MASKEDLUMI    EQU $36
INDEX2	      EQU $37	; FF, used to call second index

; to battle these trainers $FF needs to be set in W_CUROPPONENT
; these values need to be written in wSecondTrainerIndex
; actual trainer ID is (constant + $37)
JONIC	      EQU $00