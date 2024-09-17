UpdateSPRATR:

    ; --- Update SPRATR from buffer
    ld      a, 0000 0000 b
    ld      hl, SPRATR
    call    SetVdp_Write
    ld      hl, SPRATR_Buffer
    ld      c, PORT_0
    
    ; 2 objs on map
    outi outi outi outi
    outi outi outi outi

    ; obj on screen
    outi outi outi outi

    ret