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
  ldx #$01
  jsr FindTailTip
  sec
  sbc #$03
  tax
  lda Size
MoveTailLoop:
  cmp #$00
  beq MoveSnakeHead
  cmp #$01
  beq MoveFirstTailBlock
  pha
  lda Tail,x
  inx
  inx
  inx
  sta Tail,x ;Copy X-coord
  dex
  dex
  lda Tail,x
  inx
  inx
  inx
  sta Tail,x ;Copy y-coord
  dex
  dex
  lda Tail,x
  inx
  inx
  inx
  sta Tail,x ;Copy direction
  txa
  sec
  sbc #$08
  tax
  pla
  sec
  sbc #01
  jmp MoveTailLoop
MoveFirstTailBlock:
  ldx #$00
  lda PosX;
  sta Tail,x
  inx
  lda PosY
  sta Tail,x
  inx
  lda Direction
  sta Tail,x
  txa
  inx
  tax
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
  jsr IncreaseScore

CheckCollisionDone: ;Jump here when no position match
  rts

;-----------------------------------------------------------
; Increase tail size
;-----------------------------------------------------------
IncreaseTail:
  ldx Size
  cpx #$00
  beq IncreaseTailFromHead
  lda #$00
  ldx #$01
  jsr FindTailTip
  tax
  clc
  adc #$03
  sta Temp
  lda Tail,x
  pha
  inx
  lda Tail,x
  tay
  inx
  lda Tail,x
  sta Temp2
  pla
  tax
  lda Temp2  
  jmp IncreaseSet
IncreaseTailFromHead:
  ldx PosX
  ldy PosY
  lda #$00
  sta Temp
  lda Direction
  jmp IncreaseSet
IncreaseSet:
  cmp #$01
  beq IncreaseTailLeft
  cmp #$02
  beq IncreaseTailDown
  cmp #$03
  beq IncreaseTailRight
  jmp IncreaseTailUp
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
IncreaseTailUp:
  tya
  sec
  sbc #$08
  tay
  jmp IncreaseStore
IncreaseTailRight:
  txa
  clc
  adc #$08
  tax
IncreaseStore:
  txa
  ldx Temp
  sta Tail,x
  inx
  tya
  sta Tail,x
  inx
  lda Temp2
  sta Tail,x
  inc Size
  rts

;-----------------------------------------------------------
; Find last tail part
; Return ZP position in Accumulator
;-----------------------------------------------------------
FindTailTip:
  cpx Size
  beq TailTipFound
  clc
  adc #$03
  inx
  jmp FindTailTip
TailTipFound:
  rts
