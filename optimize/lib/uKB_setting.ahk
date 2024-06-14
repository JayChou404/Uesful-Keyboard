#Requires AutoHotkey v2.0

InstallKeybdHook  ; 必须安装键盘钩子才能捕获按键
#UseHook true       ; 开启 hook 模式以提高响应速度和准确性

; 直接启用标准调试输出（将输出到 AutoHotkey 面板或命令提示符窗口）
#Warn All  ; 显示所有级别的警告信息
#ErrorStdOut  ; 将错误输出到命令提示符窗口

#SingleInstance force ; 只允许单个该脚本运行,脚本强制替换
A_HotkeyModifierTimeout := 0  ; 影响热键修饰符的行为：CTRL、ALT、WIN 和 SHIFT。设为 0 时则总是超时 (修饰键总是不会被推回到按下的状态).
ProcessSetPriority "High"  ; 脚本进程优先级为高

; 确保在执行脚本时，这些键被按下，模拟为释放状态，避免干扰脚本接下来的操作。
SendMode "Input" ; 使 Send 等同于 SendEvent 或 SendPlay, 而不是默认的(SendInput).
Send "{Alt Up}{Ctrl Up}{Shift Up}{LWin Up}{RWin Up}{CapsLock Up}"


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
GLOBAL TICKRATE := 20    ; 设置适合大多数操作的内部逻辑刷新率
GLOBAL DoubleClickInterval := 70 ; 定义双击间隔时间，单位毫秒
GLOBAL LastPressTime := 0



; 键位状态设置
SetCapsLockState "AlwaysOff"  ; 除非特定场景需要，否则保持CapsLock关闭
SetKeyDelay TICKRATE          ; 统一按键延迟，考虑根据需要调整