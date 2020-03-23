Initialize:

PosX:
  .byte $80
PosY:
  .byte $80
Size:
  .byte $00
Direction:
  .byte $01
Speed:
  .byte $01

  rts

Move:
  ldx Direction
  cpx #$01
  beq MoveRight
  cpx #$02
  beq MoveUp
  cpx #$03
  beq MoveLeft
  cpx #$04
  beq MoveDown
  rts
MoveRight:
  lda PosX
  clc
  adc Speed
  sta PosX
  rts
MoveUp:
  lda PosY
  sec
  sbc Speed
  sta PosY
  rts
MoveLeft:
  lda PosX
  sec
  sbc Speed
  sta PosX
  rts
MoveDown:
  lda PosY
  clc
  adc Speed
  sta PosX
  rts
