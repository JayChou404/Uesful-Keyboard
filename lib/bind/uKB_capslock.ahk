/************************************************************************
 * @description ---- CapsLock + \ === CapsLock ----
 * 大写启快捷键: CapsLock + \
 * @file uKB_capslock.ahk
 * @author 
 * @date 2023/06/07
 * @version 0.0.0
 ***********************************************************************/


CapsLock & \::
{
    CapsLockState := GetKeyState("CapsLock", "T")
    if (CapsLockState == 1)
        SetCapsLockState "AlwaysOff"
    else
        SetCapsLockState "AlwaysOn"
    KeyWait("\")
}