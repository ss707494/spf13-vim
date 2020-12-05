#NoTrayIcon


;Milliseconds threshold, hold the middle button for some time

; exceeding this will start to detect scrolling.

tp_StartScrollTThreshold = 5

; Pixels threshold, for both X and Y. Only when the mouse movement

; exceed this threshold will we start scrolling.

tp_StartScrollXThreshold = 5
tp_StartScrollYThreshold = 5

; Milliseconds interval to check further scrolling. Set this to a

; smaller value will make scrolling more fast, and vice versa.

tp_ScrollCheckInterval = 5



;; This key/Button activates scrolling

tp_TriggerKey = MButton



;; End of configuration



#Persistent


CoordMode, Mouse, Screen

Hotkey, %tp_TriggerKey%, tp_TriggerKeyDown

HotKey, %tp_TriggerKey% Up, tp_TriggerKeyUp

return


tp_TriggerKeyDown:

tp_Scroll := 1
MouseGetPos, tp_OrigX, tp_OrigY

SetTimer, tp_setTimer, 130
;;tooltip, %tp_Scroll%
SetTimer, tp_CheckForScrollEventAndExecute, %tp_StartScrollTThreshold%
return

tp_setTimer:
tp_Scroll := 2
return


tp_TriggerKeyUp:

SetTimer, tp_CheckForScrollEventAndExecute, Off

;; Send a middle-click if we did not scroll


if tp_Scroll = 1

    MouseClick, Middle


return



tp_CheckForScrollEventAndExecute:

SetTimer, tp_CheckForScrollEventAndExecute, %tp_ScrollCheckInterval%



MouseGetPos, tp_NewX,tp_NewY

tp_DistanceX := tp_NewX - tp_OrigX

tp_DistanceY := tp_NewY - tp_OrigY



if (tp_DistanceY > tp_StartScrollYThreshold) {
    MouseClick, WheelDown
    tp_Scroll := 2
}

if (tp_DistanceY < -tp_StartScrollYThreshold) {
    MouseClick, WheelUp
    tp_Scroll := 2
}


; 0x114 is WM_HSCROLL

if tp_DistanceX > %tp_StartScrollXThreshold%

{

    ControlGetFocus, FocusedControl, A

    SendMessage, 0x114, 1, 0, %FocusedControl%, A
    tp_Scroll := 2
}

else if tp_DistanceX < -%tp_StartScrollXThreshold%

{

    ControlGetFocus, FocusedControl, A

    SendMessage, 0x114, 0, 0, %FocusedControl%, A
    tp_Scroll := 2
}



return
