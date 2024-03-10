; 修改 `;` 长按功能，长按为 ‘Ctrl’ 键

$;::{
    Send "{Blind}{LCtrl DownR}"
    global single, stime
    if (!single == true) {
        stime := A_TickCount
    }
    single := true
}

$; UP::
{
    global stime, single
    Send "{Blind}{LCtrl Up}"
    ; Send stime
    ; Send "    "
    ; Send A_TickCount

    if (A_PriorKey = ";" && (A_TickCount - stime) < 300)
    {
        tmp(A_TickCount - stime, 3)
        Send "{Blind}{;}"
    }
    single := false
}
