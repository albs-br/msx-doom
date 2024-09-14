ram_watch   add     0xc081      -type word       -desc P.X             -format dec
ram_watch   add     0xc083      -type word       -desc P.Y             -format dec
ram_watch   add     0xc085      -type word       -desc P.angle             -format dec
ram_watch   add     0xc087      -type word       -desc P.FoV_start         -format dec
ram_watch   add     0xc089      -type word       -desc P.FoV_end         -format dec


ram_watch   add     0xc100      -type word       -desc O_0.X             -format dec
ram_watch   add     0xc102      -type word       -desc O_0.Y             -format dec
ram_watch   add     0xc104      -type word       -desc O_0.dis_X             -format dec
ram_watch   add     0xc106      -type word       -desc O_0.dis_Y             -format dec
ram_watch   add     0xc108      -type word       -desc O_0.angle             -format dec
ram_watch   add     0xc10a      -type byte       -desc O_0.isVis             -format dec
ram_watch   add     0xc10b      -type byte       -desc O_0.posX_inside_FoV             -format dec
ram_watch   add     0xc10c      -type byte       -desc O_0.quad             -format dec
ram_watch   add     0xc10d      -type byte       -desc O_0.div_E            -format hex
ram_watch   add     0xc10e      -type byte       -desc O_0.div_D            -format hex
ram_watch   add     0xc10f      -type byte       -desc O_0.div_A            -format hex
ram_watch   add     0xc110      -type byte       -desc O_0.distToPlayer            -format dec

# ram_watch   add     0xd000      -type word       -desc O_T.X             -format dec
# ram_watch   add     0xd002      -type word       -desc O_T.Y             -format dec
# ram_watch   add     0xd004      -type word       -desc O_T.dis_X             -format dec
# ram_watch   add     0xd006      -type word       -desc O_T.dis_Y             -format dec
# ram_watch   add     0xd008      -type word       -desc O_T.angle             -format dec
# ram_watch   add     0xd00a      -type byte       -desc O_T.isVis             -format dec
# ram_watch   add     0xd00b      -type byte       -desc O_T.posX_inside_FoV             -format dec
# ram_watch   add     0xd00c      -type byte       -desc O_T.quad             -format dec





# ram_watch   add     0xc002      -type byte       -desc Player_Status     -format dec
# 
# ram_watch   add     0xFC4A      -type word       -desc HIMEM             -format hex
