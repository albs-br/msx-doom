ram_watch   add     0xc081      -type word       -desc P.X             -format dec
ram_watch   add     0xc083      -type word       -desc P.Y             -format dec
ram_watch   add     0xc085      -type word       -desc P.angle             -format dec


ram_watch   add     0xc08b      -type word       -desc Obj_0.X             -format dec
ram_watch   add     0xc08d      -type word       -desc Obj_0.Y             -format dec
ram_watch   add     0xc08f      -type word       -desc Obj_0.dis_X             -format dec
ram_watch   add     0xc091      -type word       -desc Obj_0.dis_Y             -format dec
ram_watch   add     0xc093      -type word       -desc Obj_0.angle             -format dec





# Player.angle: equ 0C085h ; last def. pass 3

# ram_watch   add     0xc00f      -type byte       -desc Player_Lives      -format dec
# ram_watch   add     0xc002      -type byte       -desc Player_Status     -format dec
# 
# ram_watch   add     0xFC4A      -type word       -desc HIMEM             -format hex
