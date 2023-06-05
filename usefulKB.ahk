; 运行配置
GLOBAL DEBUGMODE := true ; 调试模式
GLOBAL TICKRATE := 20 ; 内部逻辑刷新率为每秒50次.
GLOBAL PRESSWAIT := 200 ; 按键被视为按下的最小时长为250毫秒.
SetCapsLockState "AlwaysOff" ; CapsLK 始终关闭
SetKeyDelay TICKRATE ; 设置按键延迟.
#SingleInstance Force ; 只运行一个同名的脚本实例
; #UseHook true ; 强制使用键盘钩子

; 状态标记
global capslock := false
global one := false ;
global c_only := false


; 函数调用区域

; send 发送函数
CapsAction(action)
{
    Send "{Blind}{" action "}"
}

; 调用 提示框 函数
tip(text, y, window, time) {
    y := y * 30
    time := time * 1000
    ToolTip(text, 1700, y + 850, window)
    SetTimer () => ToolTip(,,,window), -time
}

; 调用测试窗口
tmp(text, y) {
    if DEBUGMODE
        ToolTip(text, 1600, y*30+800, 20)
}

; CapsLock 状态判断,
*CapsLock::
{
    ; capslock 按下
    if (!capslock == true and GetKeyState("CapsLock", "P"))
    {
        global capslock := A_TickCount
        if (DEBUGMODE)
            toolTip("超级模式_启动", 1700, 850)
    }
}

*CapsLock Up::
{
    if (A_PriorKey = "CapsLock" && (A_TickCount - capslock) < 300)
    {
        if GetKeyState("CapsLock", "T") = 0
            SetCapsLockState true
        else
            SetCapsLockState "AlwaysOff"
    }
    global capslock := false
    Tip("超级模式_关闭", 0, 1, 1)
}

; 单手操作
#HotIf (!one == false)
    q::PgUp
    w::Up
    e::PgDn
    s::Down
    a::Left
    d::right
#HotIf

; 还原左半手的操作
#HotIf (GetKeyState("CapsLock","P") && GetKeyState("Space", "P"))
    q::q
    w::w
    e::e
    r::r
    t::t
    a::a
    s::s
    d::d
    f::f
    g::g
    z::z
    x::x
    ; c::c
    v::v
    b::b
#HotIf

; 当按下 Capslock 时, 修改键盘操作方式
#HotIf (!capslock == false)
    $*p::CapsAction("BS Down")
    $*p Up::CapsAction("BS Up")
    $*e::CapsAction("Esc Down")
    $*e Up::CapsAction("Esc Up")
    $*i::CapsAction("Home Down")
    $*i Up::CapsAction("Home Up")
    $*o::CapsAction("End Down")
    $*o Up::CapsAction("End Up")
    $*h::CapsAction("Left Down")
    $*h Up::CapsAction("Left Up")
    $*j::CapsAction("Down Down")
    $*j Up::CapsAction("Down Up")
    $*k::CapsAction("Up Down")
    $*k Up::CapsAction("Up Up")
    $*l::CapsAction("Right Down Down")
    $*l up::CapsAction("Right Up Down")
    $*u::CapsAction("PgUp Down")
    $*u Up::CapsAction("PgUp Up")
    $*n::CapsAction("PgDn Down")
    $*n Up::CapsAction("PgDn Up")
    $*v::SendInput "{Shift Down}{Insert}{Shift Up}"
    $*,::SendInput "{Alt Down}{Insert}{Alt Up}"
    $*d::+F10
    $*w::!F4
    $s::^+2
    $a::^+1
    $r::^z
    $*f::Enter
    7::F7

    ; 切换单手模式的启用状态
    Alt & f::
    {
        global 
        if (one == false)
        {
            one := true
            tip("单手模式_启用", 1, 2, 2)
            return
        }
        one := false
        Tip("单手模式_关闭", 1, 2, 2)
        return
    }
    
    ; 当按下 `c` 后, `c` 变为 `Shift`
    *c::
    {
        
        CapsAction("LShift Down")
        tmp("c_启用", 0)
    }
    ~c Up::
    {
        CapsAction("LShift Up")
        tmp("c_关闭", 1)
    }

    ; 当按下 `Space` 后, `Space` 变为 `Ctrl`
    *Space::
    {
        CapsAction("LCtrl Down")
    }
    ~Space Up::
    {
        CapsAction("LCtrl Up")
    }
#HotIf

; 在 HotIf 再次弹起, 不知道是否能有效防止 Ctrl 和 Shift 回弹
~c Up::
{
    CapsAction("LShift Up")
    tmp("c_关闭", 2)
}
~Space Up::
{
    CapsAction("LCtrl Up") 
}

; 修改 `;` 长按功能，长按为 ‘Ctrl’ 键
global stime := false
global single := 0
$;::{
    SendInput "{LCtrl Down}"
    global single
    if (!single == true) {
        global stime := A_TickCount
    }
    single := true
}

$; UP::
{
    global stime, single
    SendInput "{LCtrl Up}"
    ; Send stime
    ; Send "    "
    ; Send A_TickCount

    if (A_PriorKey = ";" && (A_TickCount - stime) < 300)
    {
        tmp(A_TickCount - stime, 3)
        SendInput "{;}"
    }
    single := false
}

; 修改 ‘/’ 长按功能，长按为 ‘shift’ 键
global slash := false
$/::{
    SendInput "{LShift Down}"
    global slash
    if (!slash == true) {
        global stime := A_TickCount
    }
    slash := true
}

$/ UP::
{
    global stime, slash
    SendInput "{LShift Up}"
    ; Send stime
    ; Send "    "
    ; Send A_TickCount

    if (A_PriorKey = "/" && (A_TickCount - stime) < 300)
    {
        tmp(A_TickCount - stime, 3)
        SendInput "{/}"
    }
    slash := false
}