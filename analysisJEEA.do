** Analysis on the effect of wage rate and incentives on workers. The data for this analysis can be obtained from the link 
** https://www.dropbox.com/s/gbn4vi5idne36z6/datasetJEEA.dta?dl=0

clear
set mem 20m
set more off

****Descriptives****
clear

*tabout id baseline if baseline ==1 using myfile.txt,  ///
 *        replace c(mean books)

tabulate id baseline if baseline ==1, summarize(books) nostandard nofreq noobs
tabulate id paycut if paycut ==1, summarize(books) nostandard nofreq noobs
tabulate id paycut if payraise ==1, summarize(books) nostandard nofreq noobs

*****Non-parametric Analysis*****

*Quarterly Data
clear
use datasetJEEA

tabstat books if baseline==1 , stats(mean sd) by(quarter)
tabstat books if payraise==1 , stats(mean sd) by(quarter)
tabstat books if paycut==1 , stats(mean sd) by(quarter)

ranksum books if (baseline==1 | paycut==1) & quarter1==1, by(paycut)
ranksum books if (baseline==1 | paycut==1) & quarter2==1, by(paycut)
ranksum books if (baseline==1 | paycut==1) & quarter3==1, by(paycut)
ranksum books if (baseline==1 | paycut==1) & quarter4==1, by(paycut)

ranksum books if (baseline==1 | payraise==1) & quarter1==1, by(payraise)
ranksum books if (baseline==1 | payraise==1) & quarter2==1, by(payraise)
ranksum books if (baseline==1 | payraise==1) & quarter3==1, by(payraise)
ranksum books if (baseline==1 | payraise==1) & quarter4==1, by(payraise)

*Aggregated Data
clear
use datasetJEEA

collapse baseline piecerate payraise paycut age male math engineer social econ pastwage room1 room2 room3 room4 room5 room6  startingtime (sum) books books_correct, by(treat id)
gen quality=(books_correct/books)

mean books if baseline==1
mean books if payraise==1
mean books if paycut==1
mean books if piecerate==1

ranksum books if baseline==1 | paycut==1, by(paycut)
ranksum books if baseline==1 | payraise==1 , by(payraise)
ranksum books if baseline==1 | piecerate==1 , by(piecerate)


mean quality if baseline==1
mean quality if payraise==1
mean quality if paycut==1
mean quality if piecerate==1
ranksum quality if baseline==1 | paycut==1, by(paycut)
ranksum quality if baseline==1 | payraise==1 , by(payraise)
ranksum quality if baseline==1 | piecerate==1 , by(piecerate)

tabstat  age male math engineer social econ pastwage room1 room2 room3 room4 room5 room6  startingtime, stat(mean sd N) by(treat) columns(statistics)


**** Regression Analysis******
clear
use datasetJEEA

/*Coef. and Std. Err. Values used for column 1 of table 2*/
reg books payraise paycut quarter2 quarter3 quarter4  age male math engineer social  room2 room3 room4 room5 startingtime if piecerate==0, cluster(id) robust

/* Coef. and Std. Err. Values used for column 2 of table 2*/
reg books payraise paycut quarter2 quarter3 quarter4 payraisequarter2 payraisequarter3 payraisequarter4 paycutquarter2 paycutquarter3 paycutquarter4  age male math engineer social  room2 room3 room4 room5 startingtime if piecerate==0, cluster(id) robust

/* Coef. and Std. Err. Values used for column 3 of table 2*/
reg books_correct payraise paycut quarter2 quarter3 quarter4 payraisequarter2 payraisequarter3 payraisequarter4 paycutquarter2 paycutquarter3 paycutquarter4  age male math engineer social  room2 room3 room4 room5 startingtime if piecerate==0, cluster(id) robust


*** Analysis of Graphs******

**Quarter Performance
clear
use datasetJEEA

