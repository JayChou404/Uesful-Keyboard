#Requires AutoHotkey v2.0

; 单击翻译
CapsLock & 1::SendBlind("^+1")
; 截图翻译
CapsLock & 2::SendBlind("^+2")

; 代理开启/关闭
CapsLock & 3::SendBlind("^+!1")