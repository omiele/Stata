**IPAQ- INTERNATIONAL PHYSICAL ACTIVITY QUESTIONEER
import excel "C:\Users\Home\Documents\Assigns\7 IPAQ.xlsx", sheet("7 IPAQ") firstrow
** Qstn 1: On how many days did you perform the activities?
*input vig_days
if Q1 == "No vigorous physical activities" {
gen vig_days = 0
}
else{
gen vig_days = real(Q1)
}

** Qstn 2: What time did you spend performing the vigorous physical activities in hours and minutes?
*input vig_hrs vig_mins
gen vig_hrs = Q2Hoursperday
gen vig_mins = Q2Minperday
gen vig_dont = Q2Dontknow
if missing(vig_dont) {
gen vig_min =  vig_hrs*60 + vig_mins
gen vig_met = vig_min*vig_days*8
}
else{
gen vig_min =  0
gen vig_met = 0
}
gen vig_Score=""
gen vig_cat=.
replace vig_Score = "High" if vig_min >= 60
replace vig_cat = 3 if vig_min >= 60   
replace vig_Score = "Moderate" if vig_min >= 30 & vig_min < 60 
replace vig_cat = 2 if vig_min >= 30 & vig_min < 60 
replace vig_Score = "Low" if vig_min < 30
replace vig_cat = 1 if vig_min < 30   


** Qstn 3: On how many days did you perform the moderate activities?
*input mod_days
if Q3 == "No moderate physical activities" {
gen mod_days = 0
}
else{
gen mod_days = real(Q3)
}

** Qstn 4: What time did you spend performing the moderate activities in hours and minutes?
*input mod_hrs mod_mins
gen mod_hrs = Q4Hoursperday
gen mod_mins = Q4Minperday
gen mod_dont = Q4Dontknow
if missing(mod_dont) {
gen mod_min =  mod_hrs*60 + mod_mins
gen mod_met = mod_min*mod_days*8
}
else{
gen mod_min =  0
gen mod_met = 0
}

gen mod_Score=""
gen mod_cat=.
replace mod_Score = "High" if mod_min >= 60
replace mod_cat = 3 if mod_min >= 60  
replace mod_Score = "Moderate" if mod_min >= 30 & mod_min < 60 
replace mod_cat = 2 if mod_min >= 30 & mod_min < 60
replace mod_Score = "Low" if mod_min < 30  
replace mod_cat = 1 if mod_min < 30  


** Qstn 5: On how many days did you perform the walking activities?
*input walk_days
if Q5 == "No walking" {
gen walk_days = 0
}
else{
gen walk_days = real(Q5)
}

** Qstn 6: What time did you spend performing the walking activities in hours and minutes?
*input walk_hrs walk_mins 
gen walk_hrs = Q6Hoursperday
gen walk_mins = Q6Minperday
gen walk_dont = Q6Dontknow

gen walk_min =  walk_hrs*60 + walk_mins
gen walk_met = walk_min*walk_days*8

gen walk_Score=""
gen walk_cat=.
replace walk_Score = "High" if walk_min >= 60 
replace walk_cat = 3 if walk_min >= 60  
replace walk_Score = "Moderate" if walk_min >= 30 & walk_min < 60
replace walk_cat = 2 if walk_min >= 30 & walk_min < 60
replace walk_Score = "Low" if walk_min < 30  
replace walk_cat = 1 if walk_min < 30   

** Qstn 7: How much time did you spend sitting in a weekday?
*input sit_hrs sit_mins
gen sit_hrs = Q6Hoursperday
gen sit_mins = Q6Minperday
gen sit_dont = Q6Dontknow 
if missing(sit_dont) {
gen sit_time = (sit_hrs*60 + sit_mins)*5
}
else{
gen sit_time = 0
}

gen ipaqScore=""
gen ipaqCat=.


replace ipaqScore = "Moderate" if vig_days >= 3 & vig_min >= 20 | mod_days + walk_days >= 5 & walk_min + mod_min >= 30 | mod_days + walk_days +vig_days >= 5 & walk_met+vig_met+mod_met >= 600
replace ipaqCat = 2 if vig_days >= 3 & vig_min >= 20 | mod_days + walk_days >= 5 & walk_min + mod_min >= 30 | mod_days + walk_days +vig_days >= 5 & walk_met+vig_met+mod_met >= 600
replace ipaqScore = "High" if vig_days >= 3 & vig_met >= 3000 | mod_days+vig_days+walk_days >= 7 & walk_met+vig_met+mod_met >= 3000
replace ipaqCat = 3 if vig_days >= 3 & vig_met >= 3000 | mod_days+vig_days+walk_days >= 7 & walk_met+vig_met+mod_met >= 3000
replace ipaqScore = "Low" if vig_days < 3 & vig_min < 20 | mod_days + walk_days +vig_days < 5 & walk_met+vig_met+mod_met < 600
replace ipaqCat = 1 if vig_days < 3 & vig_min < 20 | mod_days + walk_days +vig_days < 5 & walk_met+vig_met+mod_met < 600
gen partIds = _n 
 
 

**DIETARY QUESTIONEER
import excel "C:\Users\Home\Documents\Assigns\sample dietary2(1).xlsx", sheet("Sheet1") firstrow
** Qstn 8: How old are you?
gen age=Howoldareyou
** Qstn 9: Are you male or female?
** Male
** Female
gen qstn8_score=.
replace qstn8_score=1 if Gender=="Male"
replace qstn8_score=2 if Gender=="Female"

