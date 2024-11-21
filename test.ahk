; 定义全局变量
global LastMouseMoveTime := 0
global LastKeyPressTime := 0
global EventTriggered := false

; 初始化鼠标移动监控
OnMessage(0x0200, Func("TrackMouseMove")) ; 0x0200 是 WM_MOUSEMOVE 消息

TrackMouseMove(wParam, lParam) {
    global LastMouseMoveTime
    LastMouseMoveTime := A_TickCount
    CheckEventTrigger()
}

; 定义热键，监控特定按键
Hotkey("a", TrackKeyPress, "On")
Hotkey("b", TrackKeyPress, "On")
Hotkey("Space", TrackKeyPress, "On")

TrackKeyPress() {
    global LastKeyPressTime
    LastKeyPressTime := A_TickCount
    CheckEventTrigger()
}

; 检查时间间隔
CheckEventTrigger() {
    global LastMouseMoveTime, LastKeyPressTime, EventTriggered
    if (!EventTriggered && (A_TickCount - LastMouseMoveTime < 200 || A_TickCount - LastKeyPressTime < 200)) {
        EventTriggered := true
        StartKeyboardMapping()
        SetTimer(ResetEventFlag, -200) ; 在200ms后重置事件触发标志
    }
}

; 启动键盘映射
StartKeyboardMapping() {
    Send("{F1}") ; 示例发送 F1 键
}

; 重置事件触发标志
ResetEventFlag() {
    global EventTriggered
    EventTriggered := false
}