#!/bin/bash

awk -F, '{ if  ($1 ~ /tm[0-9]*/ || $1 ~ /ts[0-9]*/) print $0 }' titles.cvs > titles3.cvs
wc1=$(wc -l < titles.cvs )
wc2=$(wc -l < titles3.cvs)
wc3=$[($wc1 - $wc2)]
echo "Línies eliminades en el pas 1: $wc3"

grep "^[[:alnum:]]*,[#\¿\¡\!\'\[:digit:]A-Za-z]" titles3.cvs > titles4.cvs

wc4=$(wc -l < titles4.cvs)
wc5=$[($wc2 - $wc4)]
echo "Línies eliminades en el pas 2: $wc5"
 
awk -F, '{ if ($0 ~ /MOVIE/) print $0 }' titles4.cvs > Movies.cvs
wc6=$(wc -l < Movies.cvs)
wc7=$[($wc4 - $wc6)]
echo "Línies al document Movies: $wc7"

awk -F, '{ if ($0 ~ /SHOW/) print $0 }' titles4.cvs > Shows.cvs
wc8=$(wc -l < Shows.cvs)
wc9=$[($wc4 - $wc8)]
echo "Línies al document Shows: $wc9"

awk -F, '{ if ( ($12 != "") ) print $0 }' Movies.cvs > Movies12.cvs
awk -F, '{ if ( ($13 != "") ) print $0 }' Movies12.cvs > Movies13.cvs
awk -F, '{ if ( ($14 != "") ) print $0 }' Movies13.cvs > Movies14.cvs
awk -F, '{ if ( ($15 != "") ) print $0 }' Movies14.cvs > Movies15.cvs

wc10=$(wc -l < Movies12.cvs)
wc11=$(wc -l < Movies13.cvs)
wc12=$(wc -l < Movies14.cvs)
wc13=$(wc -l < Movies15.cvs)
wc14=$[($wc6 - $wc13)]
echo "Línies eliminades al pas 4 (Movies): $wc14"


awk -F, '{ if ( ($12 != "") ) print $0 }' Shows.cvs > Shows12.cvs
awk -F, '{ if ( ($13 != "") ) print $0 }' Shows12.cvs > Shows13.cvs
awk -F, '{ if ( ($14 != "") ) print $0 }' Shows13.cvs > Shows14.cvs
awk -F, '{ if ( ($15 != "") ) print $0 }' Shows14.cvs > Shows15.cvs

wc15=$(wc -l < Shows12.cvs)                        
wc16=$(wc -l < Shows13.cvs)
wc17=$(wc -l < Shows14.cvs)
wc18=$(wc -l < Shows15.cvs)
wc19=$[($wc8 - $wc18)]
echo "Línies eliminades al pas 4 (Shows): $wc19"

max_imdb=$(awk -F, 'BEGIN{max=0}{if($13>max)(max=$13)}END{print max}' Movies15.cvs)
echo "Max_imdb (Movies): $max_imdb"

awk -F, -v calcul=$max_imdb 'BEGIN{OFS=","}{$16=($12*($13/calcul))}{print}' Movies15.cvs > Movies16.cvs

max_tmdb=$(awk -F, 'BEGIN{max=0}{if($14>max)(max=$14)}END{print max}' Movies15.cvs)
echo "Max_tmdb (Movies): $max_tmdb"

awk -F, -v calcul1=$max_tmdb 'BEGIN{OFS=","}{$17=($15*($14/calcul1))}{print}' Movies16.cvs > Movies17.cvs


max_imdb=$(awk -F, 'BEGIN{max=0}{if($13>max)(max=$13)}END{print max}' Shows15.cvs)
echo "Max_imdb (Shows): $max_imdb"

awk -F, -v calcul=$max_imdb 'BEGIN{OFS=","}{$16=($12*($13/calcul))}{print}' Shows15.cvs > Shows16.cvs

max_tmdb=$(awk -F, 'BEGIN{max=0}{if($14>max)(max=$14)}END{print max}' Shows15.cvs)
echo "Max_tmdb (Shows): $max_tmdb"

awk -F, -v calcul1=$max_tmdb 'BEGIN{OFS=","}{$17=($15*($14/calcul1))}{print}' Shows16.cvs > Shows17.cvs


####Pas 6
awk -F, 'BEGIN{max=0}{ if ( $12>max){max=$12}}END{print $1 $2 $9 $12}' Movies17.cvs
awk -F, 'BEGIN{max=0}{ if ( $12>max){max=$12}}END{print $1 $2 $9 $12}' Shows17.cvs
awk -F, 'BEGIN{max=0}{ if ( $13>max){max=$13}}END{print $1 $2 $9 $13}' Movies17.cvs
awk -F, 'BEGIN{max=0}{ if ( $13>max){max=$12}}END{print $1 $2 $9 $13}' Shows17.cvs
