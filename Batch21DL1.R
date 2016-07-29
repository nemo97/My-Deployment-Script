library(RMySQL)

## connecttion
mydb



rs21dl = dbSendQuery(mydb, "SELECT start_time, end_time, CONCAT('21DL:',RIGHT(se.step_name,25))
FROM cas_spr_step_execution se
WHERE job_execution_id = (SELECT MAX(je.job_execution_id) FROM cas_spr_step_execution se,cas_spr_job_execution je,`cas_spr_job_instance` ji
WHERE
se.`job_execution_id` = je.`job_execution_id`
AND ji.`job_instance_id` = je.`job_instance_id`
AND ji.`job_name`='RDS-CMIS') 
AND TIME_TO_SEC(TIMEDIFF(end_time , start_time)) > 200
UNION 
SELECT start_time, end_time, CONCAT('25DL:',RIGHT(se.step_name,25))
FROM cas_spr_step_execution se
                     WHERE 
TIME_TO_SEC(TIMEDIFF(end_time , start_time)) > 200
AND job_execution_id = 
(SELECT MAX(je.job_execution_id) FROM 
      cas_spr_step_execution se,
      cas_spr_job_execution je,
      cas_spr_job_instance ji
   WHERE
   se.`job_execution_id` = je.`job_execution_id`
   AND ji.`job_instance_id` = je.`job_instance_id`
   AND UPPER(ji.`job_name`)=UPPER('RDS-Create-AR-FPS-Account-Files-Batch'))")

#rs25dl = dbSendQuery(mydb, "")
rds21dl.df <- fetch(rs21dl,n=-1)
#rds21dl.df <- fetch(rs25dl,n=-1)

dbClearResult(dbListResults(mydb)[[1]])

# load libs
library(reshape2)
library(ggplot2)

#rds21dl.df <- rbind(rds21dl.df,rds25dl.df)
tasks <- rds21dl.df[,3]
dfr <- data.frame(
name        = factor(tasks, levels = tasks),
start.date  = as.POSIXlt(rds21dl.df[,1]),
end.date    = as.POSIXlt(rds21dl.df[,2])
#is.critical = c(TRUE, FALSE, FALSE, TRUE)
)
#pdf("plots.pdf")
mdfr <- melt(dfr, measure.vars = c("start.date", "end.date"))
ggplot(mdfr, aes(value, name))  + geom_line(size = 6, colour="red") + xlab(paste("Time line ",as.Date(rds21dl.df[1,1]))) + ylab("Batch Job:Step Name")
 
#print(p)
#dev.off()
