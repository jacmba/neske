;===========================================================
; apple_render.asm
;
; Routines to display apple in screen
;===========================================================

;-----------------------------------------------------------
; Render apple sprite at AppleX,AppleY position
;-----------------------------------------------------------
RenderApple:
  ldx AppleX
  ldy AppleY
  stx $2007
  sty $2004
  rts
