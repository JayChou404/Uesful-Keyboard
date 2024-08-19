#Requires AutoHotkey v2.0

#HotIf WinActive('ahk_exe ONENOTE.EXE')
    MButton & r::
    {
        SendBlind "!w"
        SendBlind "i"
    } ; 沉浸阅读

    MButton & Space::
    {
        SendBlind "!d"
        SendBlind "y"
    } ; 全景手柄

    MButton & b:: {
        SendBlind "!d"
        SendBlind "g{Right}{Enter}"
    } ; 切换笔

    MButton & e:: {
        SendBlind "!d"
        SendBlind "g{Enter}"
    } ; 橡皮檫

    MButton & a:: {
        SendBlind "!d"
        SendBlind "t"
    } ; 选择对象

    MButton & t:: {
        SendBlind "!d"
        SendBlind "l"
    } ; 套索工具

    MButton & x:: {
        SendBlind "{Delete}"
    } ; 删除
    
    MButton & 1:: {
        SendBlind "^z"
    } ; 撤回

    MButton & 2:: {
        SendBlind "^y"
    } ; 重做
#HotIf