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
  ldx #$00
  ldy #$00
RenderTailLoop:
  cmp Size
  beq RenderTailDone
  pha ;Backup tail part counter
  lda Tail,x ;Load x coordinate
  pha 
  inx
  lda Tail,x ;Load y coordinate
  sta $0208,y
  iny
  lda #$01 ;Set tail sprite
  sta $0208,y
  iny
  lda #$02 ;Set tail palette
  sta $0208,y
  iny
  pla
  sta $0208,y
  iny
  pla
  stx Temp
  tax
  inx
  txa
  ldx Temp
  jmp RenderTailLoop
RenderTailDone:
  rts