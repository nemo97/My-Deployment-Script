;#include <MsgBoxConstants.au3>
;MsgBox($MB_SYSTEMMODAL, "Title", "This message box will timeout after 101 seconds or select the OK button.", 10)

;WinActivate ( "title","Administrator: Jboss - start.bat")
;Local $hWnd1 = WinWait("[title:Administrator: Jboss - start.bat]", "", 10)
;WinActivate($hWnd1)
;If WinActive($hWnd1) Then	
;	Send("Y")
;	Send("{ENTER}")
;	Sleep(50)
;EndIf
;MsgBox($MB_SYSTEMMODAL, "Title", "This message box will timeout after 10 seconds or select the OK button.", 10)	
WinActivate ( "title","Administrator: Jboss")
Local $hWnd = WinWait("[title:Administrator: Jboss]", "", 10)
WinActivate($hWnd)
If WinActive($hWnd) Then
	;MsgBox($MB_SYSTEMMODAL, "Title", "This message box will timeout after 10 seconds or select the OK button.", 10)
	
	Send("start.bat")
	Send("{ENTER}")
EndIf		
;Sleep(500)
Exit(1)
