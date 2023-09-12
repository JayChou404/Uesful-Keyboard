; 当按下 Capslock 时, 修改键盘操作方式
#HotIf (!capslock == false && c_s_down == false && c_app == false && c_one_hand == false)
    *p::CapsAction("BS DownR")
    *p Up::CapsAction("BS Up")

    *e::CapsAction("Esc DownR")
    *e Up::CapsAction("Esc Up")

    *i::CapsAction("Home DownR")
    *i Up::CapsAction("Home Up")

    *o::CapsAction("End DownR")
    *o Up::CapsAction("End Up")

    *h::CapsAction("Left DownR")
    *h Up::CapsAction("Left Up")

    *j::CapsAction("Down DownR")
    *j Up::CapsAction("Down Up")
    
    *k::CapsAction("Up DownR")
    *k Up::CapsAction("Up Up")

    *l::CapsAction("Right DownR")
    *l up::CapsAction("Right Up")

    *u::CapsAction("PgUp DownR")
    *u Up::CapsAction("PgUp Up")

    *n::CapsAction("PgDn DownR")
    *n Up::CapsAction("PgDn Up")

    *d::+F10

    *w::!F4

    *e::Esc

    *f::Enter
    ; 切换单手模式的启用状态
    Alt & f::
    {
        global 
        if (c_one_hand == false)
        {
            c_one_hand := true
            tip("单手模式_启用", 1, 2, 2)
            return
        }
        c_one_hand := false
        Tip("单手模式_关闭", 1, 2, 2)
        return
    }
    
    ; 当按下 `v` 后, `v` 变为 `Shift`
    *v::
    {
        
        CapsAction("LShift DownR")
        tmp("c_启用", 0)
    }
    ~v Up::
    {
        CapsAction("LShift Up")
        tmp("c_关闭", 1)
    }

    ; 当按下 `Space` 后, `Space` 变为 `Ctrl`
    *Space::
    {
        CapsAction("LCtrl DownR")
    }
    ~Space Up::
    {
        CapsAction("LCtrl Up")
    }
#HotIf