** Qstn 10: During the past month, how often did you eat hot or cold cereals?
** Never 
** 1 time last month 
** 2-3 times last month 
** 1 time per week 
** 2 times per week 
** 3-4 times per week 
** 5-6 times per week 
** 1 time per day 
** 2 or more times per day
 gen qstn10_score=.
 replace qstn10_score=0 if OftenCereals=="Never"
 replace qstn10_score=0.033 if OftenCereals=="1 time last month"
 replace qstn10_score=0.083 if OftenCereals=="2-3 times last month"
 replace qstn10_score=0.143 if OftenCereals=="1 time per week"
 replace qstn10_score=0.286 if OftenCereals=="2 times per week"
 replace qstn10_score=0.5 if OftenCereals=="3-4 times per week"
 replace qstn10_score=0.786 if OftenCereals=="5-6 times per week"
 replace qstn10_score=1 if OftenCereals=="1 time per day"
 replace qstn10_score=2 if OftenCereals=="2 or more times per day"


** Qstn 11: During the past month, what kind of cereal did you usually eat?
gen cerealkind=KindofCereal

** Qstn 12: If there was another kind of cereal that you usually ate during the past month, what kind was it?
gen othercereal=OtherKindofCereal

** Qstn 13: During the past month, how often did you have any milk?
** Never 
** 1 time last month 
** 2-3 times last month 
** 1 time per week 
** 2 times per week 
** 3-4 times per week 
** 5-6 times per week 
** 1 time per day 
** 2-3 times per day
** 4-5 times per day
** 6 or more times per day
 gen qstn13_score=.
 replace qstn13_score=0 if OftenMilk=="Never"
 replace qstn13_score=0.033 if OftenMilk=="1 time last month"
 replace qstn13_score=0.083 if OftenMilk=="2-3 times last month"
 replace qstn13_score=0.143 if OftenMilk=="1 time per week"
 replace qstn13_score=0.286 if OftenMilk=="2 times per week"
 replace qstn13_score=0.5 if OftenMilk=="3-4 times per week"
 replace qstn13_score=0.786 if OftenMilk=="5-6 times per week"
 replace qstn13_score=1 if OftenMilk=="1 time per day"
 replace qstn13_score=2.5 if OftenMilk=="2-3 times per day"
 replace qstn13_score=4.5 if OftenMilk=="4-5 times per day"
 replace qstn13_score=6 if OftenMilk=="6 or more times per day"


** Qstn 14: During the past month, what kind of milk did you usually drink?
** Whole or regular milk - a 
** 2% fat or reduced-fat milk - b 
** 1%, 1/2%, or low-fat milk  - c
** Fat-free, skim or nonfat milk  - d
** Soy milk  - e
** Other kind of milk - f
gen milktype=""
replace milktype="a" if KindofMilk == "Whole or regular milk"
replace milktype="b" if KindofMilk == "2% fat or reduced-fat milk"
replace milktype="c" if KindofMilk == "1%, 1/2%, or low-fat milk"
replace milktype="d" if KindofMilk == "Fat-free, skim or nonfat milk"
replace milktype="e" if KindofMilk == "Soy milk"
replace milktype="f" if missing(KindofMilk)

** Qstn 15: During the past month, how often did you drink regular soda or pop that contains sugar?
** Never 
** 1 time last month 
** 2-3 times last month 
** 1 time per week 
** 2 times per week 
** 3-4 times per week 
** 5-6 times per week 
** 1 time per day 
** 2-3 times per day
** 4-5 times per day
** 6 or more times per day
 gen qstn15_score=.
 replace qstn15_score=0 if OftenSoda=="Never"
 replace qstn15_score=0.033 if OftenSoda=="1 time last month"
 replace qstn15_score=0.083 if OftenSoda=="2-3 times last month"
 replace qstn15_score=0.143 if OftenSoda=="1 time per week"
 replace qstn15_score=0.286 if OftenSoda=="2 times per week"
 replace qstn15_score=0.5 if OftenSoda=="3-4 times per week"
 replace qstn15_score=0.786 if OftenSoda=="5-6 times per week"
 replace qstn15_score=1 if OftenSoda=="1 time per day"
 replace qstn15_score=2.5 if OftenSoda=="2-3 times per day"
 replace qstn15_score=4.5 if OftenSoda=="4-5 times per day"
 replace qstn15_score=6 if OftenSoda=="6 or more times per day"


** Qstn 16: During the past month, how often did you eat any kind of fried potatoes, including french fries, home fries, or hash brown potatoes?
** Never 
** 1 time last month 
** 2-3 times last month 
** 1 time per week 
** 2 times per week 
** 3-4 times per week 
** 5-6 times per week 
** 1 time per day 
** 2 or more times per day
 gen qstn16_score=.
 replace qstn16_score=0 if OftenFriedPotatoes=="Never"
 replace qstn16_score=0.033 if OftenFriedPotatoes=="1 time last month"
 replace qstn16_score=0.083 if OftenFriedPotatoes=="2-3 times last month"
 replace qstn16_score=0.143 if OftenFriedPotatoes=="1 time per week"
 replace qstn16_score=0.286 if OftenFriedPotatoes=="2 times per week"
 replace qstn16_score=0.5 if OftenFriedPotatoes=="3-4 times per week"
 replace qstn16_score=0.786 if OftenFriedPotatoes=="5-6 times per week"
 replace qstn16_score=1 if OftenFriedPotatoes=="1 time per day"
 replace qstn16_score=2 if OftenFriedPotatoes=="2 or more times per day"
 
