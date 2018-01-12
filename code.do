** Code for comparing two access databases within stata and displaying any error that may appear together with 
** merging the datasets to remove duplication.

** Link to access files: https://www.dropbox.com/sh/wh5xttpx4ajvtqp/AAC5Ypr8CwI-kRRYp9FLPm4ra?dl=0

* setting up the working directory, starting log
cd "C:\Users\Home\Documents\Assigns\Data Entry 1.accdb" 
set more off  // lets the program run all commands without interumptions
log using output.log

*** ############################################## ***
//\       preparing first database                 \\/
*******************************************************


* converting tables from the first file
*****************************************
odbc list                              //visualizes lists of Data Source Name  and corresponding drivers
odbc query "db1a", dialog(noprompt)    //visualizes the list of tables in the database ===============================
odbc load, table("1 Demographics") dsn("db1a") clear //loads table 1 and clears any other data from memory
duplicates report StudentID              //displays number of duplicates on screen
duplicates drop StudentID, force         //removes duplicates
save tableA1.dta, replace                   //saves table 1 and replaces previous versions

odbc load, table("2 Alcohol") dsn("db1a") clear      //loads table 2 and clears any other data from memory
duplicates report StudentID              //displays number of duplicates on screen
duplicates drop StudentID, force         //removes duplicates
save tableA2.dta, replace                    //saves table 2 and replaces previous versions

odbc load, table("3 Stress") dsn("db1a") clear       //loads table 3 & clears any other data from memory
ren Student_ID temp                      // renames variable Student_ID into temp
destring temp, gen(Student_ID)           //stores StudentID in a new numeric variable, for consistency reasons (in the remaining tables, the variable is imported as numeric)
drop temp                                //deletes variable temp which is not needed anymore
duplicates report Student_ID             //displays number of duplicates on screen
duplicates drop Student_ID, force        //removes duplicates
save tableA3, replace                     //saves table 3 and replaces previous versions

odbc load, table("4 Mood") dsn("db1a") clear          //loads table 4 & clears any other data from memory
duplicates report Student_ID              //displays number of duplicates on screen
duplicates drop Student_ID, force         //removes duplicates
save tableA4, replace                        //saves table 4 and replaces previous versions

odbc load, table("5 Social Support") dsn("db1a") clear       //loads table 5 & clears any other data from memory
duplicates report Student_ID                     //displays number of duplicates on screen
duplicates drop Student_ID, force                //removes duplicates
save tableA5, replace                             //saves table 5 and replaces previous versions

odbc load, table("6 Wellness and Nutrition") dsn("db1a") clear       //loads table 6 & clears any other data from memory
duplicates report Student_ID                             //displays number of duplicates on screen
duplicates drop Student_ID, force                        //removes duplicates
save tableA6, replace                                      //saves table 6 and replaces previous versions

odbc load, table("7 IPAQ") dsn("db1a") clear       //loads table 7 & clears any other data from memory
duplicates report Student_ID           //displays number of duplicates on screen
duplicates drop Student_ID, force      //removes duplicates
save tableA7, replace                     //saves table 7 and replaces previous versions

odbc load, table("8 Dietary Screener Questionnaire") dsn("db1a") clear       //loads table 8 & clears any other data from memory
duplicates report Student_ID                                     //displays number of duplicates on screen
duplicates drop Student_ID, force                                //removes duplicates
save tableA8, replace                                               //saves table 8 and replaces previous versions

* merging tables from the first Access file
********************************************
use tableA1, clear                //loads the first table
merge m:m StudentID using tableA2, nogen     //merge with the second table (alc.dta), using Student ID as index, and generates no flag variable
ren StudentID  Student_ID                    //renames variable StudentID to Student_ID (as it is called in all remaining tables)  
merge m:m Student_ID using tableA3, nogen   //merge with the  table (stress.dta), using Student ID as index, and generates no flag variable
merge m:m Student_ID using tableA4, nogen     //merge with the  table (mood.dta), using Student ID as index, and generates no flag variable
merge m:m Student_ID using tableA5, nogen     //merge with the  table (socsup.dta), using Student ID as index, and generates no flag variable
merge m:m Student_ID using tableA6, nogen     //merge with the  table (wellN.dta), using Student ID as index, and generates no flag variable
merge m:m Student_ID using tableA7, nogen     //merge with the  table (IPAQ.dta), using Student ID as index, and generates no flag variable
merge m:m Student_ID using tableA8, nogen     //merge with the  table (diet.dta), using Student ID as index, and generates no flag variable


*saving the file
save db1, replace

*** ############################################### ***
//\       preparing SECOND database                 \\/
*******************************************************

* converting tables from the second file
*****************************************
odbc list                              //visualizes lists of Data Source Name  and corresponding drivers
odbc query "db2a", dialog(noprompt)    //visualizes the list of tables in the database
odbc load, table("1 Demographics") dsn("db2a") clear //loads table 1 and clears any other data from memory
duplicates report StudentID              //displays number of duplicates on screen
duplicates drop StudentID, force         //removes duplicates
save tableB1.dta, replace                   //saves table 1 and replaces previous versions

odbc load, table("2 Alcohol") dsn("db2a") clear      //loads table 2 and clears any other data from memory
duplicates report StudentID              //displays number of duplicates on screen
duplicates drop StudentID, force         //removes duplicates
save tableB2.dta, replace                    //saves table 2 and replaces previous versions

