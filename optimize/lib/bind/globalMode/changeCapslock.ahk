#Requires AutoHotkey v2.0

; 同时按下CapsLock和\键时，检查CapsLock键的当前状态，并根据其状态切换CapsLock的开/关状态。
CapsLock & \::
{
    CapsLockState := GetKeyState("CapsLock", "T")
    if (CapsLockState == 1)
        SetCapsLockState "AlwaysOff"
    else
        SetCapsLockState "AlwaysOn"
    KeyWait("\")
}

; 使用CapsLock作为ESC
*CapsLock::Esc