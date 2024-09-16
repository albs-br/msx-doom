NOT_USED: equ 0

TestObject_Data:

    ; header
    ; some obj data wiil go here
    ;db 0,0,0,0


; ------------- distance 0
.distance_n_data:
    db  32, 32          ; object width, height

    dw   .dist_0_spr_0_data,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED
    dw             NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED
.distance_n_data_size: equ $ - .distance_n_data

; ; ------------- distance 1
;     db  32, 32          ; object width, height

;     dw   .dist_1_spr_0_data,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED
;     dw             NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED,           NOT_USED

; (...)
; ; ------------- distance 15



; --------------------------------------------------------------------

    INCLUDE "ObjectsData/TestObject/Distance_0_Data.s"
    ;INCLUDE "ObjectsData/TestObject/Distance_1_Data.s"
    ; (...)
    ;INCLUDE "ObjectsData/TestObject/Distance_15_Data.s"

