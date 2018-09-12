;极速pdf
#NoTrayIcon
autoRunInJiSuFlag := 0
autoRunMum := 5

#IfWinActive ahk_class ATLWIN_JISUPDF_MIAN
d::send, {down 44}
e::send, {up 44}

Space::
;msgbox,%autoRunInJiSuFlag% 
if autoRunInJiSuFlag = 0
{
  SetTimer, autoRun, 5000  
  autoRunInJiSuFlag := 1
}
else if autoRunInJiSuFlag = 1
{
  SetTimer, autoRun, Off  
  autoRunInJiSuFlag := 0
}
return
autoRun:
send, {down %autoRunNum%}
SetTimer, autoRun, 5000  
return
x:: SetTimer, autoRun, Off  
!q::autoRunNum:=1*5
!w::autoRunNum:=2*5
!e::autoRunNum:=5*3
!r::autoRunNum:=5*4
#IfWinActive
