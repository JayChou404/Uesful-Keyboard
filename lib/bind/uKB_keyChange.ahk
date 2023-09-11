/************************************************************************
 * @description ---- key change ----
 * 修改 `;` 长按功能，长按为 ‘Ctrl’ 键
 * 修改 ‘/’ 长按功能，长按为 ‘shift’ 键
 * @file uKB_keyChange.ahk
 * @author 
 * @date 2023/06/07
 * @version 0.0.0
 ***********************************************************************/



; 修改 `;` 长按功能，长按为 ‘Ctrl’ 键
$;::{
    Sd "{LCtrl Down}"
    global single, stime
    if (!single == true) {
        stime := A_TickCount
    }
    single := true
}
$; UP::
{
    global stime, single
    Sd "{LCtrl Up}"
    if (A_PriorKey = ";" && (A_TickCount - stime) < 300)
    {
        Sd "{;}"
    }
    single := false
}


; 修改 ‘/’ 长按功能，长按为 ‘shift’ 键
global slash := false
/::{
    Sd "{LShift Down}"
    global slash, stime
    if (!slash == true) {
        global stime := A_TickCount
    }
    slash := true
}

/ UP::
{
    global stime, slash
    Sd "{LShift Up}"

    if (A_PriorKey = "/" && (A_TickCount - stime) < 300)
    {
        Sd "{/}"
    }
    slash := false
}