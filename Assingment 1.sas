/**************************** SAS Assingment-1 *****************************************/
/*Name:- Alok Kumar Singh															  */
/*ID:-   19250990																	 */
/************************************************************************************/


/*Q1 a) Read The data into the ST662 SAS Library */
proc import out= ST662Lib.ToeNail
datafile= "/courses/d77u30vavpRs0h7u2Ms92/ST662_data/Toenail.xlsx"
dbms=xlsx replace;
getnames= yes;
run;

/*b) Create a variable in your dataset that is unique for each row of data*/

data ST662Lib.ToeNail;
set ST662Lib.Toenail;
Obs = _n_;
run;

/*c) Create SAS code to screen the data for any anomalies*/

proc freq data= ST662Lib.ToeNail;
tables Gender  Treat ID Time Y / nocum nopercent;
run;

proc univariate data=ST662Lib.ToeNail plots;
var ID Time Y;
run;



/*(d Create SAS code to deal with any anomalies that you have found. i.e. generate code to either
change the observation (if there is an obvious error) or to mark the observation as missing.*/


/* While checking Gender field there were 8 observations that have gender as A which suggest the anamoly
in gender field as it should only have either "Male" or "Female" so we will mark these 8 Observations as 
missing values as we are not sure about the exact values of these observations */


/*Simillarly for Treat Field there is 1 observation with value A. This field should have value only
either 1 or 0 so we will mark this observation also as missing value as we are not sure about the 
exact value of this observation*/


/*There was 1 observation for time which had value 13 and according to our data time can only have values
from 0,1,2,3,6,9 and 12 so marked this value as missing as we are not sure about the value.*/


/*In field Y there were 2 observations(with value 4 and 5) which were having values other then 0 and 1 
so marked those values as missing.*/


/*In Id field the last value was 722 and all the Ids were in sequence from 1-294 so chnaged this 
value to 295 to make it a sequence from 1-295.*/

data ST662Lib.ToeNail;
set ST662Lib.ToeNail;
if Gender in ('Male','Female','')  then Gender = Gender; else Gender = '';
if Treat in ('0','1','') then Treat = Treat ; else Treat = '';
if Time in (0,1,2,3,6,9,12) then Time = Time; else Time = .;
if Y in (0,1) then Y = Y; else Y = .;
if ID = 722 then ID = 295; else ID = ID;
run;
