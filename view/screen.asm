;===========================================================
;
; Screen utility routines
;===========================================================

;-----------------------------------------------------------
; Clear screen by setting 0xFF in all DMA memory
;-----------------------------------------------------------
ClearScreen:
  ldx #$00
  lda #$FF
ClsLoop:
  sta $0200,x
  inx
  cpx #$FF
  bne ClsLoop
  rts
  
;-----------------------------------------------------------
; Wait for VBlank signal
;-----------------------------------------------------------
WaitVBlank:
  bit $2002
  bpl WaitVBlank
  rts

;-----------------------------------------------------------
;Display current score on screen
;-----------------------------------------------------------
RenderScore:
  lda #$08
  sta $0208
  sta $020C
  lda #$03
  clc
  adc ScoreTens
  sta $0209
  lda #$00
  sta $020A
  sta $020E
  lda #$78
  sta $020B
  lda #$03
  clc
  adc ScoreUnits
  sta $020D
  lda #$80
  sta $020F
  rts
