#include <MsgBoxConstants.au3>

WinActivate ( "title","Administrator: Jboss - start.bat")
Local $hWnd = WinWait("[title:Administrator: Jboss - start.bat]", "", 10)
WinActivate($hWnd)
If WinActive($hWnd) Then
	Send("^c")
EndIf
;Sleep(1000*10)
;WinActivate ( "title","Administrator: Jboss - start.bat")
;$hWnd = WinWait("[title:Administrator: Jboss - start.bat]", "", 10)
;WinActivate($hWnd)
;Send("Y")
;Send("{ENTER}")
;Sleep(500)
Exit(1)
