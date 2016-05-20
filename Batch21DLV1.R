args=(commandArgs(TRUE))
start.date = format(Sys.Date()-1, "%Y-%m-%d")
end.date = format(Sys.Date(), "%Y-%m-%d")
library(RMySQL)
library(DBI)
library(methods)
if(length(args)==0){
  #print("No arguments supplied.")
  ##supply default values
  start.date = format(Sys.Date()-1, "%Y-%m-%d")
  end.date = format(Sys.Date(), "%Y-%m-%d")
}else{
  start.date="2015-11-23" 
  start.date="2015-11-24" 
}

#start.date ="2015-12-11" 
#end.date ="2015-12-12" 

#setwd("C:/reports")

tvtime_format<-function() {
  function(x) {
    v<-character(length(x))
    notNA<-!is.na(x)
    lt <- as.POSIXlt(x[notNA])
    hour <- lt$hour
    min <- lt$min
    v[notNA]<-sprintf("%02d:%02d", hour, min)
    v
  }
}


#mydb = dbConnect(MySQL(), user='gatuser', password='gatuser', dbname='gatmgr2', host='10.8.7.63')
mydb = dbConnect(MySQL(), user='gatread', password='gatread_PP', dbname='gatmgr', host='10.201.1.48')



top15steps = dbSendQuery(mydb, paste("SELECT se.start_time, se.end_time, CONCAT(LEFT(ji.job_name,30),' :',LEFT(se.step_name,25)),
ji.job_name color  
FROM cas_spr_step_execution se,cas_spr_job_execution je,`cas_spr_job_instance` ji
   WHERE
   se.`job_execution_id` = je.`job_execution_id`
   AND ji.`job_instance_id` = je.`job_instance_id`
   AND se.start_time > '",start.date, " 18:00:00' AND se.start_time < '",end.date ," 2:00:00'
   AND LOWER(se.step_name) NOT LIKE '%master%'   
   ORDER BY TIME_TO_SEC(TIMEDIFF(se.end_time , se.start_time)) desc,se.start_time desc LIMIT 0,15",sep=' '))

top15steps.df <- fetch(top15steps,n=-1)
dbClearResult(dbListResults(mydb)[[1]])

top15jobs = dbSendQuery(mydb, paste("SELECT * FROM (
	SELECT je.start_time, je.end_time,ji.job_name,
	ji.job_name color
	FROM  `cas_spr_job_execution` je,`cas_spr_job_instance` ji WHERE 
	ji.`job_instance_id` = je.`job_instance_id`	 AND 
  TIME_TO_SEC(TIMEDIFF(je.end_time , je.start_time)) > 300 AND
	je.start_time > '",start.date, " 18:00:00' AND je.start_time < '",end.date ," 2:00:00'
	AND LOWER(ji.job_name) NOT LIKE '%master%'
	ORDER BY TIME_TO_SEC(TIMEDIFF(je.end_time , je.start_time)) DESC LIMIT 0,15
) sub ORDER BY start_time ASC",sep=' '))



top15jobs.df <- fetch(top15jobs,n=-1)
dbClearResult(dbListResults(mydb)[[1]])

topStepsData = dbSendQuery(mydb, paste("SELECT TIME_TO_SEC(TIMEDIFF(se0.end_time , se0.start_time))/60 AS duration,se0.step_name, DATE(se0.start_time) as start_time,se2.JobStep,`read_count`,`write_count` FROM  cas_spr_step_execution se0,
        (SELECT se.step_name ,se.start_time, CONCAT(LEFT(ji.job_name,30),' :',LEFT(se.step_name,25)) AS JobStep
         FROM cas_spr_step_execution se,cas_spr_job_execution je,`cas_spr_job_instance` ji
         WHERE
         se.`job_execution_id` = je.`job_execution_id`
         AND ji.`job_instance_id` = je.`job_instance_id`
         AND se.start_time > '",start.date, " 18:00:00' AND se.start_time < '",end.date ," 2:00:00'
         AND LOWER(se.step_name) NOT LIKE '%master%'         
         ORDER BY  TIME_TO_SEC(TIMEDIFF(se.end_time , se.start_time)) DESC, se.start_time
         LIMIT 0,5
        ) se2 WHERE se0.step_name = se2.step_name
        AND TIME(se0.start_time) > '18:00:00' AND TIME(se0.start_time) < '2:00:00'
        AND DATE(se0.start_time)  >= ADDDATE('",start.date, "',-7)
        AND DATE(se0.end_time) <= '",end.date ,"'
        ORDER BY se0.step_name, se0.start_time DESC",sep=' '))

topStepsData.df <- fetch(topStepsData,n=-1)
dbClearResult(dbListResults(mydb)[[1]])

# close db connection
dbDisconnect(mydb)

# load libs
library(reshape2)
library(ggplot2)
library(scales)
library(sendmailR)


top15steps.dfr <- data.frame(
  name        = factor(top15steps.df[,3],levels=top15steps.df[,3]),
  start.date  = as.POSIXlt(top15steps.df[,1]),
  end.date    = as.POSIXlt(top15steps.df[,2]),
  cus.color = top15steps.df[,4]
)
top15steps.mdfr <- melt(top15steps.dfr, measure.vars = c("start.date", "end.date"))


top15jobs.dfr <- data.frame(
  name        = factor(top15jobs.df[,3],levels=top15jobs.df[,3]),
  start.date  = as.POSIXlt(top15jobs.df[,1]),
  end.date    = as.POSIXlt(top15jobs.df[,2]),
  cus.color = top15jobs.df[,4]
)
top15jobs.mdfr <- melt(top15jobs.dfr, measure.vars = c("start.date", "end.date"))





#dev.off()




