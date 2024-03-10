/************************************************************************
 * @description ---- 运行配置 ----
 * @file uKB_setting.ahk
 * @author 
 * @date 2023/06/08
 * @version 0.1.0 (优化版本)
 ************************************************************************/

; 提高权限并重启脚本（如果必要）
full_command_line := DllCall("GetCommandLine", "str")
if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\\S)"))
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

; 全局设置
GLOBAL DEBUGMODE := true  ; 调试模式开关
GLOBAL TICKRATE := 20     ; 设置适合大多数操作的内部逻辑刷新率
GLOBAL PRESSWAIT := 200   ; 定义按键被视为按下的最短时长

; 键位状态设置
SetCapsLockState "AlwaysOff"  ; 除非特定场景需要，否则保持CapsLock关闭
SetKeyDelay TICKRATE          ; 统一按键延迟，考虑根据需要调整
