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
 * @file uKB_move.ahk
 * @author 
 * @date 2023/06/08
 * @version 0.0.0
 ***********************************************************************/

;---- u === PageUp ----
CapsLock & u::SendBlind("{PgUp}")

;---- y === PageDown ----
CapsLock & y::SendBlind("{PgDn}")

;---- i === Home ----
CapsLock & i::SendBlind("{Home}")

;---- o === End ----
CapsLock & o::SendBlind("{End}")

;---- h === Left ----
CapsLock & h::SendBlind("{Left}")

;---- j === Down ----
CapsLock & j::SendBlind("{Down}")

;---- k === Up ----
CapsLock & k::SendBlind("{Up}")

;---- l === Right ----
CapsLock & l::SendBlind("{Right}")

; * = === 向右切换桌面
; * - === 向左切换桌面
CapsLock & =:: SendInput("^#{Right}")
CapsLock & -:: SendInput("^#{Left}")
