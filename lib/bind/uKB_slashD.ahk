; 修改 ‘/’ 长按功能，长按为 ‘shift’ 键
global slash := false
/::{
    Send "{Blind}{LShift DownR}"
    global slash, stime
    if (!slash == true) {
        global stime := A_TickCount
    }
    slash := true
}

/ UP::
{
    global stime, slash
    Send "{Blind}{LShift Up}"
    ; Send stime
    ; Send "    "
    ; Send A_TickCount

    if (A_PriorKey = "/" && (A_TickCount - stime) < 300)
    {
        tmp(A_TickCount - stime, 3)
        Send "{Blind}{/}"
    }
    slash := false
}