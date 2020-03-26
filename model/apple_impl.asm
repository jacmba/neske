;===========================================================
; apple_impl.asm
;
; Apple model implementation routines
;===========================================================

;-----------------------------------------------------------
; Initialize apple object
;-----------------------------------------------------------
InitApple:
  ldx #$E0
  ldy #$20
  stx AppleX
  sty AppleY
  rts

;-----------------------------------------------------------
; Set screen opposite position for apple
;-----------------------------------------------------------
RespawnApple:
  lda AppleX
  clc
  adc #$80
  sta AppleX
  lda AppleY
  clc
  adc #$80
  sta AppleY
  rts
