#include <MsgBoxConstants.au3>
#include <AutoItConstants.au3>

WinActivate ( "title","Administrator: Jboss - start.bat")
Local $hWnd = WinWait("[title:Administrator: Jboss - start.bat]", "", 10)
WinActivate($hWnd)
; Disable user input from the mouse and keyboard.
BlockInput($BI_DISABLE)
If WinActive($hWnd) Then
	Send("^c")
EndIf
; Enable user input from the mouse and keyboard.
BlockInput($BI_ENABLE)
;Sleep(1000*10)
;WinActivate ( "title","Administrator: Jboss - start.bat")
;$hWnd = WinWait("[title:Administrator: Jboss - start.bat]", "", 10)
;WinActivate($hWnd)
;Send("Y")
;Send("{ENTER}")
;Sleep(500)
Exit(1)
