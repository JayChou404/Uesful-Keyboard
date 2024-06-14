/************************************************************************
 * @description ---- 编辑器快捷键 ----
 * @file uKB_Editor.ahk
 * @author 
 * @date 2023/06/07
 * @version 0.1.0 (优化版本)
 ************************************************************************/

; 复制当前行
CapsLock & c::SendInput("{Home}+{End}^c{End}")
; 粘贴文本
CapsLock & v::SendInput("+{Insert}")
; 新建行
CapsLock & f::SendInput("{Enter}")
; 打开右键菜单
CapsLock & d::SendInput("{AppsKey}")
; 向右移动到下一个单词开头
CapsLock & w::SendInput("^{Right}")
; 向左移动到上一个单词开头
CapsLock & r::SendInput("^{Left}")
; 打开命令行(Utools)
capslock & p::SendInput("!\")

; 按下CapsLock 和 Space充当Shift
CapsLock & Space::
{
    SendInput("{Shift down}")
    KeyWait("Space")
    SendInput("{Shift Up}")
}
