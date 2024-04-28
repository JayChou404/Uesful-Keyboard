#Requires AutoHotkey v2.0

global isLongPressSpaceActive := 0 
global spacePressStartTime := false

; Space 长按功能
*Space::{
    global spacePressStartTime , isLongPressSpaceActive 
    
    if (!spacePressStartTime) {
        isLongPressSpaceActive  := A_TickCount
        ; ToolTip isLongPressSpaceActive
    }
    spacePressStartTime  := true
}

$*Space UP::
{
    global isLongPressSpaceActive, spacePressStartTime 
    
    ; ToolTip(A_TickCount - isLongPressSpaceActive )
    if (A_PriorKey = "Space" && (A_TickCount - isLongPressSpaceActive) < 300)
    {
        SendBlind "{Space}"
        SendBlind "{Space Up}"
    }
    spacePressStartTime  := false
}

; 特定窗口启用，关闭特定功能
#HotIf WinActive("ahk_group closeSpace")
    Space::
    {
        ; ToolTip "Close Space"
        SendBlind "{Space}"
    }
#HotIf

#HotIf spacePressStartTime
    ; 发送a/w/s/d,模拟移动
    *a::SendBlind "{Left}"
    *w::SendBlind "{Up}"
    *s::SendBlind "{Down}"
    *d::SendBlind "{Right}"
    
    *z::SendBlind "{Delete}" ; 删除
    *x::SendBlind "{Backspace}" ; 退格

    *f::SendBlind "{Enter}" ; 回车

    *r::SendBlind "{Ctrl Down}{Left}{Ctrl Up}" ; 向左移动一个单词位
    *t::SendBlind "{Ctrl Down}{Right}{Ctrl Up}" ; 向右移动一个单词位

    *q::SendBlind "{Home}" ; 移动到行首
    *e::SendBlind "{End}" ; 移动到行尾

    ; 发送F1-F12
    *1::F1
    *2::F2
    *3::F3
    *4::F4
    *5::F5
    *6::F6
    *7::F7
    *8::F8
    *9::F9
    *0::F10
    *-::F11
    *=::F12
#HotIf