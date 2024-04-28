#Requires AutoHotkey v2.0
/*
当特定组启动时，启动特定热键
*/
HotIfWinActive "ahk_group edit"
    ~Space & h::SendBlind("{Up}")
HotIfWinActive