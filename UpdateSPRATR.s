UpdateSPRATR:

    ; --- Update SPRATR from buffer
    ld      a, 0000 0000 b
    ld      hl, SPRATR
    call    SetVdp_Write
    ld      hl, SPRATR_Buffer
    ld      c, PORT_0
    outi outi outi outi
    outi outi outi outi ; update 2 sprites

    ret