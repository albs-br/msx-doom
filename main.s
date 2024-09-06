FNAME "msx-doom.rom"      ; output file

PageSize:	    equ	0x4000	        ; 16kB
Seg_P8000_SW:	equ	0x7000	        ; Segment switch for page 0x8000-BFFFh (ASCII 16k Mapper)

DEBUG:          equ 255             ; defines debug mode, value is irrelevant (comment it out for production version)


; Compilation address
    org 0x4000, 0xbeff	                    ; 0x8000 can be also used here if Rom size is 16kB or less.

    INCLUDE "Include/RomHeader.s"
    INCLUDE "Include/MsxBios.s"
    INCLUDE "Include/MsxConstants.s"
    INCLUDE "Include/CommonRoutines.s"
    
    INCLUDE "Include/Math.s"

    
    
    INCLUDE "LookUpTables/LUT_Cos_Sin.s"
    INCLUDE "LookUpTables/LUT_Atan2.s"
    
    INCLUDE "ReadInput.s"
    INCLUDE "GameLogic/ObjectLogic.s"
    INCLUDE "UpdateSPRATR.s"
    INCLUDE "UpdateSPRATR_Buffer.s"
    
    INCLUDE "UnitTests/ObjectLogic_Tests.s"


; Default VRAM tables for Screen 4
NAMTBL:     equ 0x1800  ; to 0x1aff (768 bytes)
PATTBL:     equ 0x0000  ; to 0x17ff (6144 bytes)
COLTBL:     equ 0x2000  ; to 0x37ff (6144 bytes)
SPRPAT:     equ 0x3800  ; to 0x3fff (2048 bytes)
SPRCOL:     equ 0x1c00  ; to 0x1dff (512 bytes)
SPRATR:     equ 0x1e00  ; to 0x1e7f (128 bytes)

