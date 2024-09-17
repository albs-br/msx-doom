NOT_USED: equ 0

OBJECT_DATA_DISTANCE_SIZE: equ TestObject_Data.distance_1_data - TestObject_Data.distance_0_data

TestObject_Data:

    ; header
    ; some obj data wiil go here
    ;db 0,0,0,0

.endOfHeader:

; ------------- distance 0
.distance_0_data:
    db  32, 32          ; object width, height

    dw   .dist_0_spr_0_data,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED
    dw             NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED

; ------------- distance 1
.distance_1_data:
    db  30, 30          ; object width, height

    dw   .dist_1_spr_0_data,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED
    dw             NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED

; ------------- distance 2
    db  28, 28          ; object width, height

    dw   .dist_2_spr_0_data,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED
    dw             NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED

; ------------- distance 3
    db  26, 26          ; object width, height

    dw   .dist_3_spr_0_data,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED
    dw             NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED

; ------------- distance 4
    db  24, 24          ; object width, height

    dw   .dist_4_spr_0_data,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED
    dw             NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED

; ------------- distance 5
    db  22, 22          ; object width, height

    dw   .dist_5_spr_0_data,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED
    dw             NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED

; ------------- distance 6
    db  20, 20          ; object width, height

    dw   .dist_6_spr_0_data,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED
    dw             NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED

; ------------- distance 7
    db  18, 18          ; object width, height

    dw   .dist_7_spr_0_data,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED
    dw             NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED

; ------------- distance 8
    db  16, 16          ; object width, height

    dw   .dist_8_spr_0_data,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED
    dw             NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED

; ------------- distance 9
    db  14, 14          ; object width, height

    dw   .dist_9_spr_0_data,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED
    dw             NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED

; ------------- distance 10
    db  12, 12          ; object width, height

    dw  .dist_10_spr_0_data,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED
    dw             NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED

; ------------- distance 11
    db  10, 10          ; object width, height

    dw  .dist_11_spr_0_data,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED
    dw             NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED

; ------------- distance 12
    db   8,  8          ; object width, height

    dw  .dist_12_spr_0_data,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED
    dw             NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED

; ------------- distance 13
    db   6,  6          ; object width, height

    dw  .dist_13_spr_0_data,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED
    dw             NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED

; ------------- distance 14
    db   4,  4          ; object width, height

    dw  .dist_14_spr_0_data,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED
    dw             NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED

; ------------- distance 15
    db   2,  2          ; object width, height

    dw  .dist_15_spr_0_data,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED
    dw             NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED


; (...)
; ; ------------- distance 15



; --------------------------------------------------------------------

    INCLUDE "ObjectsData/TestObject/Distance_0_Data.s"
    INCLUDE "ObjectsData/TestObject/Distance_1_Data.s"
    INCLUDE "ObjectsData/TestObject/Distance_2_Data.s"
    INCLUDE "ObjectsData/TestObject/Distance_3_Data.s"
    INCLUDE "ObjectsData/TestObject/Distance_4_Data.s"
    INCLUDE "ObjectsData/TestObject/Distance_5_Data.s"
    INCLUDE "ObjectsData/TestObject/Distance_6_Data.s"
    INCLUDE "ObjectsData/TestObject/Distance_7_Data.s"
    INCLUDE "ObjectsData/TestObject/Distance_8_Data.s"
    INCLUDE "ObjectsData/TestObject/Distance_9_Data.s"
    INCLUDE "ObjectsData/TestObject/Distance_10_Data.s"
    INCLUDE "ObjectsData/TestObject/Distance_11_Data.s"
    INCLUDE "ObjectsData/TestObject/Distance_12_Data.s"
    INCLUDE "ObjectsData/TestObject/Distance_13_Data.s"
    INCLUDE "ObjectsData/TestObject/Distance_14_Data.s"
    INCLUDE "ObjectsData/TestObject/Distance_15_Data.s"

