;===========================================================
; game_impl.asm
;
; Main game workflow control routines
;===========================================================

;-----------------------------------------------------------
; Process game logic loop
;-----------------------------------------------------------
GameLoop:
  ;Render graphics
  jsr RenderSnake
  jsr RenderApple
  jsr RenderScore

  ;Process controller input
  jsr ReadController

  ;Check collisions
  jsr CheckCollisions
  
  ldx GameCounter
  inx
  cpx #$0A
  beq GameUpdate ;Control game speed
  stx GameCounter
  rts
GameUpdate: ;Update game objects
  ldx #$00
  stx GameCounter ;Reset speed control counter
  jsr MoveSnake

  rts

;-----------------------------------------------------------
; Increase game score
;-----------------------------------------------------------
IncreaseScore:
  ldx ScoreUnits
  inx
  cpx #$0A
  bne IncreaseScoreDone
  ldx #$00
  inc ScoreTens
IncreaseScoreDone:
  stx ScoreUnits
  rts