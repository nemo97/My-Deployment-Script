#include <MsgBoxConstants.au3>
#include <AutoItConstants.au3>

ConsoleWrite ( "AutoIt Stop Jboss : Staring " & @CRLF)
;Local $hWndStopped = WinWait("[title:Administrator: Jboss]", "", 10)
;If $hWndStopped Then
;   ConsoleWrite ( "AutoIt Stop Jboss : Jboss already has stopped " & @CRLF)
;   Exit(1)
;EndIf

;WinActivate ( "title","Administrator: Jboss - start.bat")
Local $hWnd = WinWait("[title:Administrator: Jboss - start.bat]", "", 10)
;WinActivate($hWnd)
; Disable user input from the mouse and keyboard.
;BlockInput($BI_DISABLE)
;If WinActive($hWnd) Then
ConsoleWrite ( "AutoIt Stop Jboss : Checking Terminal "&$hWnd & @CRLF)
If $hWnd Then
	Send("^c")
	ConsoleWrite ( "AutoIt Stop Jboss : Found Terminal " & @CRLF)
	;Opt("SendKeyDelay", 500)
    ;Opt("SendAttachMode", 1)
	;Local $status = ControlSend($hWnd,"","","^c")
	ConsoleWrite ( "Status 1:OK " & @CRLF)
EndIf
ConsoleWrite ( "AutoIt Stop Jboss : Finish " & @CRLF)
; Enable user input from the mouse and keyboard.
;BlockInput($BI_ENABLE)
;Sleep(1000*10)
;WinActivate ( "title","Administrator: Jboss - start.bat")
;$hWnd = WinWait("[title:Administrator: Jboss - start.bat]", "", 10)
;WinActivate($hWnd)
;Send("Y")
;Send("{ENTER}")
;Sleep(500)
Exit(1)
