;=================================================================
;
; Snake game
;
; Jacinto Mba Cantero <github.com/jacmba>
; 2020
;
;=================================================================


  .inesprg 1
  .ineschr 1
  .inesmir 1
  .inesmap 0

  .bank 0
  .org $8000

Reset:
  sei
  cld

Clearmem:
  ;Clear registers
  lda #$00
  tax
  tay

  jsr Initialize ;Initialize player object

VBlankWait1:
  bit $2002
  bpl VBlankWait1

VBlankWait2:
  bit $2002
  bpl VBlankWait2

PPUSetup:
  lda #%10000000 ;Enable NMI
  sta $2000

  lda #%00010000 ;Enable sprite rendering
  sta $2001

PaletteSetup:
  lda $2002
  lda #$3F
  sta $2006
  lda #$10
  sta $2006

  ldx #$00
LoadPaletteLoop:
  lda PaletteData,x
  sta $2007
  inx
  cpx #$20
  bne LoadPaletteLoop

  ldx #$00
LoadSpriteLoop:
  lda Sprite,x
  sta $0200,x
  inx
  cpx #$04
  bne LoadSpriteLoop

MainLoop:
  jmp MainLoop

Nmi:
  ;Setup DMA
  lda #$00
  sta $2003
  lda #$02
  sta $4014

  rti

  .include "model/snake.asm"

  .bank 1
  .org $E000
PaletteData:
  .incbin "res/sprites_pal.dat"
  
Sprite:
  .byte $80, $00, $00, $80

  .org $FFFA
  .word Nmi, Reset, 0

  .bank 2
  .org $0000
  .incbin "res/sprites.chr"
