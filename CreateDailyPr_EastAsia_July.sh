#!/bin/csh -fxv
###

set vars = (PRECT)  # PRECL PRECT
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




       

set decades = (1950 1960 1970 1980 1990 2000 2010)


  set pathi = /.../${var}
  set patho = /.../${var}/proc
 
foreach startyr ( $starts )
foreach run ( $runs )
foreach decade ($decades)
   set fin = $pathi/b.e21.BHIST*.f09_g17.LE2-${startyr}.00${run}.cam.h1.${var}.${decade}*.nc
   # set fin = $pathi/b.e21.BHIST*.f09_g17.LE2-${startyr}.0${run}.cam.h1.${var}.${decade}*.nc

echo "startyr & run :::::::::::::::::::::" ${startyr} ${num} ${decade} "::::::::::::::::::::::"

### proc individual file
### select month
    set fmon = $patho/MON.nc 
    # rm -rf $fmon
    # cdo selmon,5,6,7,8 $fin $fmon
    cdo selsmon,7 $fin $fmon
### selbox 
    set farea = $patho/${var}_EastAsia_July_${num}_${decade}.nc ###
    rm -rf $farea
    cdo sellonlatbox,100,160,0,50 $fmon $farea #sellonlatbox,lon1,lon2,lat1,lat2 ifile ofile


rm -rf $fmon
end


### combine middle files
   set fin_sub = $patho/${var}_EastAsia_July_${num}_*.nc
 # combine
    set fcom = $patho/${var}_EastAsia_July_${num}_combine_19502014.nc ###
    rm -rf $fcom
    cdo mergetime $fin_sub $fcom  


rm -rf ${fin_sub}



@ num = $num + 1
end
end



exit
				      ~                     
