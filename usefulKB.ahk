#UseHook true ; 强制使用键盘钩子

SetKeyDelay 30 ; 设置一个合适的按键延迟时间，以降低按键发送速度。

SetCapsLockState "AlwaysOff" ; CapsLK 始终关闭

; 判断 CapsLock 是否按下
global capslock := 0

*CapsLock::
{
    if (!capslock and GetKeyState("CapsLock", "P"))
    {
        global capslock := 1
    }
}

*CapsLock Up::
{
    global capslock := 0
}

global one := 0 ;

; 单手操作
#HotIf (one)
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
#HotIf (capslock)
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
    f::Enter
    ; f & j::Enter
    7::F7

    ; 启动单手模式
    Alt & f::
    {
        global 
        if (!one)
        {
            one := 1
            return
        }
        one := 0
        return
    }
    
    ; 当按下 `c` 后, `c` 变为 `Shift`
    global c_only := 0
    *c::
    {
        if (!c_only and GetKeyState("c", "P")) 
        {
        CapsAction("LShift Down")
        }
    }
    ~c Up::
    {
        CapsAction("LShift Up")
    }   

    ; 当按下 `Space` 后, `Space` 变为 `Ctrl`
    global space_Only := 0
    Space::
    {
        if (!space_Only and GetKeyState("Space", "P")) 
        {
            CapsAction("LCtrl Down")
        }
    }
    ~SPace Up::
    {
        CapsAction("LCtrl Up") 
    }
#HotIf

; 在 HotIf 再次弹起, 不知道是否能有效防止 Ctrl 和 Shift 回弹
~c Up::
{
    CapsAction("LShift Up")
}
~SPace Up::
{
    CapsAction("LCtrl Up") 
}

; send 发送函数
CapsAction(action)
{
    Send "{Blind}{" action "}"
}

; 修改 `;` 长按功能，长按为 ‘Ctrl’ 键
global stime := 0
global single := 0
$;::{
    SendInput "{LCtrl Down}"
    global single
    if (!single) {
        global stime := A_TickCount
    }
    single := 1
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
        SendInput "{;}"
    }
    stime := 0
    single := 0
}

; 修改 ‘/’ 长按功能，长按为 ‘shift’ 键
global slash := 0
$/::{
    SendInput "{LShift Down}"
    global slash
    if (!slash) {
        global stime := A_TickCount
    }
    slash := 1
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
        SendInput "{/}"
    }
    stime := 0
    slash := 0
}