;CapsLock 自定义快捷键

;#Include %A_ScriptDir%\windows-desktop-switcher\desktop_switcher.ahk
;Run %A_ScriptDir%\windows-desktop-switcher\desktop_switcher.ahk

IfEqual, 0, 0, SetTimer, MyReload, % 60*1000
While false {
  MyReload:
  Run, %A_AhkPath% /f /r "%A_ScriptFullPath%" 111, %A_ScriptDir%
  Return
}

#InstallKeybdHook

mouseState := false
mouseSpeed := 0
oneMove := 20

currentLevel := 1
 SysGet, A_ScreenWidth_small, 61
 SysGet, A_ScreenHeight_small, 62
; SysGet, A_ScreenWidth_small, 78
; SysGet, A_ScreenHeight_small, 79
A_ScreenWidth_Local := A_ScreenWidth_small
A_ScreenHeight_Local := A_ScreenHeight_small
baseX := 0
baseY := 0
baseXOffset := 0
baseYOffset := 0
moveX := 0
moveY := 0
keysList := []
creatKey(arr)
{
    return {key: arr[1], x: arr[2], y: arr[3]}
}
keysList.push(creatKey(["q", 1, 1]))
keysList.push(creatKey(["w", 3, 1]))
keysList.push(creatKey(["e", 5, 1]))
keysList.push(creatKey(["r", 7, 1]))
keysList.push(creatKey(["a", 1, 3]))
keysList.push(creatKey(["s", 3, 3]))
keysList.push(creatKey(["d", 5, 3]))
keysList.push(creatKey(["f", 7, 3]))
keysList.push(creatKey(["z", 1, 5]))
keysList.push(creatKey(["x", 3, 5]))
keysList.push(creatKey(["c", 5, 5]))
keysList.push(creatKey(["v", 7, 5]))


dictRun = 0  ;dict 运行状态
;搜索引擎
searchEngine :="http://www.google.com.hk/search?gws_rd=ssl&q="
searchStateIng :=0
;"http://www.google.com.hk/search?q=a&gws_rd=ssl"
;"http://cn.bing.com/search?q="
;;;;;;
;-----------clip 变量

;定义变量
keyTime := true


SetCapsLockState, AlwaysOff

;窗口控制菜单---------------------
;Menu windowMenu, Add, &1Top, winSet_1
;Menu windowMenu, Add, &2Max, winSet_2
;Menu windowMenu, Add, &3Min, winSet_3
;Menu windowMenu, Add, &4tranparent, winSet_4
;Menu windowMenu, Add, &5closeTran, winSet_5

return
;-------------------------------

#Persistent
#SingleInstance force
SetCapsLockState, AlwaysOff
#NoTrayIcon

GetGUIThreadInfo_hwndActive(WinTitle="A")
{
	ControlGet, hwnd, HWND,,, %WinTitle%
	if (WinActive(WinTitle)) {
		ptrSize := !A_PtrSize ? 4 : A_PtrSize
		VarSetCapacity(stGTI, cbSize:=4+4+(PtrSize*6)+16, 0)
		NumPut(cbSize, stGTI,  0, "UInt")
		return hwnd := DllCall("GetGUIThreadInfo", "Uint", 0, "Ptr", &stGTI)
				 ? NumGet(stGTI, 8+PtrSize, "Ptr") : hwnd
	}
	else {
		return hwnd
	}
}

IME_GetConvMode(WinTitle="A")   {
    hwnd :=GetGUIThreadInfo_hwndActive(WinTitle)
    return DllCall("SendMessage"
          , "Ptr", DllCall("imm32\ImmGetDefaultIMEWnd", "Ptr", hwnd)
          , "UInt", 0x0283  ;Message : WM_IME_CONTROL
          ,  "Int", 0x001   ;wParam  : IMC_GETCONVERSIONMODE
          ,  "Int", 0) & 0xffff     ;lParam  : 0 ， & 0xffff 表示只取低16位
}

;chrome
#IfWinActive ahk_class Chrome_WidgetWin_1
^d:: send {PgDn}
^u:: send {PgUp}
^0:: send ^d
#IfWinActive
;idea 改建
#IfWinActive ahk_class SunAwtFrame
CapsLock & enter::send, ^+{enter}
;CapsLock & s::send, ^{Numpad4}

CapsLock & s::
send, ^s
;vimArrKeyState := true
return
;CapsLock & 2::
;send, ^{F2}
;vimArrKeyState := true
;return
;CapsLock & 4::
;send, !+{F9}
;vimArrKeyState := true
;return是的sssKKJJJKjk
;CapsLock & 5::
;send, ^{F5}
;return
~Shift up::
;send {Shift}
return
CapsLock::
if (IME_GetConvMode() == 1)
{
    send {Shift}
}
Send {Esc}
return
PrintScreen::
Res1:=IME_GetConvMode()
Result:=DllCall("GetKeyboardLayout","int",0,UInt)
SetFormat, integer, hex
Result += 0
SetFormat, integer, D
MsgBox is %Result% %Res1%
return

