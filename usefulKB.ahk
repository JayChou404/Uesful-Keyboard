#UseHook true ; 强制使用键盘钩子

SetKeyDelay 300 ; 设置一个合适的按键延迟时间，以降低按键发送速度。

; 判断 CapsLock 是否按下
SetCapsLockState "AlwaysOff"

global capslock := 0

global one := 0

*CapsLock::{
    SetCapsLockState 0
    global capslock := GetKeyState("CapsLock","P")
    Sleep 50
}
*CapsLock Up::
{
    SetCapsLockState 0
    global capslock := 0
    return
}

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
    
    ; 当按下 `v` 后, `v` 变为 `Shift`
    *c::CapsAction("LShift Down")
    ~c Up::
    {
        CapsAction("LShift Up")
    }   
    ; 当按下 `Space` 后, `Space` 变为 `Ctrl`
    Space::CapsAction("LCtrl Down")
    ~SPace Up::
    {
        CapsAction("LCtrl Up") 
    }
#HotIf

~v Up::
{
    CapsAction("LShift Up")
}
~SPace Up::
{
    CapsAction("LCtrl Up") 
}

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

