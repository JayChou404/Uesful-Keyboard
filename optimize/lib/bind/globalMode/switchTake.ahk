#Requires AutoHotkey v2.0

; 切换窗口模式
global isAltTabModeActive := false ; 初始化 Alt + Tab 状态键

$*LAlt:: {
    SendBlind "{LAlt Down}"
    ; ToolTip GetKeyState("LAlt") 
}

#HotIf GetKeyState("LAlt")
    ; Alt + Tab 时
    *~Tab:: {
        global
        ; 启动切换任务模式
        isAltTabModeActive := true
    }

    ; 退出窗口模式时
    *~LAlt Up:: {
        global
        if (isAltTabModeActive) {
            isAltTabModeActive := false
        }
        SendBlind "{LAlt Up}"
    }
#HotIf

; 移动模式
#HotIf isAltTabModeActive
    *a::changMoveState("{Left}")
    *d::changMoveState("{Right}")
    *s::changMoveState("{Down}")
    *w::changMoveState("{Up}")
#HotIf

; 移动模式
changMoveState(action) {
    SendBlind action
}
;