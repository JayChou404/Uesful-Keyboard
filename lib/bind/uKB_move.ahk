/************************************************************************
 * @description ---- Move ----
 * CpasLock +:
 * h === left
 * j === down
 * k === up
 * l === right
 * u === PgUp
 * y === PgDown
 * i === Home
 * o === End
 * = === 向右切换桌面
 * - === 向左切换桌面
 * @file uKB_move.ahk
 * @author 
 * @date 2023/06/08
 * @version 0.0.0
 ***********************************************************************/

;---- u === PageUp ----
CapsLock & u::Sd("{PgUp}")

;---- y === PageDown ----
CapsLock & y::Sd("{PgDn}")

;---- i === Home ----
CapsLock & i::Sd("{Home}")

;---- o === End ----
CapsLock & o::Sd("{End}")

;---- h === Left ----
CapsLock & h::Sd("{Left}")

;---- j === Down ----
CapsLock & j::Sd("{Down}")

;---- k === Up ----
CapsLock & k::Sd("{Up}")

;---- l === Right ----
CapsLock & l::Sd("{Right}")

CapsLock & =:: Send("^#{Right}")
CapsLock & -:: Send("^#{Left}")
