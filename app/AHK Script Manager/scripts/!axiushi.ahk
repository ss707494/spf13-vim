a::
    s:=1
    KeyWait,a,T0.15    ;超时设置
    if(ErrorLevel){
        if(s!=3){
            Send {a downtemp}
            s:=2
        }else{
            KeyWait,a
            s:=0
        }
    }else{
        if(s!=3)
            Send a
        s:=0
    }
    return
#If s=2
~*a up::return
#if (s=1 || s=3) && s:=3
h::left
j::down
l::right
k::up
#if
