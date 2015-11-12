::#!
@echo off
call scala %0 %*
goto :eof
::!#
object LogAnalyser extends App {
 
 val source = scala.io.Source.fromFile("C:/softwares/AntScripts/logs/full.txt")
 try  {
	//val lines = try source.mkString finally source.close()
	
	val lines = source.getLines.toList
  
	//println(lines)
  
	//val temp = lines.foreach(x => "Test"+x);
	
	//println(temp)
	
	/*for(temp <- lines){
		println temp
	
	}*/
	
	//for(temp <- lines){
		//println temp.mkString
	//}	
	
	/*lines.foreach{
		println
	}*/
	
	//var index = lines.indexWhere(findIndex);
	var index = lines.indexWhere( _.contains("Reactor Summary") );
	
	//println("Index "+index)
	/*
	for(i <- index until lines.size){
		//if(i >= index)
		println(lines(i))
	}*/
	//for(i <- lines.)
	//lines.foreach(test)
	
	val selectedLines = lines.slice(index,lines.size);
	selectedLines.foreach(println);  
 }
 finally {
	source.close() 
 }

 
 
}
def findIndex(x:String):Boolean = {
	
	//println(x)
	
	return x.contains("Reactor Summary");
}
LogAnalyser.main(args)