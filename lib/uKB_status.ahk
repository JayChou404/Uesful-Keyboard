; 状态标记
global capslock := false
global c_one_hand := false
global c_v_down := false
global c_s_down := false
global c_f_down := false
global c_app := false
global stime := false
global single := 0

; CapsLock 状态判断
#Include %A_LineFile%\..\status\uKB_c.ahk

; CapsLock 按下, 对 s 的判断
#Include %A_LineFile%\..\status\uKB_c_s.ahk