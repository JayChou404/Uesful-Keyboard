/************************************************************************
 * 键盘设置
 * 定义了与CapsLock相关的快捷键绑定
 * @file uKB_bind.ahk
 * @author 
 * @date 2023/06/07
 * @version 0.1.0 (优化版本)
 ************************************************************************/

global stime := false
global single := 0

; 键位变更
#Include %A_ScriptDir%\lib\bind\uKB_keyChange.ahk

; CapsLock快捷键定义
; CapsLock + \ 切换CapsLock状态
#Include %A_ScriptDir%\lib\bind\uKB_capslock.ahk

; 使用CapsLock作为ESC
CapsLock::SendBlind("{ESC}")
; 使用CapsLock + Q 快速关闭窗口
CapsLock & q::SendBlind("!{F4}")

; 编辑器快捷键
#Include %A_LineFile%\..\bind\uKB_editor.ahk

;---- Delete ----
#Include %A_LineFile%\..\bind\uKB_delete.ahk

;---- Move ----
#Include %A_LineFile%\..\bind\uKB_move.ahk

;---- Screen Operation ----
#Include %A_LineFile%\..\bind\uKB_screen.ahk

;---- App Mode ----
#Include %A_LineFile%\..\bind\uKB_app.ahk

;---- Function Keyboard Mode ----
#Include %A_LineFile%\..\bind\uKB_FKeyboard.ahk