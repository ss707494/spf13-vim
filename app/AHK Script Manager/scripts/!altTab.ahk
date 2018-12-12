
#Persistent
CapsLock & g:: goto , getWin

getWin:
WinGet, ControlList, ProcessName, A
ToolTip, %ControlList%
SetTimer, RemoveToolTip, 5000
return
RemoveToolTip:
SetTimer, RemoveToolTip, Off
ToolTip
return
