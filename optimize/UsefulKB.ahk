/************************************************************************
 * @description 主入口
 * @file UsefulKB.ahk
 * @author 
 * @date 2024/03/13 
 * @version 0.1.1
 ***********************************************************************/
#Requires AutoHotkey v2.0

#SuspendExempt
CapsLock & p::Suspend ; 启动/停止脚本热键修改等。
#SuspendExempt False

;---- Initializer ----  
#Include %A_LineFile%\..\lib\uKB_setting.ahk

;---- Function ----
#Include %A_LineFile%\..\lib\uKB_function.ahk

;---- bind ----
#Include %A_LineFile%\..\lib\uKB_bind.ahk

;---- test ----
; #Include %A_LineFile%\..\test.ahk