::#!
@echo off
call scala %0 %*
goto :eof
::!#
object HelloWorld extends App {
  println("Hello, world!")
}
HelloWorld.main(args)