/************************************************************************
 * @description ---- 运行配置 ----
 * @file uKB_setting.ahk
 * @author 
 * @date 2023/06/08
 * @version 0.0.0
 ***********************************************************************/

; If the script is not elevated, relaunch as administrator and kill current instance:

; 管理员运行
full_command_line := DllCall("GetCommandLine", "str")

if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
{
    try
    {
        if A_IsCompiled
            Run '*RunAs "' A_ScriptFullPath '" /restart'
        else
            Run '*RunAs "' A_AhkPath '" /restart "' A_ScriptFullPath '"'
    }
    ExitApp
}

; MsgBox "A_IsAdmin: " A_IsAdmin "`nCommand line: " full_command_line

GLOBAL DEBUGMODE := true ; 调试模式
GLOBAL TICKRATE := 20 ; 内部逻辑刷新率为每秒50次.
GLOBAL PRESSWAIT := 200 ; 按键被视为按下的最小时长为250毫秒.
; InstallKeybdHook ; 显示最近的 20 次击键(用于调试), 使用~500kB内存?
SetCapsLockState "AlwaysOff" ; CapsLK 始终关闭
SetKeyDelay TICKRATE ; 设置按键延迟.

;允许在 2000 毫秒内最多按下 200 个热键而不触发警告对话框.
; A_HotkeyInterval := 2000 
; A_MaxHotkeysPerInterval := 50

;让 Send 成为 SendInput 的代名词. 由于其卓越的速度和可靠性, 推荐在新脚本中使用.
SendMode "Input"

#SingleInstance Force ; 只运行一个同名的脚本实例
#UseHook True ; 强制使用键盘钩子