collapse (mean) books, by(quarter treat)
recode quarter (0=90) (1=180) (2=270) (3=360)  
twoway (connected books quarter if treat==1,lpattern(vshortdash) msymbol(circle)lwidth(medthick) msize(medlarge) lcolor(blue) mcolor(blue) )  (connected books quarter if treat==2, lwidth(medthick) msymbol(square)msize(medlarge)lcolor(orange) mcolor(orange)) (connected books quarter if treat==3, lpattern(longdash) lwidth(medthick) msymbol(triangle)msize(medlarge)lcolor(red) mcolor(red))    , ytitle(Average # of book entries per quarter, size(large) margin(medsmall)) ttitle(Quarter, size(large) margin(medsmall)) tlabel(90 "I" 180 "II" 270 "III" 360 "IV") legend(ring(0) pos(4) order(1 2 3) label(1 "PayRaise")  label(2 "Baseline") label(3 "PayCut")   col(1) region(lp(blank)))   name(output1, replace)   title((a) Productivity Development Over Time, box bexpand size(large)  fcolor(gs14)  margin(medium)) graphregion(color(white)) plotregion(lcolor(grey)) ylabel(,grid glcolor(gs12)) fxsize(83) saving(effort1, replace)

twoway (connected books quarter if treat==4,lpattern(vshortdash) msymbol(circle)lwidth(medthick) msize(medlarge) lcolor(blue) mcolor(blue) )  (connected books quarter if treat==2, lwidth(medthick) msymbol(square)msize(medlarge)lcolor(orange) mcolor(orange)) , ytitle(Average # of book entries per quarter, size(large) margin(medsmall)) ttitle(Quarter, size(large) margin(medsmall)) tlabel(90 "I" 180 "II" 270 "III" 360 "IV") legend(ring(0) pos(4) order(1 2) label(1 "PieceRate")  label(2 "Baseline") col(1) region(lp(blank)))   name(output1, replace)   title((a) Productivity Development Over Time, box bexpand size(large)  fcolor(gs14)  margin(medium)) graphregion(color(white)) plotregion(lcolor(grey)) ylabel(,grid glcolor(gs12)) fxsize(83) saving(effort2, replace)

**Functions of cumaltive distribution
clear
use datasetJEEA

collapse (mean) books, by(treat id)

cumul books if treat==1, gen(cdf1) equal
cumul books if treat==2, gen(cdf2) equal
cumul books if treat==3, gen(cdf3) equal
cumul books if treat==4, gen(cdf4) equal

twoway (connected cdf1 books, sort lpattern(vshortdash) msymbol(circle)lwidth(medthick) msize(medlarge) lcolor(blue) mcolor(blue)) (connected cdf2 books, sort lwidth(medthick) msymbol(square)msize(medlarge)lcolor(orange) mcolor(orange)) (connected cdf3 books, sort lpattern(longdash) lwidth(medthick) msymbol(triangle)msize(medlarge)lcolor(red) mcolor(red)), ytitle(Cumulative Probability, margin(medium) size(large))  ttitle(Total number of book entries, margin(medsmall) size(large))  legend(ring(0) pos(4) order(1 2 3) label(1 "PayRaise") label(2 "Baseline") label(3 "PayCut")   col(1) region(lp(blank)) ) title((b) Cumulative Distribution Functions, box bexpand size(large)  fcolor(gs14)  margin(medium)) graphregion(color(white)) plotregion(lcolor(grey)) ylabel(,grid glcolor(gs12)) saving(cdf1, replace)

twoway (connected cdf4 books, sort lpattern(vshortdash) msymbol(circle)lwidth(medthick) msize(medlarge) lcolor(blue) mcolor(blue)) (connected cdf2 books, sort lwidth(medthick) msymbol(square)msize(medlarge)lcolor(orange) mcolor(orange)), ytitle(Cumulative Probability, margin(medium) size(large))  ttitle(Total number of book entries, margin(medsmall) size(large))  legend(ring(0) pos(4) order(1 2) label(1 "PieceRate") label(2 "Baseline")   col(1) region(lp(blank)) ) title((b) Cumulative Distribution Functions, box bexpand size(large)  fcolor(gs14)  margin(medium)) graphregion(color(white)) plotregion(lcolor(grey)) ylabel(,grid glcolor(gs12)) saving(cdf2, replace)

*Graph 2
graph combine effort1.gph cdf1.gph, rows(1) imargin(small)  graphregion(color(white)) xsize(7) saving(Graph2, replace)
*Graph 3
graph combine effort2.gph cdf2.gph, rows(1) imargin(small)  graphregion(color(white)) xsize(7) saving(Graph3, replace)





