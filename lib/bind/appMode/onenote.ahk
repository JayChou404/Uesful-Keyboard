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
    } ; 笔迹转化文本

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
    } ; 选择对象

    MButton & x:: {
        SendBlind "{Delete}"
    } ; 删除

#HotIf