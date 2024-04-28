#Requires AutoHotkey v2.0

; 切换窗口模式
global altTabState := false ; 初始化 Alt + Tab 状态键
global isMove := false ; 初始化移动状态

$*LAlt:: {
    SendBlind "{LAlt Down}"
    ; ToolTip GetKeyState("LAlt") 
}

#HotIf GetKeyState("LAlt")
    ; Alt + Tab 时
    *~Tab:: {
        global
        ; 启动切换任务模式
        altTabState := true
        isMove := false
    }

    ; 退出窗口模式时
    *~LAlt Up:: {
        global
        if (altTabState) {
            altTabState := false
            ; 如果不是移动模式
            if !isMove
                ; 点击鼠标左键
                Click       
        }
        SendBlind "{LAlt Up}"
    }
#HotIf

; 移动模式
#HotIf altTabState
    *a::changMoveState("{Left}")
    *d::changMoveState("{Right}")
    *s::changMoveState("{Down}")
    *w::changMoveState("{Up}")
#HotIf

; 开启移动状态函数
changMoveState(action) {
    global
    isMove := true
    ; ToolTip action
    SendBlind action
}
;