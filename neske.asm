;===========================================================
;
; Snake game
;
; Jacinto Mba Cantero <github.com/jacmba>
; 2020
;
;===========================================================


  .inesprg 1
  .ineschr 1
  .inesmir 1
  .inesmap 0

  .bank 0
  .org $8000

;-----------------------------------------------------------
; Startup code
;-----------------------------------------------------------
Reset:
  ;Disable IRQs and decimal mode
  sei
  cld

  ;Disable APU IRQ
  ldx #$40
  stx $4017

  ;Setup stack
  ldx #$FF
  txs

  ;Disable NMI, rendering and DMC IRQs
  inx ;now it's 0
  stx $2000
  stx $2001
  stx $4010

  bit $2002
  jsr WaitVBlank

;Clear memory
  ldx #$00
  txa
Clearmem:
  sta $0000,x
  sta $0100,x
  sta $0300,x
  sta $0400,x
  sta $0500,x
  sta $0600,x
  sta $0700,x
  inx
  bne Clearmem

  jsr Initialize ;Initialize player object
  jsr InitApple ;Initialize apple object

  jsr WaitVBlank ; Wait for PPU to be ready
  nop

;Setup graphics
PPUSetup:
  lda #%10010000 ;Enable NMI
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
  cpx #$10 ;16bit palette should be enough
  bne LoadPaletteLoop

  ldx #$00
LoadSpritesLoop:
  lda Sprites,x
  sta $0200,x
  inx
  cpx #$08
  bne LoadSpritesLoop

;-----------------------------------------------------------
; Infinite loop to prevent main code falling
; into NMI routine
;-----------------------------------------------------------
MainLoop:
  jmp MainLoop

;-----------------------------------------------------------
; Non Maskable Interrupt routine code
; executed on each VBlank signal
; We process game loop here
;-----------------------------------------------------------
Nmi:
  ;Setup DMA
  lda #$00
  sta $2003
  lda #$02
  sta $4014

  ;Render graphics
  jsr RenderSnake
  jsr RenderApple

  ;Process controller input
  jsr ReadController

  ;Update objects
  jsr MoveSnake

  rti

;-
; Import code
;-
  .include "model/snake_impl.asm"
  .include "model/apple_impl.asm"
  .include "view/screen.asm"
  .include "view/snake_render.asm"
  .include "view/apple_render.asm"
  .include "controller/input.asm"

;-
; Second memory bank
; Include some graphic data here and define vector table
;-
  .bank 1
  .org $E000
PaletteData: ;Load binary palette data
  .incbin "res/sprites.pal"
  
Sprites: ;Sprites data
  .byte $80, $00, $00, $80  ;Snake head sprite (tile 0 at 
                            ;0x80, 0x80)
  .byte $20, $02, $01, $E0 ;Apple sprite (tile 2 at 0x20, 0xE0)

  ;Vector table definition
  .org $FFFA
  .word Nmi, Reset, $00

;-
; Third memory bank
; Load graphic resources and data sources
;-
  .bank 2
  .org $0000
  .incbin "res/sprites.chr"

  .include "model/snake.asm"
  .include "model/apple.asm"
