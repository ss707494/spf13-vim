;RobertL
;http://ahk8.com/thread-5792.html
;键区映射 V2.4
;=============用户配置部分=============
#NoTrayIcon
Map:={Modifier:"s"    ;指定修饰键
    ,TimeOut:0.4        ;当修饰键为普通按键时有效，单位s
    ;指定映射键：
    ,k:"up"        ,j:"down"    ,h:"left"    ,l:"right"
    ,u:"Home"    ,o:"End"
    ,d:"BS",    ",":"Del"    ,";":"Enter"
    ,6:" ^{Left}",7:" ^{Right}",8:" +^{Left}",9:" +^{Right}"
    ,a:func("yourFunction")}
yourFunction(){
    Msgbox your Function
}
;=============自动执行段=============;{
Hotkey,If
modifier:=ObjDelete(Map,"Modifier")
timeOut:=ObjDelete(Map,"TimeOut")
;~ if(nomarlKeyAsModifier:=(1=StrLen(modifier)))
    ;~ Hotkey,$%modifier%, ModifierKeyDown, On
Hotkey,~*$%modifier% Up, ModifierKeyUp, On
Hotkey,If, IsMapOn()
for sourceKey in Map{
    Hotkey,*%sourceKey%, SourceKeyDown
    Hotkey,*%sourceKey% Up, SourceKeyUp
}
Hotkey,If
;===================================;}
IsMapOn(){
    global IsMapOn,modifier,IsMapped
    IsMapOn:=IsMapped:=(IsMapOn | (GetKeyState(modifier,"P") && (IsMapOn:=true)))
    return IsMapOn
}
SourceKeyDown(){
    global Map,waiting
    targetKey:=Map[source:=SubStr(A_ThisHotkey,2)]
    if isfunc(targetKey){
        %targetKey%()
    }if(" "!=SubStr(targetKey,1,1)){
        if waiting
            Send % source
        SendLevel 1
        SetKeyDelay -1
        Send {Blind}{%targetKey% DownTemp}
    }else {
        Send % SubStr(targetKey,2)
    }
    return
}
SourceKeyUp(){
    global Map
    targetKey:=Map[SubStr(A_ThisHotkey,2,-3)]
    if(" "!=SubStr(targetKey,1,1)){
        SendLevel 1
        SetKeyDelay -1
        Send {Blind}{%targetKey% Up}
    }
    return
}
ModifierKeyUp(){
    global Map,modifier,IsMapOn,nomarlKeyAsModifier
    if(IsMapOn && modifier="CapsLock")
        SetCapsLockState,% GetKeyState(modifier,"T")?"Off":"On"
    for sourceKey in Map
        if GetKeyState(sourceKey,"P")
            return
    IsMapOn:=false
    if(nomarlKeyAsModifier)
        Hotkey,$%modifier%, ModifierKeyDown, On
}
ModifierKeyDown(){
    global Map,IsMapOn,modifier,timeOut,IsMapped,waiting
    if(IsMapOn)
        return
    waiting:=true
    Input, _input, L1 T%timeOut%
    waiting:=false
    if(ErrorLevel="MAX"){
        if(_input=modifier){
            Hotkey,$%modifier%, ModifierKeyDown, Off
            Send {Blind}{%modifier% DownTemp}
        }else if(Map[_input]){
            KeyWait, %modifier%
            IsMapped:=false
        }else
            Send {Blind}{%modifier%}{%_input%}
    }else if(ErrorLevel="Timeout"){
        Hotkey,$%modifier%, ModifierKeyDown, Off
        Send {Blind}{%modifier% DownTemp}
    }else
        throw Exception("ModifierKeyDown:Un-used ErrorLevel=" ErrorLevel,-1)
}
#If IsMapOn()
#If
