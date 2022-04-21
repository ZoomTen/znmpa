; Raw PCM playback
; (c)1997 Jeff Frohwein

; Definition includes

	INCLUDE "yellow_pcm/jf/gbhw-snd.inc"

PlayPCMSample::
	ld a,[H_LOADEDROMBANK]
	ld [wROMBANKBACKUP], a
	ld a, b
	call PCM_BankSwitch	; do a bankswitch
	
        ld      a,[hl+]         ;get sample length
        ld      c,a
        ld      a,[hl+]
        ld      b,a

        ld      a,AUDENA_ON
        ldh      [rAUDENA],a      ;enable sound

	
        ld      a,AUD3ENA_OFF
        ldh     [rAUD3ENA],a
	ld	a,AUDTERM_OFF
        ldh     [rAUDTERM],a

	ld	a,0
	SETAUDIOVOLSO1	7		; MAX VOLUME CHANNEL 1
	SETAUDIOVOLSO2	7		; MAX VOLUME CHANNEL 2
        ldh     [rAUDVOL],a		; select speakers
        ld      a,AUDTERMALLTOBOTH
        ldh     [rAUDTERM],a       ;ENABLE ALL 4 SOUND CIRCUITS TO BOTH CHANNELS

        SETAUD3LEN	80
        ldh     [rAUD3LEN],a       ;sound length
        ld	a,AUD3LEVFULL
        ldh     [rAUD3LEVEL],a       ;sound level high

        SETAUDLOWHZ	512
        ldh     [rAUD3LOW],a       ;sound freq low

.samp2:
        ld      de,$FF30 ;12
        push    bc              ;16
        ld      b,16            ;16

        ld	a,AUD3ENA_OFF
        ldh     [rAUD3ENA],a
.samp3:
        ld      a,[hl+]         ;8
        ld      [de],a          ;8
        inc     de              ;8
        dec     b               ;4
        jr      nz,.samp3       ;12

        ld      a,AUD3ENA_ON
        ldh     [rAUD3ENA],a

	SETAUDHIGHHZ	512	; SET FREQ TO 512 Hz
	or	AUD1RESTART
        ldh     [rAUD3HIGH],a


        ld      bc,558          ;delay routine
.samp4:
        dec     bc              ;8
        ld      a,b             ;4
        or      c               ;4
        jr      nz,.samp4       ;12

        ld      a,0             ;more delay
        ld      a,0
        ld      a,0

        pop     bc              ;12
        dec     bc              ;8
        ld      a,b             ;4
        or      c               ;4
        jr      nz,.samp2       ;12

        ld      a,AUDTERMALLTOBOTH  & ~AUDTERM3TOS02  & ~AUDTERM3TOS01
        ldh     [rAUDTERM],a       ;disable sound 3

	ld a, [wROMBANKBACKUP]
	call PCM_BankSwitch	; bankswitch back
	xor a
	ld a, [wROMBANKBACKUP]
	ret
	
PCM_BankSwitch:
	ld [H_LOADEDROMBANK],a
	ld [$2000],a
	ret 