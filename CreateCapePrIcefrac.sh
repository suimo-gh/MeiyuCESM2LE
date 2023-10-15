#!/bin/csh -fxv
###

set vars = (CAPE)  # TREFHT Pr ICEFRAC
foreach var ( $vars )

# # member 1-9  # change 0 to 00 in fin
    set starts =(1001);  set runs   = (1)
    set num    = ${runs}

# # # # member 10 # change 00 to 0 in fin
     # set starts =(1181);  set runs   = (10)
     # set num    = ${runs}

# # # member 11-19 # change 0 and 00 in fin 
#      set starts =(1231); set runs   = (1 2 3 4 5 6 7 8 9)
#      set num    = 11
     # set starts =(1231); set runs   = (1)
     # set num    = 11

# #  member 20-30 # change 00 and 0 in fin 
      # set starts =(1231);  set runs   = (10 11 12 13 14 15 16 17 18 19 20)
      # set num    = 20
   
# #  member 31-39 # change 0 and 00 in fin 
      # set starts =(1251);  set runs   = (1 2 3 4 5 6 7 8 9)
      # set num    = 31

#  #  member 40-50 # change 00 and 0 in fin 
      # set starts =(1251);  set runs   = (10 11 12 13 14 15 16 17 18 19 20)
      # set num    = 40
  
# # # member 51-59 # change 0 and 00 in fin 
     # set starts =(1281); set runs   = (1 2 3 4 5 6 7 8 9)
     # set num    = 51

# #  member 60-70 # change 00 and 0 in fin 
     # set starts =(1281);  set runs   = (10 11 12 13 14 15 16 17 18 19 20)
     # set num    = 60

# # member 71-80 # change 0 and 00 in fin 
      # set starts =(1301); set runs   = (1 2 3 4 5 6 7 8 9)
      # set num    = 71 
      # set starts =(1301); set runs   = (3)
      # set num    = 73

# #  member 80-90 # change 00 and 0 in fin 
      # set starts =(1301);  set runs   = (10 11 12 13 14 15 16 17 18 19 20)
      # set num    = 80
     # set starts =(1301);  set runs   = (19)
     #  set num    = 89

# member 91-99  # change 0 to 00 in fin
    # set starts =(1171);  set runs   = (9)
    # set num    = 99

# # # member 100 # change 00 to 0 in fin
     # set starts =(1191);  set runs   = (10)
     # set num    = 100





foreach startyr ( $starts )
foreach run ( $runs )

echo "startyr & run :::::::::::::::::::::" ${startyr} ${num} "::::::::::::::::::::::"
   set pathi = /.../${var}
   set patho = /.../${var}/proc
   set fin = $pathi/b.e21.*.f09_g17.LE2-${startyr}.00${run}.cam.h0.${var}.*.nc
   # set fin = $pathi/b.e21.*.f09_g17.LE2-${startyr}.0${run}.cam.h0.${var}.*.nc

### combine
    set fcom = $patho/Combine.nc
    rm -rf $fcom
	#cdo cat $fin $fcom
    cdo mergetime $fin $fcom
### select date
    set ftime = $patho/SelectYr.nc
    rm -rf $ftime
    cdo selyear,1950/2020 $fcom $ftime

### selbox and fldmean
    set farctic = $patho/${var}_global_60S90N_19502020_${num}.nc
    rm -rf $farctic
    cdo sellonlatbox,0,360,-60,90 $ftime $farctic #sellonlatbox,lon1,lon2,lat1,lat2 ifile ofile
    

rm -rf $fcom
rm -rf $ftime

@ num = $num + 1

end
end



exit
				      ~                     
