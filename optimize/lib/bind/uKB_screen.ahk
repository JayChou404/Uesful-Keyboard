/************************************************************************
 * @description --- Screen Operation ----
 * CapsLock +=
 * 
 * @file uKB_Screen.ahk
 * @author 
 * @date 2023/06/07
 * @version 0.0.0
 ***********************************************************************/

;---- Mouse Controller ----

RShift & w::MouseMove(0, -10, 0, "R")  ; Mouse Up
RShift & s::MouseMove(0, 10, 0, "R")   ; Mouse Down
RShift & a::MouseMove(-10, 0, 0, "R")  ; Mouse Left
RShift & d::MouseMove(10, 0, 0, "R")   ; Mouse Right

;---- CapsLock + Enter(Push Release) === Mouse Left Push(Release) ----
RShift & f::
{
    SendEvent("{LButton Down}")
    KeyWait("f")
    SendEvent("{LButton Up}")
}

; ;---- Scroll Left ----
; CapsLock & WheelUp::    ; 向左滚动
; ControlGetFocus, fcontrol, A
; Loop 2  ; <-- 增加这个值来加快滚动速度
;     SendMessage, 0x114, 0, 0, %fcontrol%, A  ; 0x114 是 WM_HSCROLL, 它后面的 0 是 SB_LINELEFT
; return

; ;---- Scroll Right ----
; CapsLock & WheelDown::  ; 向右滚动
; ControlGetFocus, fcontrol, A
; Loop 2  ; <-- 增加这个值来加快滚动速度
;     SendMessage, 0x114, 1, 0, %fcontrol%, A  ; 0x114 是 WM_HSCROLL, 它后面的 1 是 SB_LINERIGHT
; return
