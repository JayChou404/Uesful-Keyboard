/************************************************************************
 * @description ---- Editor ----
 * CapsLock +:
 * Space ===  Shift
 * f === Enter
 * d === 打开快捷菜单
 * c === 复制一行
 * w === 向右移动一个单词的开头
 * e === 向右移动一个单词的结尾
 * r === 向左移动一个单词的开头
 * p === 打开命令行(Utools)
 * v === 粘贴
 * -e === 向右移动一格单词的结尾
 * -% === 移动到另一个括号去
 * 
 * @file uKB_Editor.ahk
 * @author 
 * @date 2023/06/07
 * @version 0.0.0
 ***********************************************************************/

CapsLock & c::Sd("{Home}+{End}^c{End}")
CapsLock & v::Sd("+{Insert}")
CapsLock & f::Sd("{Enter}")
CapsLock & d::Sd("{AppsKey}")
CapsLock & w::Sd("^{Right}")
CapsLock & r::Sd("^{Left}")
capslock & p::Sd("!\")
CapsLock & Space::
{
    Sd("{Shift down}")
    KeyWait("Space")
    Sd("{Shift Up}")
}