#IfWinActive

CapsLock::Send, {ESC}

;自定义 快捷启动----------------------------------

CapsLock & q::send ,!{f9} ;listary

;#IfWinActive ahk_exe Dict.exe
;CapsLock & w::Send, ^v
;#IfWinActive
;CapsLock & w::
;if getkeystate("alt")
;{
;	run D:\Documents\ss\ruanjian\Dict4\Dict.exe
;	return
;}
;Process, exist, Dict.exe
;If ErrorLevel
;	goto , doDict
;else
;	goto, startDict
;return


;快捷启动 标签----------------------------------------

;startDict:
;run D:\Documents\ss\ruanjian\Dict4\Dict.exe
;;dictRun :=1
;sleep 1999
;goto, doDict
;return

;doDict:
;send ,^c
;sleep , 100
;send ,!{f10} ; dict
;return

;状态变量 -----------------------------------

;常用快捷键命令-------------------

;微信
CapsLock & w::send, ^!w
;企业微信
CapsLock & r::send, ^!{f9}


CapsLock & i::send, )
CapsLock & u::send, (
CapsLock & o::send , =
CapsLock & p::send, >
CapsLock & [::+sc01A
CapsLock & ]::+sc01B
CapsLock & `;::send ,{enter}
CapsLock & j::send, {down}
CapsLock & k::send, {up}
CapsLock & l::send, {right}
CapsLock & h::send, {left}
CapsLock & n::send, {BS}
CapsLock & b::
Send, ^+{left}
Sleep, 100
Send, {BS}
return

;CapsLock & d:: Send, {BS}
;CapsLock & f::
;Send, ^+{left}
;Sleep, 100
;Send, {BS}
;return

CapsLock & a:: Send, ^a
CapsLock & f:: Send, ^f
CapsLock & c:: Send, ^c
CapsLock & 8:: Send, ^+{TAB}
CapsLock & 9:: Send, ^{TAB}
CapsLock & 0:: Send, ^w

;CapsLock & x:: Send, ^x                 ; X = Cut
;CapsLock & c:: send, ^c
CapsLock & v::send, ^``         ; V = Paste
CapsLock & `::
GetKeyState, CapsLockState, CapsLock, T                                 ;|
if CapsLockState = D                                                             ;|
  SetCapsLockState, AlwaysOff                                           ;|
else                                                                   ;|
  SetCapsLockState, AlwaysOn                                             ;|
return

; 音量控制
CapsLock & up::SoundSetWaveVolume, +5
CapsLock & down::SoundSetWaveVolume, -5
;CapsLock & ::SoundSetWaveVolume, +5


;Editor: FloatingShuYin
;reference material： http://blog.csdn.net/liuyukuan/article/details/54731359
;         http://www.appinn.com/ahk-fast-food-restaurant-6-color-thief
#c::
MouseGetPos, mouseX, mouseY
; 获得鼠标所在坐标，把鼠标的 X 坐标赋值给变量 mouseX ，同理 mouseY

PixelGetColor, color, %mouseX%, %mouseY%, RGB
; 调用 PixelGetColor 函数，获得鼠标所在坐标的 RGB 值，并赋值给 color

StringRight color,color,6
; 截取 color（第二个 color） 右边的 6 个字符，因为获得的值是这样的：#RRGGBB，一般我们只需要 RRGGBB 部分。把截取到的值再赋给 color（第一个 color）。

clipboard = %color%
; 把 color 的值发送到剪贴板

tooltip, PixelColor:%color% has go to clipboard
; tooltip 弹出鼠标提示的命令，后面加上要显示的语句。中间的 `n 表示回车
sleep 2000
; 线程暂停 两秒

tooltip,
; 关闭鼠标提示
return


CapsLock & d::
;tooltip, %A_ScreenHeight_small% %A_ScreenWidth_small% %A_ScreenWidth% %A_ScreenHeight%, 100,1070, 1
;return
mouseState := true
currentLevel := 1
oneMove := 20
baseX := 0
baseY := 0
showTooltipss()
return

#If mouseState

1:: oneMove := 5
2:: oneMove := 25
3:: oneMove := 55
4:: oneMove := 85
;m::
;if oneMove > 30
;{
;    oneMove -= 30
;}
;return

j::
MouseMove, 0, %oneMove%, %mouseSpeed%, R
ClearTooltip()
setCurrentLevel()
return
k::
MouseMove, 0, -%oneMove%, %mouseSpeed%, R
setCurrentLevel()
ClearTooltip()
return
h::MouseMove, -%oneMove%, 0, %mouseSpeed%, R
l::MouseMove, %oneMove%, 0, %mouseSpeed%, R
u::
MouseClick, left
setCurrentLevel()
ClearTooltip()
return
space::
MouseClick, left
setCurrentLevel()
ClearTooltip()
return
i::MouseClick, right
o::MouseClick, Middle
m::MouseClick, WheelDown
,::MouseClick, WheelUp
y::
if GetKeyState("LButton")
    MouseClick, left,,, 1, 0, U
else
    MouseClick, left,,, 1, 0, D
return

MouseMoveTo(x, y)
{
    global
    ClearTooltip()
    CoordMode, Mouse
    MouseMove, baseX + baseXOffset + A_ScreenWidth_Local / (8 ** currentLevel) * currentLevel * x, baseY + baseYOffset + A_ScreenHeight_Local / (6 ** currentLevel) * currentLevel * y
    CoordMode, Mouse, Relative
    if (currentLevel = 1) {
        baseX := (x - 1) * A_ScreenWidth_Local / (8 ** currentLevel) * currentLevel
        baseY := (y - 1) * A_ScreenHeight_Local / (6 ** currentLevel) * currentLevel
        currentLevel :=2
        sleep 10
        showTooltipss()
    }else {
        baseX := 0
        baseY := 0
        currentLevel :=1
    }
}

Loop % keysList.Length()
{
    showTooltipOne(keysList[A_Index].key, keysList[A_Index].x, keysList[A_Index].y, A_Index)
}

q::MouseMoveTo(1, 1)
w::MouseMoveTo(3, 1)
e::MouseMoveTo(5, 1)
r::MouseMoveTo(7, 1)
a::MouseMoveTo(1, 3)
s::MouseMoveTo(3, 3)
d::MouseMoveTo(5, 3)
f::MouseMoveTo(7, 3)
z::MouseMoveTo(1, 5)
x::MouseMoveTo(3, 5)
c::MouseMoveTo(5, 5)
v::MouseMoveTo(7, 5)


]::
showTooltipss()
return

showTooltipOne(key, x, y, num)
{
    global
    tooltip, %key%, baseX + A_ScreenWidth_Local / (8 ** currentLevel) * currentLevel * x, baseY + A_ScreenHeight_Local / (6 ** currentLevel) * currentLevel * y, num
}
showTooltipss()
{
CoordMode, tooltip
global keysList
    Loop % keysList.Length()
    {
        showTooltipOne(keysList[A_Index].key, keysList[A_Index].x, keysList[A_Index].y, A_Index)
    }
return
}
ClearTooltip()
{
    Loop, 12
    {
    tooltip, , , , A_Index
    }
CoordMode, tooltip, Relative
return
}
setCurrentLevel()
{
global
currentLevel :=1
baseX := 0
baseY := 0
return
}

CapsLock::
mouseState := false
ClearTooltip()
if GetKeyState("LButton")
    MouseClick, left,,, 1, 0, U
return
#If

;;;;;;;;;;;;;;;;;;; 设置快捷输入 quickInput
quickInputState := false
mostCmd := false

CapsLock & m::
CoordMode, ToolTip, Relative
WinGetActiveStats, T, aWidth, aHeight, X, Y
    quickInputState := true
    tooltip,
    (
1: ss707494
2: ss707494@163.com
3: 15926443660
h: idea.bat C:\Windows\System32\drivers\etc\hosts
a: ahk script: idea.bat C:\Users\ss707494\.spf13-vim-3\app\AHK Script Manager\scripts\CapsLock.ahk
y: evernote email
c: most cmd
    ), aWidth/3, aHeight/3
    return

#IF quickInputState

c::
WinGetActiveStats, T, aWidth, aHeight, X, Y
    mostCmd := true
    tooltip,
    (
    1: sd;fkj
    b: docker start bitwarden
    i: cmd "ipconfig /flushdns"
    r: cmd "netsh restart"
    ), aWidth/3, aHeight/3
    sleep 4444
    mostCmd := false
    quickInputState := false
    tooltip,
    return
return

1::
send ss707494
quickInputState := false
tooltip,
return
2::
send ss707494@163.com
quickInputState := false
tooltip,
return
3::
send 15926443660
quickInputState := false
tooltip,
return
y::
send ss707494.a08a5a3@m.yinxiang.com
quickInputState := false
tooltip,
return
h::
run, cmd.exe /c idea.bat "C:\Windows\System32\drivers\etc\host"
quickInputState := false
tooltip,
return
a::
run, cmd.exe /c idea.bat "C:\Users\ss707494\.spf13-vim-3\app\AHK Script Manager\scripts\CapsLock.ahk"
;; send idea.bat "C:\Users\ss707494\.spf13-vim-3\app\AHK Script Manager\scripts\CapsLock.ahk"
quickInputState := false
tooltip,
return

capslock::
quickInputState := false
mostCmd := false
tooltip,
return

#IF

#IF mostCmd

b::
send docker start bitwarden
quickInputState := false
mostCmd := false
tooltip,
return

1::
send test most cmd
quickInputState := false
mostCmd := false
tooltip,
return

i::
run, cmd.exe /c "ipconfig /flushdns"
quickInputState := false
mostCmd := false
tooltip,
return

r::
tooltip,
RunWait, cmd.exe /c "netsh interface set interface name=\"link\" admin=disabled"
run, cmd.exe /c "netsh interface set interface name=\"link\" admin=enabled"
quickInputState := false
mostCmd := false
return

#IF


