;===========================================================
; snake_impl.asm
;
; Snake object routines implementation
;===========================================================

;-----------------------------------------------------------
; Set initial values
; Head sprite at center of screen
; Direction to right
; Speed = 1
;-----------------------------------------------------------
Initialize:
  lda #$80
  sta PosX
  sta PosY
  lda #$00
  sta Size
  lda #$01
  sta Direction
  lda #$08
  sta Speed
  rts

;-----------------------------------------------------------
; Perform snake movement as per current direction
;-----------------------------------------------------------
MoveSnake:
  ;Start moving tail

  lda #$00
  ldx #$00
MoveTailLoop:
  cmp Size
  beq MoveSnakeHead
  pha
  cmp #$00
  beq MoveFirstTailBlock
MoveFirstTailBlock:
  lda PosX;
  sta Tail,x
  inx
  lda PosY
  sta Tail,x
  inx
  lda Direction
  sta Tail,x
  pla
  txa
  inx
  tax
  ;jmp MoveFirstTailBlock
MoveSnakeHead:

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
  sta PosY
  rts

;-----------------------------------------------------------
; Check collisions with Apple
;-----------------------------------------------------------
CheckCollisions:
  ;Check horizontal match
  lda PosX
  cmp AppleX
  bne CheckCollisionDone
  
  ;Check vertical match
  lda PosY
  cmp AppleY
  bne CheckCollisionDone

  ;If we get here,
  ;there's x and y match
  jsr IncreaseTail
  jsr RespawnApple

CheckCollisionDone: ;Jump here when no position match
  rts

;-----------------------------------------------------------
; Increase tail size
;-----------------------------------------------------------
IncreaseTail:
  ldx Size
  cpx #$00
  beq IncreaseTailFromHead
  rts
IncreaseTailFromHead:
  ldx PosX
  ldy PosY
  lda Direction
  jmp IncreaseSet
IncreaseSet:
  pha ;Backup Accumulator into stack
  cmp #$01
  beq IncreaseTailLeft
  cmp #$02
  beq IncreaseTailDown
  cmp #$03
  beq IncreaseTailRight
  tya
  sec
  sbc #$08
  jmp IncreaseStore
IncreaseTailLeft:
  txa
  sec
  sbc #$08
  tax
  jmp IncreaseStore
IncreaseTailDown:
  tya
  clc
  adc #$08
  tay
  jmp IncreaseStore
IncreaseTailRight:
  txa
  clc
  adc #$08
  tax
IncreaseStore:
  txa
  ldx #$00
  sta Tail
  inx
  tya
  sta Tail,x
  inx
  pla
  sta Tail,x
  ldx Size
  inx
  stx Size
  rts
