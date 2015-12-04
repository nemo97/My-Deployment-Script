::#!
@echo off
call scala %0 %*
goto :eof
::!#

import java.sql.{Connection, DriverManager, ResultSet};
object GatesMessageTable extends App {   
 
  // Change to Your Database Config
  val conn_str = "jdbc:mysql://localhost:3306/DBNAME?user=DBUSER&password=DBPWD"

 

  // Setup the connection
  val conn = null
  
 try  {
	  // Load the driver
	  classOf[com.mysql.jdbc.Driver]
	  // Setup the connection
	  conn = DriverManager.getConnection(conn_str)
  
  
  
  
 }
 finally {
	conn.close() 
 }}}

 
 
}

GatesMessageTable.main(args)