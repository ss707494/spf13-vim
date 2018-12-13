;CapsLock 自定义快捷键

IfEqual, 0, 0, SetTimer, MyReload, % 60*1000
While false {
  MyReload:
  Run, %A_AhkPath% /f /r "%A_ScriptFullPath%" 111, %A_ScriptDir%
  Return
}

#InstallKeybdHook

mouseState := false
mouseSpeed := 0
oneMove := 40

oneWidth := A_ScreenWidth / 8
oneHeight := A_ScreenHeight / 6


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
;return
;CapsLock & 5::
;send, ^{F5}
;return

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

CapsLock & w::send, ^!w
CapsLock & i::send, )
CapsLock & u::send, (
CapsLock & o::send , =
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

CapsLock & 8:: Send, ^+{TAB}
CapsLock & 9:: Send, ^{TAB}
CapsLock & 0:: Send, ^w

;CapsLock & x:: Send, ^x                 ; X = Cut
;CapsLock & c:: send, ^c
CapsLock & v::send, ^``         ; V = Paste
CapsLock & a::
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

winLeft:
send {LWin down}{ctrl down}{left}{LWin up}{ctrl up}
return
winRight:
send {LWin down}{ctrl down}{right}{LWin up}{ctrl up}
return

#j::goto winLeft

#k::goto winRight

#WheelUp::goto winLeft

#WheelDown::goto winRight


CapsLock & d::
mouseState := true
return

#If mouseState

n:: oneMove += 30
m::
if oneMove > 30
{
    oneMove -= 30
}
return

j::MouseMove, 0, %oneMove%, %mouseSpeed%, R
k::MouseMove, 0, -%oneMove%, %mouseSpeed%, R
h::MouseMove, -%oneMove%, 0, %mouseSpeed%, R
l::MouseMove, %oneMove%, 0, %mouseSpeed%, R
`;::MouseClick, left
'::MouseClick, right
o::MouseClick, Middle
u::MouseClick, WheelUp
i::MouseClick, WheelDown

q::MouseMove, oneWidth, oneHeight
w::MouseMove, oneWidth * 3, oneHeight
e::MouseMove, oneWidth * 5, oneHeight
r::MouseMove, oneWidth * 7, oneHeight

a::MouseMove, oneWidth, oneHeight * 3
s::MouseMove, oneWidth * 3, oneHeight * 3
d::MouseMove, oneWidth * 5, oneHeight * 3
f::MouseMove, oneWidth * 7, oneHeight * 3

z::MouseMove, oneWidth, oneHeight * 5
x::MouseMove, oneWidth * 3, oneHeight * 5
c::MouseMove, oneWidth * 5, oneHeight * 5
v::MouseMove, oneWidth * 7, oneHeight * 5

]::
CoordMode, tooltip
;tooltip, one:%oneWidth% %oneHeight%, 20

tooltip, q, oneWidth, oneHeight, 1
tooltip, w, oneWidth * 3, oneHeight, 2
tooltip, e, oneWidth * 5, oneHeight, 3
tooltip, r, oneWidth * 7, oneHeight, 4

tooltip, a, oneWidth, oneHeight * 3, 5
tooltip, s, oneWidth * 3, oneHeight * 3, 6
tooltip, d, oneWidth * 5, oneHeight * 3, 7
tooltip, f, oneWidth * 7, oneHeight * 3, 8

tooltip, z, oneWidth, oneHeight * 5, 9
tooltip, x, oneWidth * 3, oneHeight * 5, 10
tooltip, c, oneWidth * 5, oneHeight * 5, 11
tooltip, v, oneWidth * 7, oneHeight * 5, 12

sleep, 4000
Loop, 12
{
tooltip, , , , A_Index
}
CoordMode, tooltip, Relative
return

CapsLock::
mouseState := false
return
#If