Execute:
    ; init interrupt mode and stack pointer (in case the ROM isn't the first thing to be loaded)
	di                          ; disable interrupts
	im      1                   ; interrupt mode 1
    ld      sp, (BIOS_HIMEM)    ; init SP


; ------------------------------------

    IFDEF DEBUG
        ;call 	RunUnitTests
        call 	ObjectLogic_Tests
    ENDIF

; ------------------------------------


    call    BIOS_DISSCR

    ld      hl, RamStart        ; RAM start address
    ld      de, RamEnd + 1      ; RAM end address
    call    ClearRam_WithParameters



    ; disable keyboard click
    xor     a
    ld 		(BIOS_CLIKSW), a     ; Key Press Click Switch 0:Off 1:On (1B/RW)



    call    EnableRomPage2

	; enable page 1
    ld	    a, 1
	ld	    (Seg_P8000_SW), a

    ; define screen colors
    ld 		a, 1      	            ; Foreground color
    ld 		(BIOS_FORCLR), a    
    ld 		a, 1  		            ; Background color
    ld 		(BIOS_BAKCLR), a     
    ld 		a, 1      	            ; Border color
    ld 		(BIOS_BDRCLR), a    
    call 	BIOS_CHGCLR        		; Change Screen Color

    ; change to screen 4
    ld      a, 4
    call    BIOS_CHGMOD

    call    ClearVram_MSX2

    call    Set192Lines

    call    SetColor0ToNonTransparent

    ; load NAMTBL (third part)
    ld		hl, NAMTBL_Data             ; RAM address (source)
    ld		de, NAMTBL + (32*16)	    ; VRAM address (destiny)
    ld		bc, NAMTBL_Data.size	    ; Block length
    call 	BIOS_LDIRVM        		    ; Block transfer to VRAM from memory

    ; load PATTBL (third part)
    ld		hl, PATTBL_Data             ; RAM address (source)
    ld		de, PATTBL + (32*16*8)		; VRAM address (destiny)
    ld		bc, PATTBL_Data.size	    ; Block length
    call 	BIOS_LDIRVM        		    ; Block transfer to VRAM from memory

    ; load COLTBL (third part)
    ld		hl, COLTBL_Data             ; RAM address (source)
    ld		de, COLTBL + (32*16*8)		; VRAM address (destiny)
    ld		bc, COLTBL_Data.size	    ; Block length
    call 	BIOS_LDIRVM        		    ; Block transfer to VRAM from memory

    ; load SPRPAT
    ld		hl, SPRPAT_Data             ; RAM address (source)
    ld		de, SPRPAT   		        ; VRAM address (destiny)
    ld		bc, SPRPAT_Data.size	    ; Block length
    call 	BIOS_LDIRVM        		    ; Block transfer to VRAM from memory

    ; load SPRCOL
    ld		hl, SPRCOL_Data             ; RAM address (source)
    ld		de, SPRCOL   		        ; VRAM address (destiny)
    ld		bc, SPRCOL_Data.size	    ; Block length
    call 	BIOS_LDIRVM        		    ; Block transfer to VRAM from memory

    ; load SPRATR_Buffer
    ld		hl, SPRATR_Data             ; RAM address (source)
    ld		de, SPRATR_Buffer   		; VRAM address (destiny)
    ld		bc, SPRATR_Data.size	    ; Block length
    ldir        		                ; Block transfer to VRAM from memory


    call    BIOS_ENASCR

; ------------------------------------

    ; Init vars
    ld      hl, 32768 ; center of map
    ld      (Player.X), hl
    ld      (Player.Y), hl
    ld      hl, 0
    ld      (Player.angle), hl

    call    Update_FoV
    call    Update_walkDXandDY



    ld      hl, 32768 + 16384
    ld      (Object_0), hl ; X
    ld      hl, 32768 - 16384
    ld      (Object_0 + 2), hl ; Y
    ld      hl, 0
    ld      (Object_0 + 4), hl ; distance X
    ld      (Object_0 + 6), hl ; distance Y
    ld      (Object_0 + 8), hl ; angle to player
    xor     a
    ld      (Object_0 + 10), a ; is visible
    ;ld      (Object_0 + 11), a ;

; ------------------------------------

; --- Main game loop

.mainLoop:

    call    Wait_Vblank



    IFDEF DEBUG
        ld 		a, 4       	            ; Border color
        ld 		(BIOS_BDRCLR), a
        call 	BIOS_CHGCLR        		; Change Screen Color
    ENDIF

    call    UpdateSPRATR

    ; ---------------------------------

    IFDEF DEBUG
        ld 		a, 7       	            ; Border color
        ld 		(BIOS_BDRCLR), a
        call 	BIOS_CHGCLR        		; Change Screen Color
    ENDIF
    
    call    ReadInput

    ; ---------------------------------

    IFDEF DEBUG
        ld 		a, 8       	            ; Border color
        ld 		(BIOS_BDRCLR), a
        call 	BIOS_CHGCLR        		; Change Screen Color
    ENDIF
    
    ld      hl, Object_0
    call    ObjectLogic

    ; ---------------------------------

    IFDEF DEBUG
        ld 		a, 12       	            ; Border color
        ld 		(BIOS_BDRCLR), a
        call 	BIOS_CHGCLR        		; Change Screen Color
    ENDIF

    call    UpdateSPRATR_Buffer

    ; ---------------------------------

    IFDEF DEBUG
        ld 		a, 1       	            ; Border color
        ld 		(BIOS_BDRCLR), a
        call 	BIOS_CHGCLR        		; Change Screen Color
    ENDIF



    jp      .mainLoop


End:

; Palette:
;     ; INCBIN "Images/title-screen.pal"
;     INCBIN "Images/plane_rotating.pal"

NAMTBL_Data:
    db      1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db      1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db      1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db      1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db      1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db      1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db      1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db      1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
.size:  equ $ - NAMTBL_Data

PATTBL_Data:
    db      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
    db      0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff
.size:  equ $ - PATTBL_Data

COLTBL_Data:
    db      0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11
    db      0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff
.size:  equ $ - COLTBL_Data

SPRPAT_Data:
    db      11000000 b
    db      11000000 b
    db      00000000 b
    db      00000000 b
    db      00000000 b
    db      00000000 b
    db      00000000 b
    db      00000000 b
.size:  equ $ - SPRPAT_Data

SPRCOL_Data:
    db      0x08, 0x08, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db      0x04, 0x04, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
.size:  equ $ - SPRCOL_Data

SPRATR_Data:
    ;       y, x, pattern, unused
    db      0, 0, 0, 0
    db      0, 0, 0, 0
.size:  equ $ - SPRATR_Data

   
; ----------------------------------------

    db      "End ROM started at 0x4000"

	ds PageSize - ($ - 0x4000), 255	; Fill the unused area with 0xFF


; ; MegaROM pages at 0x8000
; ; ------- Page 1
; 	org	0x8000, 0xBFFF
; ImageData:
;     ;INCBIN "Images/aerofighters-xaa"
; .size:      equ $ - ImageData
; 	ds PageSize - ($ - 0x8000), 255



; ----------------------------------------

; RAM
	org     0xc000, 0xe5ff

RamStart:

    INCLUDE "Variables.s"

RamEnd: