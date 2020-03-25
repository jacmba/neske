ReadController:
  lda #$01
  sta $4016
  lda #$00
  sta $4016

ReadA:
  lda $4016
ReadADone:

ReadB:
  lda $4016
ReadBDone:

ReadSelect:
  lda $4016
ReadSelectDone:

ReadStart:
  lda $4016
ReadStartDone:

ReadUp:
  lda $4016
  and #$01
  beq ReadUpDone
  ldx Direction
  cpx #$04
  beq ReadUpDone
  ldx #$02
  stx Direction
ReadUpDone:

ReadDown:
  lda $4016
  and #$01
  beq ReadDownDone
  ldx Direction
  cpx #$02
  beq ReadDownDone
  ldx #$04
  stx Direction
ReadDownDone:

ReadLeft:
  lda $4016
  and #$01
  beq ReadLeftDone
  ldx Direction
  cpx #$01
  beq ReadLeftDone
  ldx #$03
  stx Direction
ReadLeftDone:

ReadRight:
  lda $4016
  and #$01
  beq ReadRightDone
  ldx Direction
  cpx #$03
  beq ReadRightDone
  ldx #$01
  stx Direction
ReadRightDone:

  rts
