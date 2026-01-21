; TODO: angle can be byte here

; TODO: possible performance improvement:
; table with all possible values and angles
; this way there is no need to loop through all the table until find the value (more costly when getting close to table end)
; just add LUT_Atan2 with the value to be found
; this approach trades space for speed, which is good here
;LUT_Atan2:
;   db      0 ; angle for value 0 = 0 degrees
;   db      1 ; angle for value 1 = 0 degrees
;   db      2 ; angle for value 2 = 0 degrees
;   db      3 ; angle for value 3 = 0 degrees
; (...)
;   db      16 ; angle for value 16 = 4 degrees
;   db      17 ; angle for value 17 = 4 degrees
; (...)
;   db      90 ; angle for value 4096 = 90 degrees
; (...)
;   db      90 ; angle for value 10000 = 90 degrees ; not necessary, use -->  if (value > 4096) value = 4096

LUT_Atan2:
        dw      0,      0
        dw      3,      1       ; atan2 of value 1/100 = 0,01, in degrees = 1
        dw      5,      1       ; atan2 of value 2/100 = 0,02, in degrees = 1
        dw      8,      2       ; atan2 of value 3/100 = 0,03, in degrees = 2
        dw      10,     2       ; atan2 of value 4/100 = 0,04, in degrees = 2
        dw      13,     3       ; atan2 of value 5/100 = 0,05, in degrees = 3
        dw      15,     3       ; atan2 of value 6/100 = 0,06, in degrees = 3
        dw      18,     4       ; atan2 of value 7/100 = 0,07, in degrees = 4
        dw      20,     5       ; atan2 of value 8/100 = 0,08, in degrees = 5
        dw      23,     5       ; atan2 of value 9/100 = 0,09, in degrees = 5
        dw      26,     6       ; atan2 of value 10/100 = 0,1, in degrees = 6
        dw      28,     6       ; atan2 of value 11/100 = 0,11, in degrees = 6
        dw      31,     7       ; atan2 of value 12/100 = 0,12, in degrees = 7
        dw      33,     7       ; atan2 of value 13/100 = 0,13, in degrees = 7
        dw      36,     8       ; atan2 of value 14/100 = 0,14, in degrees = 8
        dw      38,     9       ; atan2 of value 15/100 = 0,15, in degrees = 9
        dw      41,     9       ; atan2 of value 16/100 = 0,16, in degrees = 9
        dw      44,     10      ; atan2 of value 17/100 = 0,17, in degrees = 10
        dw      46,     10      ; atan2 of value 18/100 = 0,18, in degrees = 10
        dw      49,     11      ; atan2 of value 19/100 = 0,19, in degrees = 11
        dw      51,     11      ; atan2 of value 20/100 = 0,2, in degrees = 11
        dw      54,     12      ; atan2 of value 21/100 = 0,21, in degrees = 12
        dw      56,     12      ; atan2 of value 22/100 = 0,22, in degrees = 12
        dw      59,     13      ; atan2 of value 23/100 = 0,23, in degrees = 13
        dw      61,     13      ; atan2 of value 24/100 = 0,24, in degrees = 13
        dw      64,     14      ; atan2 of value 25/100 = 0,25, in degrees = 14
        dw      67,     15      ; atan2 of value 26/100 = 0,26, in degrees = 15
        dw      69,     15      ; atan2 of value 27/100 = 0,27, in degrees = 15
        dw      72,     16      ; atan2 of value 28/100 = 0,28, in degrees = 16
        dw      74,     16      ; atan2 of value 29/100 = 0,29, in degrees = 16
        dw      77,     17      ; atan2 of value 30/100 = 0,3, in degrees = 17
        dw      79,     17      ; atan2 of value 31/100 = 0,31, in degrees = 17
        dw      82,     18      ; atan2 of value 32/100 = 0,32, in degrees = 18
        dw      84,     18      ; atan2 of value 33/100 = 0,33, in degrees = 18
        dw      87,     19      ; atan2 of value 34/100 = 0,34, in degrees = 19
        dw      90,     19      ; atan2 of value 35/100 = 0,35, in degrees = 19
        dw      92,     20      ; atan2 of value 36/100 = 0,36, in degrees = 20
        dw      95,     20      ; atan2 of value 37/100 = 0,37, in degrees = 20
        dw      97,     21      ; atan2 of value 38/100 = 0,38, in degrees = 21
        dw      100,    21      ; atan2 of value 39/100 = 0,39, in degrees = 21
        dw      102,    22      ; atan2 of value 40/100 = 0,4, in degrees = 22
        dw      105,    22      ; atan2 of value 41/100 = 0,41, in degrees = 22
        dw      108,    23      ; atan2 of value 42/100 = 0,42, in degrees = 23
        dw      110,    23      ; atan2 of value 43/100 = 0,43, in degrees = 23
        dw      113,    24      ; atan2 of value 44/100 = 0,44, in degrees = 24
        dw      115,    24      ; atan2 of value 45/100 = 0,45, in degrees = 24
        dw      118,    25      ; atan2 of value 46/100 = 0,46, in degrees = 25
        dw      120,    25      ; atan2 of value 47/100 = 0,47, in degrees = 25
        dw      123,    26      ; atan2 of value 48/100 = 0,48, in degrees = 26
        dw      125,    26      ; atan2 of value 49/100 = 0,49, in degrees = 26
        dw      128,    27      ; atan2 of value 50/100 = 0,5, in degrees = 27
        dw      131,    27      ; atan2 of value 51/100 = 0,51, in degrees = 27
        dw      133,    27      ; atan2 of value 52/100 = 0,52, in degrees = 27
        dw      136,    28      ; atan2 of value 53/100 = 0,53, in degrees = 28
        dw      138,    28      ; atan2 of value 54/100 = 0,54, in degrees = 28
        dw      141,    29      ; atan2 of value 55/100 = 0,55, in degrees = 29
        dw      143,    29      ; atan2 of value 56/100 = 0,56, in degrees = 29
        dw      146,    30      ; atan2 of value 57/100 = 0,57, in degrees = 30
        dw      148,    30      ; atan2 of value 58/100 = 0,58, in degrees = 30
        dw      151,    31      ; atan2 of value 59/100 = 0,59, in degrees = 31
        dw      154,    31      ; atan2 of value 60/100 = 0,6, in degrees = 31
        dw      156,    31      ; atan2 of value 61/100 = 0,61, in degrees = 31
        dw      159,    32      ; atan2 of value 62/100 = 0,62, in degrees = 32
        dw      161,    32      ; atan2 of value 63/100 = 0,63, in degrees = 32
        dw      164,    33      ; atan2 of value 64/100 = 0,64, in degrees = 33
        dw      166,    33      ; atan2 of value 65/100 = 0,65, in degrees = 33
        dw      169,    33      ; atan2 of value 66/100 = 0,66, in degrees = 33
        dw      172,    34      ; atan2 of value 67/100 = 0,67, in degrees = 34
        dw      174,    34      ; atan2 of value 68/100 = 0,68, in degrees = 34
        dw      177,    35      ; atan2 of value 69/100 = 0,69, in degrees = 35
        dw      179,    35      ; atan2 of value 70/100 = 0,7, in degrees = 35
        dw      182,    35      ; atan2 of value 71/100 = 0,71, in degrees = 35
        dw      184,    36      ; atan2 of value 72/100 = 0,72, in degrees = 36
        dw      187,    36      ; atan2 of value 73/100 = 0,73, in degrees = 36
        dw      189,    37      ; atan2 of value 74/100 = 0,74, in degrees = 37
        dw      192,    37      ; atan2 of value 75/100 = 0,75, in degrees = 37
        dw      195,    37      ; atan2 of value 76/100 = 0,76, in degrees = 37
        dw      197,    38      ; atan2 of value 77/100 = 0,77, in degrees = 38
        dw      200,    38      ; atan2 of value 78/100 = 0,78, in degrees = 38
        dw      202,    38      ; atan2 of value 79/100 = 0,79, in degrees = 38
        dw      205,    39      ; atan2 of value 80/100 = 0,8, in degrees = 39
        dw      207,    39      ; atan2 of value 81/100 = 0,81, in degrees = 39
        dw      210,    39      ; atan2 of value 82/100 = 0,82, in degrees = 39
        dw      212,    40      ; atan2 of value 83/100 = 0,83, in degrees = 40
        dw      215,    40      ; atan2 of value 84/100 = 0,84, in degrees = 40
        dw      218,    40      ; atan2 of value 85/100 = 0,85, in degrees = 40
        dw      220,    41      ; atan2 of value 86/100 = 0,86, in degrees = 41
        dw      223,    41      ; atan2 of value 87/100 = 0,87, in degrees = 41
        dw      225,    41      ; atan2 of value 88/100 = 0,88, in degrees = 41
        dw      228,    42      ; atan2 of value 89/100 = 0,89, in degrees = 42
        dw      230,    42      ; atan2 of value 90/100 = 0,9, in degrees = 42
        dw      233,    42      ; atan2 of value 91/100 = 0,91, in degrees = 42
        dw      236,    43      ; atan2 of value 92/100 = 0,92, in degrees = 43
        dw      238,    43      ; atan2 of value 93/100 = 0,93, in degrees = 43
        dw      241,    43      ; atan2 of value 94/100 = 0,94, in degrees = 43
        dw      243,    44      ; atan2 of value 95/100 = 0,95, in degrees = 44
        dw      246,    44      ; atan2 of value 96/100 = 0,96, in degrees = 44
        dw      248,    44      ; atan2 of value 97/100 = 0,97, in degrees = 44
        dw      251,    44      ; atan2 of value 98/100 = 0,98, in degrees = 44
        dw      253,    45      ; atan2 of value 99/100 = 0,99, in degrees = 45
        dw      256,    45      ; atan2 of value 100/100 = 1, in degrees = 45
        dw      256,    45      ; atan2 of value 100/100 = 1, in degrees = 45
        dw      259,    45      ; atan2 of value 100/99 = 1,0101, in degrees = 45
        dw      261,    46      ; atan2 of value 100/98 = 1,0204, in degrees = 46
        dw      264,    46      ; atan2 of value 100/97 = 1,0309, in degrees = 46
        dw      267,    46      ; atan2 of value 100/96 = 1,0417, in degrees = 46
        dw      269,    46      ; atan2 of value 100/95 = 1,0526, in degrees = 46
        dw      272,    47      ; atan2 of value 100/94 = 1,0638, in degrees = 47
        dw      275,    47      ; atan2 of value 100/93 = 1,0753, in degrees = 47
        dw      278,    47      ; atan2 of value 100/92 = 1,087, in degrees = 47
        dw      281,    48      ; atan2 of value 100/91 = 1,0989, in degrees = 48
        dw      284,    48      ; atan2 of value 100/90 = 1,1111, in degrees = 48
        dw      288,    48      ; atan2 of value 100/89 = 1,1236, in degrees = 48
        dw      291,    49      ; atan2 of value 100/88 = 1,1364, in degrees = 49
        dw      294,    49      ; atan2 of value 100/87 = 1,1494, in degrees = 49
        dw      298,    49      ; atan2 of value 100/86 = 1,1628, in degrees = 49
        dw      301,    50      ; atan2 of value 100/85 = 1,1765, in degrees = 50
        dw      305,    50      ; atan2 of value 100/84 = 1,1905, in degrees = 50
        dw      308,    50      ; atan2 of value 100/83 = 1,2048, in degrees = 50
        dw      312,    51      ; atan2 of value 100/82 = 1,2195, in degrees = 51
        dw      316,    51      ; atan2 of value 100/81 = 1,2346, in degrees = 51
        dw      320,    51      ; atan2 of value 100/80 = 1,25, in degrees = 51
        dw      324,    52      ; atan2 of value 100/79 = 1,2658, in degrees = 52
        dw      328,    52      ; atan2 of value 100/78 = 1,2821, in degrees = 52
        dw      332,    52      ; atan2 of value 100/77 = 1,2987, in degrees = 52
        dw      337,    53      ; atan2 of value 100/76 = 1,3158, in degrees = 53
        dw      341,    53      ; atan2 of value 100/75 = 1,3333, in degrees = 53
        dw      346,    53      ; atan2 of value 100/74 = 1,3514, in degrees = 53
        dw      351,    54      ; atan2 of value 100/73 = 1,3699, in degrees = 54
        dw      356,    54      ; atan2 of value 100/72 = 1,3889, in degrees = 54
        dw      361,    55      ; atan2 of value 100/71 = 1,4085, in degrees = 55
        dw      366,    55      ; atan2 of value 100/70 = 1,4286, in degrees = 55
        dw      371,    55      ; atan2 of value 100/69 = 1,4493, in degrees = 55
        dw      376,    56      ; atan2 of value 100/68 = 1,4706, in degrees = 56
        dw      382,    56      ; atan2 of value 100/67 = 1,4925, in degrees = 56
        dw      388,    57      ; atan2 of value 100/66 = 1,5152, in degrees = 57
        dw      394,    57      ; atan2 of value 100/65 = 1,5385, in degrees = 57
        dw      400,    57      ; atan2 of value 100/64 = 1,5625, in degrees = 57
        dw      406,    58      ; atan2 of value 100/63 = 1,5873, in degrees = 58
        dw      413,    58      ; atan2 of value 100/62 = 1,6129, in degrees = 58
        dw      420,    59      ; atan2 of value 100/61 = 1,6393, in degrees = 59
        dw      427,    59      ; atan2 of value 100/60 = 1,6667, in degrees = 59
        dw      434,    59      ; atan2 of value 100/59 = 1,6949, in degrees = 59
        dw      441,    60      ; atan2 of value 100/58 = 1,7241, in degrees = 60
        dw      449,    60      ; atan2 of value 100/57 = 1,7544, in degrees = 60
        dw      457,    61      ; atan2 of value 100/56 = 1,7857, in degrees = 61
        dw      465,    61      ; atan2 of value 100/55 = 1,8182, in degrees = 61
        dw      474,    62      ; atan2 of value 100/54 = 1,8519, in degrees = 62
        dw      483,    62      ; atan2 of value 100/53 = 1,8868, in degrees = 62
        dw      492,    63      ; atan2 of value 100/52 = 1,9231, in degrees = 63
        dw      502,    63      ; atan2 of value 100/51 = 1,9608, in degrees = 63
        dw      512,    63      ; atan2 of value 100/50 = 2, in degrees = 63
        dw      522,    64      ; atan2 of value 100/49 = 2,0408, in degrees = 64
        dw      533,    64      ; atan2 of value 100/48 = 2,0833, in degrees = 64
        dw      545,    65      ; atan2 of value 100/47 = 2,1277, in degrees = 65
        dw      557,    65      ; atan2 of value 100/46 = 2,1739, in degrees = 65
        dw      569,    66      ; atan2 of value 100/45 = 2,2222, in degrees = 66
        dw      582,    66      ; atan2 of value 100/44 = 2,2727, in degrees = 66
        dw      595,    67      ; atan2 of value 100/43 = 2,3256, in degrees = 67
        dw      610,    67      ; atan2 of value 100/42 = 2,381, in degrees = 67
        dw      624,    68      ; atan2 of value 100/41 = 2,439, in degrees = 68
        dw      640,    68      ; atan2 of value 100/40 = 2,5, in degrees = 68
        dw      656,    69      ; atan2 of value 100/39 = 2,5641, in degrees = 69
        dw      674,    69      ; atan2 of value 100/38 = 2,6316, in degrees = 69
        dw      692,    70      ; atan2 of value 100/37 = 2,7027, in degrees = 70
        dw      711,    70      ; atan2 of value 100/36 = 2,7778, in degrees = 70
        dw      731,    71      ; atan2 of value 100/35 = 2,8571, in degrees = 71
        dw      753,    71      ; atan2 of value 100/34 = 2,9412, in degrees = 71
        dw      776,    72      ; atan2 of value 100/33 = 3,0303, in degrees = 72
        dw      800,    72      ; atan2 of value 100/32 = 3,125, in degrees = 72
        dw      826,    73      ; atan2 of value 100/31 = 3,2258, in degrees = 73
        dw      853,    73      ; atan2 of value 100/30 = 3,3333, in degrees = 73
        dw      883,    74      ; atan2 of value 100/29 = 3,4483, in degrees = 74
        dw      914,    74      ; atan2 of value 100/28 = 3,5714, in degrees = 74
        dw      948,    75      ; atan2 of value 100/27 = 3,7037, in degrees = 75
        dw      985,    75      ; atan2 of value 100/26 = 3,8462, in degrees = 75
        dw      1024,   76      ; atan2 of value 100/25 = 4, in degrees = 76
        dw      1067,   77      ; atan2 of value 100/24 = 4,1667, in degrees = 77
        dw      1113,   77      ; atan2 of value 100/23 = 4,3478, in degrees = 77
        dw      1164,   78      ; atan2 of value 100/22 = 4,5455, in degrees = 78
        dw      1219,   78      ; atan2 of value 100/21 = 4,7619, in degrees = 78
        dw      1280,   79      ; atan2 of value 100/20 = 5, in degrees = 79
        dw      1347,   79      ; atan2 of value 100/19 = 5,2632, in degrees = 79
        dw      1422,   80      ; atan2 of value 100/18 = 5,5556, in degrees = 80
        dw      1506,   80      ; atan2 of value 100/17 = 5,8824, in degrees = 80
        dw      1600,   81      ; atan2 of value 100/16 = 6,25, in degrees = 81
        dw      1707,   81      ; atan2 of value 100/15 = 6,6667, in degrees = 81
        dw      1829,   82      ; atan2 of value 100/14 = 7,1429, in degrees = 82
        dw      1969,   83      ; atan2 of value 100/13 = 7,6923, in degrees = 83
        dw      2133,   83      ; atan2 of value 100/12 = 8,3333, in degrees = 83
        dw      2327,   84      ; atan2 of value 100/11 = 9,0909, in degrees = 84
        dw      2560,   84      ; atan2 of value 100/10 = 10, in degrees = 84
        dw      2844,   85      ; atan2 of value 100/9 = 11,1111, in degrees = 85
        dw      3200,   85      ; atan2 of value 100/8 = 12,5, in degrees = 85
        dw      3657,   86      ; atan2 of value 100/7 = 14,2857, in degrees = 86
        dw      4267,   87      ; atan2 of value 100/6 = 16,6667, in degrees = 87
        dw      5120,   87      ; atan2 of value 100/5 = 20, in degrees = 87
        dw      6400,   88      ; atan2 of value 100/4 = 25, in degrees = 88
        dw      8533,   88      ; atan2 of value 100/3 = 33,3333, in degrees = 88
        dw      12800,  89      ; atan2 of value 100/2 = 50, in degrees = 89
        dw      25600,  89      ; atan2 of value 100/1 = 100, in degrees = 89
.end:

; LUT_Atan2:
;     dw 0, 0
;     dw 16, 4
;     dw 32, 7
;     dw 48, 11
;     dw 64, 14
;     dw 80, 17
;     dw 96, 21
;     dw 112, 24
;     dw 128, 27
;     dw 144, 29
;     dw 160, 32
;     dw 176, 35
;     dw 192, 37
;     dw 208, 39
;     dw 224, 41
;     dw 240, 43
;     dw 256, 45      ; value = 1.0 , 45 degrees
;     ;dw 256, 45
;     dw 273, 47
;     dw 293, 49
;     dw 315, 51
;     dw 341, 53
;     dw 372, 55
;     dw 410, 58
;     dw 455, 61
;     dw 512, 63
;     dw 585, 66
;     dw 683, 69
;     dw 819, 73
;     dw 1024, 76
;     dw 1365, 79
;     dw 2048, 83
;     dw 4096, 86
; .end:

