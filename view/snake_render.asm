;===========================================================
; snake_render.asm
;
; Routines to display snake object in screen
;===========================================================

;-----------------------------------------------------------
; Render snake at PosX,PosY
;-----------------------------------------------------------
RenderSnake:
  ldx PosX
  ldY PosY
  stx $0203
  sty $0200
  lda #$00
RenderTailLoop:
  cmp Size
  beq RenderTailDone
  pha
  rol a
  rol a ;multiply by 4
  ; ToDo continue copying position data
RenderTailDone:
  rts