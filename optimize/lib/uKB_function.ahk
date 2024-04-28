#Requires AutoHotkey v2.0

;化发送盲动作功能
SendBlind(action)
{
    Send "{Blind}" action
}

DoubleKeyPress(singlePressAction, doublePressAction) {
    global DoubleClickInterval
    global LastPressTime

    keyPressTime := A_TickCount
    if (keyPressTime - LastPressTime <= DoubleClickInterval) {
        SendBlind(doublePressAction)
        return 
    }
    LastPressTime := 0 ; 重置时间，防止连续多次触发
    SendBlind(singlePressAction)
}

BeforeActionDo_CheckMode(ControlNames*) {  ; ControlNames为当前需要使用vim模式的控件列表，逗号隔开
    OutputVar := ControlGetFocus()  ; AHK 2.0使用函数返回值而不是直接修改变量
    if WinExist("ahk_class #32768")  ; 检查是否存在菜单窗口
        return 0
    if !OutputVar  ; 变量为空，没有获取到控件名称
        return 2
    for index, ControlName in ControlNames {
        ListName := ControlNames[index]
        if InStr(OutputVar, ListName)  ; AHK 2.0使用InStr代替contains
            return 1
    }
    return 0
}