odbc load, table("3 Stress") dsn("db2a") clear       //loads table 3 & clears any other data from memory
ren Student_ID temp                      // renames variable Student_ID into temp
destring temp, gen(Student_ID)           //stores StudentID in a new numeric variable, for consistency reasons (in the remaining tables, the variable is imported as numeric)
drop temp                                //deletes variable temp which is not needed anymore
duplicates report Student_ID             //displays number of duplicates on screen
duplicates drop Student_ID, force        //removes duplicates
save tableB3, replace                     //saves table 3 and replaces previous versions

odbc load, table("4 Mood") dsn("db2a") clear          //loads table 4 & clears any other data from memory
duplicates report Student_ID              //displays number of duplicates on screen
duplicates drop Student_ID, force         //removes duplicates
save tableB4, replace                        //saves table 4 and replaces previous versions

odbc load, table("5 Social Support") dsn("db2a") clear       //loads table 5 & clears any other data from memory
duplicates report Student_ID                     //displays number of duplicates on screen
duplicates drop Student_ID, force                //removes duplicates
save tableB5, replace                             //saves table 5 and replaces previous versions

odbc load, table("6 Wellness and Nutrition") dsn("db2a") clear       //loads table 6 & clears any other data from memory
duplicates report Student_ID                             //displays number of duplicates on screen
duplicates drop Student_ID, force                        //removes duplicates
save tableB6, replace                                      //saves table 6 and replaces previous versions

odbc load, table("7 IPAQ") dsn("db2a") clear       //loads table 7 & clears any other data from memory
duplicates report Student_ID           //displays number of duplicates on screen
duplicates drop Student_ID, force      //removes duplicates
save tableB7, replace                     //saves table 7 and replaces previous versions

odbc load, table("8 Dietary Screener Questionnaire") dsn("db2a") clear       //loads table 8 & clears any other data from memory
duplicates report Student_ID                                     //displays number of duplicates on screen
duplicates drop Student_ID, force                                //removes duplicates
save tableB8, replace                                               //saves table 8 and replaces previous versions

* merging tables from the first Access file
********************************************
use tableB1, clear                //loads the first table
merge m:m StudentID using tableB2, nogen     //merge with the second table (alc.dta), using Student ID as index, and generates no flag variable
ren StudentID  Student_ID                    //renames variable StudentID to Student_ID (as it is called in all remaining tables)  
merge m:m Student_ID using tableB3, nogen   //merge with the  table (stress.dta), using Student ID as index, and generates no flag variable
merge m:m Student_ID using tableB4, nogen     //merge with the  table (mood.dta), using Student ID as index, and generates no flag variable
merge m:m Student_ID using tableB5, nogen     //merge with the  table (socsup.dta), using Student ID as index, and generates no flag variable
merge m:m Student_ID using tableB6, nogen     //merge with the  table (wellN.dta), using Student ID as index, and generates no flag variable
merge m:m Student_ID using tableB7, nogen     //merge with the  table (IPAQ.dta), using Student ID as index, and generates no flag variable
merge m:m Student_ID using tableB8, nogen     //merge with the  table (diet.dta), using Student ID as index, and generates no flag variable


*saving the file
save db2, replace



*** ############################################### ***
//\       comparing databases & tables              \\/
*******************************************************


* compare db1 and db2
use db1, clear                                //load the first data base 
append using db2, gen(db)      //merges the two datasets
lab var db "source database"   //labels the db variable
lab def sss 0 "db1" 1 "db2"    //defines value labels for db
lab val db sss                 //labels the values of db 
tab db            //number of cases in the two databases


* table by table comparison for first table (Demographics) etc.. (BELOW IS THE CODE I HAVE WRITTEN WHICH IS NOT DISPLAYING CORRECT RESULTS)

use tableB1, clear              //loads the table from the first dataset
append using tableB2, gen(db)   //merges withthe corresponding table from teh second data set
tab db            //number of cases in the two databases
drop db       //deletes variables db and ID, in order to be able to identify duplicates using _all option
duplicates report _all           //displays number of duplicates on screen
duplicates tag, gen(duptag)      //generates variable duptab, which is 1 if identical observations in teh two table, and 0 otherwise
list if duptag==0                //lists cases which are  not identical in the two tables--IT IS NOT DISPLAYING CASES THAT ARE NOT IDENTICAL???
IT IS IDENTFING AND DISPLAYING OTPUT THAT DOSENT MAKE SENSE DON'T KNOW WHY???????


clear                           //clears database from memory
forvalues i=1/8 {               //
	local A: word `i' of tableA1 tableA2 tableA3 tableA4 tableA5 tableA6 tableA7 tableA8    //puts in A the table i from the first dataset
	local B: word `i' of tableB1 tableB2 tableB3 tableB4 tableB5 tableB6 tableB7 tableB8    //puts in B the table i from the second dataset
	use `A', clear              //uses table i in database 1
	append using `B', gen(db)   //merges with the corresponding table from the second data set
	tab db            //number of cases in the two databases
	drop db  ID         //deletes variables db and ID, in order to be able to identify duplicates using _all option
	duplicates report _all           //displays number of duplicates on screen
	duplicates tag, gen(duptag)      //generates variable duptab, which is 1 if identical observations in teh two table, and 0 otherwise
	list if duptag==0                //lists cases which are not identical in the two tables FOR EACH COMPARISION ========= THIS IS NOT DISPLAYING ANY 
MEANINGFUL OUTPUT ALTHOUGH RUNNING 
}                               //



THIS ABOVE CODE WORKS BUT IT DOSENT CORRECTLY IDENTIFY MISMATCHES OR UNIQUE ENTRIES IN TABLE TO TABLE PAIRWISE COMPARTISIONS FOR EACH TABLE SET IN RESPECTIVE DATA BASE
