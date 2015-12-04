args=(commandArgs(TRUE))
start.date = format(Sys.Date()-1, "%Y-%m-%d")
end.date = format(Sys.Date(), "%Y-%m-%d")
if(length(args)==0){
  print("No arguments supplied.")
  ##supply default values
  start.date = format(Sys.Date()-1, "%Y-%m-%d")
  end.date = format(Sys.Date(), "%Y-%m-%d")
}else{
  start.date="2015-11-23" 
  start.date="2015-11-24" 
}

#start.date ="2015-11-27" 
#end.date ="2015-11-28" 

setwd("C:/reports")

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

library(RMySQL)
#mydb = dbConnect(MySQL(), user='gatuser', password='gatuser', dbname='gatmgr2', host='10.8.7.63')
mydb = dbConnect(MySQL(), user='gatread', password='gatread_PP', dbname='gatmgr', host='10.201.1.48')



rs21dl = dbSendQuery(mydb, paste("SELECT se.start_time, se.end_time, CONCAT(LEFT(ji.job_name,30),' :',LEFT(se.step_name,25)),
ji.job_name color  
FROM cas_spr_step_execution se,cas_spr_job_execution je,`cas_spr_job_instance` ji
   WHERE
   se.`job_execution_id` = je.`job_execution_id`
   AND ji.`job_instance_id` = je.`job_instance_id`
   AND se.start_time > '",start.date, " 18:00:00' AND se.start_time < '",end.date ," 2:00:00'
   AND LOWER(se.step_name) NOT LIKE '%master%'
   AND LOWER(se.step_name) NOT LIKE '%nightly%'
   ORDER BY TIME_TO_SEC(TIMEDIFF(se.end_time , se.start_time)) desc,se.start_time LIMIT 0,15",sep=' '))

#rs25dl = dbSendQuery(mydb, "")
rds21dl.df <- fetch(rs21dl,n=-1)
#rds21dl.df <- fetch(rs25dl,n=-1)

dbClearResult(dbListResults(mydb)[[1]])
# close db connection
dbDisconnect(mydb)

# load libs
library(reshape2)
library(ggplot2)
library(scales)
library(sendmailR)

#rds21dl.df <- rbind(rds21dl.df,rds25dl.df)
tasks <- rds21dl.df[,3]
dfr <- data.frame(
name        = factor(tasks, levels = tasks),
start.date  = as.POSIXlt(rds21dl.df[,1]),
end.date    = as.POSIXlt(rds21dl.df[,2]),
cus.color = rds21dl.df[,4]
)
fileName <- paste(as.Date(rds21dl.df[1,1]),".png",sep='')

png(fileName,width = 800, height = 488)
mdfr <- melt(dfr, measure.vars = c("start.date", "end.date"))

ggplot(mdfr, aes(value, name,colour=cus.color)) + geom_line(size = 6) + xlab(paste("Time line ",as.Date(rds21dl.df[1,1]))) + ylab("Batch Job:Step Name") + scale_x_datetime(breaks = date_breaks("1 hours"),labels = tvtime_format()) +guides(colour=FALSE)


#text("testing") 
#print(p)
dev.off()

from <- "ssing@matson.com"
to <- "ssing@matson.com"
subject <- "Batch Job Stat"
body <- "Email body."
mailControl=list(smtpServer="emailweb.matson.com")
#needs full path if not in working directory
attachmentPath <- fileName

#same as attachmentPath if using working directory
attachmentName <- fileName

#key part for attachments, put the body and the mime_part in a list for msg
attachmentObject <- mime_part(x=attachmentPath,name=attachmentName)
bodyWithAttachment <- list(body,attachmentObject)

sendmail(from=from,to=to,subject=subject,msg=bodyWithAttachment,control=mailControl)

#sendmail(from=from,to=to,subject=subject,msg=body,control=mailControl)



