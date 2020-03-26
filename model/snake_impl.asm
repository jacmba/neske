;===========================================================
; snake_impl.asm
;
; Snake object routines implementation
;===========================================================

;Define util constants
COLLIDE_X    .byte %00000001
COLLIDE_Y    .byte %00000010
COLLISION_OK .byte %00000011

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
  sta Speed
  rts

;-----------------------------------------------------------
; Perform snake movement as per current direction
;-----------------------------------------------------------
MoveSnake:
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
  ldx #$00
  stx CollisionMask ;Reset collision mask

  ;Check horizontal boundaries
  lda PosX
  cmp AppleX
  bmi ChkXHigher
  sec
  sbc AppleX
  jmp ChkXDelta
ChkXHigher: ;Check X boundary if apple position is higher
  lda AppleX
  sec
  sbc PosX
ChkXDelta: ;Check difference of X coordinates  
  cmp #07
  bpl ChkColXDone
  lda CollisionMask
  ora COLLIDE_X
  sta CollisionMask
ChkColXDone:

  ;Check vertical boundaries
  lda PosY
  cmp AppleY
  bmi ChkYHigher
  sec
  sbc AppleY
  jmp ChkYDelta
ChkYHigher: ;Check Y boundary if apple position is higher
  lda AppleY
  sec
  sbc PosY
ChkYDelta:
  cmp #07
  bpl ChkColYDone
  lda CollisionMask
  ora COLLIDE_Y
  sta CollisionMask
ChkColYDone:

  ;Test collision mask
  lda CollisionMask
  cmp COLLISION_OK
  bne CheckCollisionDone
  jsr RespawnApple

CheckCollisionDone:
  rts
