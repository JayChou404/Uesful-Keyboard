#Requires AutoHotkey v2.0

; 快捷菜单
CapsLock & e::SendBlind("+{F10}")
;

; 切换窗口
#Include %A_LineFile%\..\switchTake.ahk
;

; 切换桌面
#Include %A_LineFile%\..\switchDesktop.ahk
;