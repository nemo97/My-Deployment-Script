library(knitr)
library(sendmailR)
library(rmarkdown)
setwd("C:/softwares/AntScripts")

render("BatchReportDaily.Rmd")

from <- "ssing@matson.com"
to <- "ssing@matson.com"
subject <- "Batch Job Stat"
message <- "Email body.<b> Test</b>"
msg <- mime_part(message)
msg[["headers"]][["Content-Type"]] <- "text/html"

body <- msg
mailControl=list(smtpServer="emailweb.matson.com")
#needs full path if not in working directory
attachmentPath <- "C:/softwares/AntScripts/BatchReportDaily.pdf"

#same as attachmentPath if using working directory
attachmentName <- "BatchReportDaily.pdf"

#key part for attachments, put the body and the mime_part in a list for msg
attachmentObject <- mime_part(x=attachmentPath,name=attachmentName)
bodyWithAttachment <- list(body,attachmentObject)

sendmail(from=from,to=to,subject=subject,msg=bodyWithAttachment,control=mailControl)
