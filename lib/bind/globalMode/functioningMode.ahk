#Requires AutoHotkey v2.0

; 快捷菜单
CapsLock & r::SendBlind("+{F10}")
;

; 切换窗口
#Include %A_LineFile%\..\switchTake.ahk
;

; Single hand
#Include %A_LineFile%\..\singleHand.ahk
