;====================================
; ����Сѩ ��Ʒ
; http://wwww.snow518.cn/
; �޸��ԣ�http://ahk.5d6d.com/thread-701-1-3.html
; �����˿�ݼ����༭������ĳ�������Ľű�
;====================================
#Persistent
#SingleInstance force

SetWorkingDir %A_ScriptDir%\scripts\

DetectHiddenWindows On  ; ����̽��ű������ص������ڡ�
SetTitleMatchMode 2  ; ������Ҫָ��������ʾ���ļ�������·����

scriptCount = 0

OnExit ExitSub

Menu scripts_unopen, Add, �����ű�, Menu_Tray_Exit
Menu scripts_unopen, ToggleEnable, �����ű�
Menu scripts_unopen, Default, �����ű�
Menu scripts_unopen, Add
Menu scripts_unclose, Add, �رսű�, Menu_Tray_Exit
Menu scripts_unclose, ToggleEnable, �رսű�
Menu scripts_unclose, Default, �رսű�
Menu scripts_unclose, Add
Menu scripts_edit, Add, �༭�ű�, Menu_Tray_Exit
Menu scripts_edit, ToggleEnable, �༭�ű�
Menu scripts_edit, Default, �༭�ű�
Menu scripts_edit, Add
Menu scripts_reload, Add, ���ؽű�, Menu_Tray_Exit
Menu scripts_reload, ToggleEnable, ���ؽű�
Menu scripts_reload, Default, ���ؽű�
Menu scripts_reload, Add

; ����scriptsĿ¼�µ�ahk�ļ�
Loop, %A_ScriptDir%\scripts\*.ahk
{
    StringRePlace menuName, A_LoopFileName, .ahk

    scriptCount += 1
    scripts%scriptCount%0 := A_LoopFileName

    IfWinExist %A_LoopFileName% - AutoHotkey    ; �Ѿ���
    {
        Menu scripts_unclose, add, %menuName%, tsk_close
        scripts%scriptCount%1 = 1
    }
    else
    {
        Menu scripts_unopen, add, %menuName%, tsk_open
        scripts%scriptCount%1 = 0
    }
    Menu scripts_edit, add, %menuName%, tsk_edit
    Menu scripts_reload, add, %menuName%, tsk_reload
}


; ���ӹ���ť
Menu, Tray, Icon, %A_ScriptDir%\resources\ahk.ico
Menu, Tray, Click, 1
Menu, Tray, Tip, AHK Script Manager
Menu, Tray, Add, AHK Script Manager, Menu_Show
Menu, Tray, ToggleEnable, AHK Script Manager
Menu, Tray, Default, AHK Script Manager
Menu, Tray, Add
Menu, Tray, Add, �������нű�(&A)`tCtrl + Alt + Shift + Q, tsk_openAll
Menu, Tray, Add, �����ű�(&O)`tCtrl + Alt + Shift + W, :scripts_unopen
Menu, Tray, Add, �ر����нű�(&L)`tCtrl + Alt + Shift + A, tsk_closeAll
Menu, Tray, Add, �رսű�(&C)`tCtrl + Alt + Shift + S, :scripts_unclose
Menu, Tray, Add
Menu, Tray, Add, �༭�ű�(&I)`tCtrl + Alt + Shift + E, :scripts_edit
Menu, Tray, Add, ���ؽű�(&S)`tCtrl + Alt + Shift + D, :scripts_reload
Menu, Tray, Add
Menu, Tray, Add, �򿪰���Ŀ¼(&D)`t%A_ScriptDir%, Menu_Tray_OpenDir
Menu, Tray, Add
Menu, Tray, Add, ��������(&R), Menu_Tray_Reload
Menu, Tray, Add
Menu, Tray, Add, �༭����(&E), Menu_Tray_Edit
Menu, Tray, Add
Menu, Tray, Add, �˳�(&X)`tCtrl + Alt + Shift + X, Menu_Tray_Exit
Menu, Tray, NoStandard

GoSub tsk_openAll

Return

tsk_openAll:
Loop, %scriptCount%
{
    thisScript := scripts%A_index%0
    If  scripts%A_index%1 = 0    ;û��
    {
        ifinstring, thisScript, !
	    continue
        IfWinNotExist %thisScript% - AutoHotkey    ; û�д�
            Run %A_ScriptDir%\scripts\%thisScript%

        scripts%A_index%1 = 1

        StringRePlace menuName, thisScript, .ahk
        Menu scripts_unclose, add, %menuName%, tsk_close
        Menu scripts_unopen, delete, %menuName%
    }
}
Return

tsk_open:
Loop, %scriptCount%
{
    thisScript := scripts%A_index%0
    If thisScript = %A_thismenuitem%.ahk  ; match found.
    {
        IfWinNotExist %thisScript% - AutoHotkey    ; û�д�
            Run %A_ScriptDir%\scripts\%thisScript%

        scripts%A_index%1 := 1

        Menu scripts_unclose, add, %A_thismenuitem%, tsk_close
        Menu scripts_unopen, delete, %A_thismenuitem%

        Break
    }
}
Return

tsk_close:
Loop, %scriptCount%
{
    thisScript := scripts%A_index%0
    If thisScript = %A_thismenuitem%.ahk  ; match found.
    {
        WinClose %thisScript% - AutoHotkey
        scripts%A_index%1 := 0

        Menu scripts_unopen, add, %A_thismenuitem%, tsk_open
        Menu scripts_unclose, delete, %A_thismenuitem%

        Break
    }
}
Return

tsk_closeAll:
Loop, %scriptCount%
{
    thisScript := scripts%A_index%0
    If scripts%A_index%1 = 1  ; �Ѵ�
    {
        WinClose %thisScript% - AutoHotkey
        scripts%A_index%1 = 0

        StringRePlace menuName, thisScript, .ahk
        Menu scripts_unopen, add, %menuName%, tsk_open
        Menu scripts_unclose, delete, %menuName%
    }
}
Return

tsk_edit:
Run, edit %A_ScriptDir%\scripts\%A_thismenuitem%.ahk
Return

tsk_reload:
Loop, %scriptCount%
{
    thisScript := scripts%A_index%0
    If thisScript = %A_thismenuitem%.ahk  ; match found.
    {
        WinClose %thisScript% - AutoHotkey
        Run %A_ScriptDir%\scripts\%thisScript%
        Break
    }
}
Return

+^#z::
    Menu, Tray, Show
Return

;+^!X::
;	Goto Menu_Tray_Exit
;Return
;
;+^!Q::
;	Goto tsk_openAll
;Return
;
;+^!W::
;	Menu, scripts_unopen, Show
;Return
;
;+^!A::
;	Goto tsk_closeAll
;Return

;+^!S::
;	Menu, scripts_unclose, Show
;Return

;+^!E::
;	Menu, scripts_edit, Show
;Return
;
;+^!D::
;	Menu, scripts_reload, Show
;Return

Menu_Tray_OpenDir:
	Run %A_ScriptDir%
Return

Menu_Tray_Exit:
	ExitApp
Return

Menu_Tray_Reload:
	Reload
Return

Menu_Tray_Edit:
	Edit
Return

ExitSub:
    Loop, %scriptCount%
    {
        thisScript := scripts%A_index%0
        If scripts%A_index%1 = 1  ; �Ѵ�
        {
            WinClose %thisScript% - AutoHotkey
            scripts%A_index%1 = 0

            StringRePlace menuName, thisScript, .ahk
        }
    }
	Menu, Tray, NoIcon
    ExitApp
Return

Menu_Show:
    Menu, Tray, Show
Return
