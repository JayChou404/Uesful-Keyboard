/************************************************************************
 * @description ---- 函数调用 ----
 * @file uKB_function.ahk
 * @author 
 * @date 2023/06/08
 * @version 0.1.0 (优化版本)
 ************************************************************************/


;化发送盲动作功能
Sd(action)
{
    Send "{Blind}" action
}

SendBlind(action)
{
    Send "{Blind}" action
}


; 调用 提示框 函数
tip(text, y, window, time) 
{
    y := y * 30
    time := time * 1000
    ToolTip(text, 1700, y + 850, window)
    SetTimer () => ToolTip(,,,window), -time
}

; 调用测试窗口
tmp(text, y) 
{
    if DEBUGMODE
        ToolTip(text, 1600, y*30+800, 20)
}

; 检测旁边是否有(), [], {}, <>
dB() {
    Send("Shift Down")
}