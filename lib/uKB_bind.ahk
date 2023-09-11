/************************************************************************
 * @description 键盘设置
 * 一共有 4 种状态:
 * CapsLock +
 * CapsLock + LAlt +
 * CapsLock + RAlt +
 * CapsLock + Space +
 * @file uKB_bind.ahk
 * @author 
 * @date 2023/06/07
 * @version 0.0.0
 ***********************************************************************/

global stime := false
global single := 0

;-x--- key change ----
#Include %A_LineFile%\..\bind\uKB_keyChange.ahk

;---- CapsLock Section --------------------------------------------------
;---- CapsLock + \ === CapsLock ----
#Include %A_LineFile%\..\bind\uKB_capslock.ahk

;---- ESC ----
CapsLock:: Sd("{ESC}")
CapsLock & q:: Sd("!{F4}")

;---- Editor ----
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