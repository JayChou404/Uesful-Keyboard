; 运行配置.
GLOBAL DEBUGMODE := true ; 调试模式.
#SingleInstance Force ; --DEBUGONLY ~XPERZ SG::TEMPORA::SPTCMD.
GLOBAL TICKRATE := 20 ; 内部逻辑刷新率为每秒50次.
GLOBAL PRESSWAIT := 200 ; 按键被视为按下的最小时长为250毫秒.
SetKeyDelay TICKRATE ; 设置按键延迟.
SetCapsLockState "AlwaysOff" ; 关闭大写锁定.

;#UseHook true ; 强制使用键盘钩子.

; 状态标记.
GLOBAL 按键状态_大写锁定 := false
GLOBAL 按键状态_C := false
GLOBAL 按键状态_空格 := false
GLOBAL 按键状态_分号 := false
GLOBAL 逻辑状态_分号 := false
GLOBAL 按键状态_斜杠 := false
GLOBAL 逻辑状态_斜杠 := false
GLOBAL 状态标记_单手模式 := false


; 大写锁定状态组, 可缓存大写锁定的按键状态.
*CapsLock::
{
	if (按键状态_大写锁定 == true)
		return
	if (GetKeyState("CapsLock", "P"))
	{
		global 按键状态_大写锁定 := true
		if (DEBUGMODE)
			ToolTip("大写锁定_按下", 120, 120, 1)
	}
}
*CapsLock Up::
{
	global 按键状态_大写锁定 := false
	if (DEBUGMODE)
		ToolTip("大写锁定_释放", 120, 120, 1)
}


; 单手操作模式热键细节.
#HotIf (状态标记_单手模式)
	q::PgUp
	w::Up
	e::PgDn
	s::Down
	a::Left
	d::right
#HotIf ; EndHotIf (状态标记_单手模式)

; 单手操作模式热键取消.
#HotIf (GetKeyState("CapsLock", "P") AND GetKeyState("Space", "P"))
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
#HotIf ; EndHotIf (GetKeyState("CapsLock", "P") AND GetKeyState("Space", "P"))



; 当大写锁定键保持按下时的活动热键.
#HotIf (按键状态_大写锁定 == true)
	$*p:: 盲从发送("BS Down")
	$*p Up:: 盲从发送("BS Up")
	$*e:: 盲从发送("Esc Down")
	$*e Up:: 盲从发送("Esc Up")
	$*i:: 盲从发送("Home Down")
	$*i Up:: 盲从发送("Home Up")
	$*o:: 盲从发送("End Down")
	$*o Up:: 盲从发送("End Up")
	$*h:: 盲从发送("Left Down")
	$*h Up:: 盲从发送("Left Up")
	$*j:: 盲从发送("Down Down")
	$*j Up:: 盲从发送("Down Up")
	$*k:: 盲从发送("Up Down")
	$*k Up:: 盲从发送("Up Up")
	$*l:: 盲从发送("Right Down Down")
	$*l up:: 盲从发送("Right Up Down")
	$*u:: 盲从发送("PgUp Down")
	$*u Up:: 盲从发送("PgUp Up")
	$*n:: 盲从发送("PgDn Down")
	$*n Up:: 盲从发送("PgDn Up")
	$*v:: SendInput "{Shift Down}{Insert}{Shift Up}"
	$*,:: SendInput "{Alt Down}{Insert}{Alt Up}"
	$*d::+F10
	$*w::!F4
	$*s::shift
	$*a::Ctrl
	$r::^z
	f::Enter
	; f & j::Enter
	7::F7

	; 切换单手模式的启用状态.
	Alt & f::
	{
		global
		if (状态标记_单手模式 == false)
		{
			状态标记_单手模式 := true
			if (DEBUGMODE)
				ToolTip("单手模式_启用", 120, 145, 2)
			return
		}
		状态标记_单手模式 := false
		if (DEBUGMODE)
			ToolTip("单手模式_禁用", 120, 145, 2)
	}

	; 保持按下`C`时, `C`同等于`Shift`.
	*c::
	{
		if (按键状态_C == true)
			return
		if (GetKeyState("c", "P"))
		{
			盲从发送("LShift Down")
			GLOBAL 按键状态_C := true
			if (DEBUGMODE)
				ToolTip("C_已按下为_LShift", 120, 170, 3)
		}
	}
	~c Up::
	{
		盲从发送("LShift Up")
		GLOBAL 按键状态_C := false
		if (DEBUGMODE)
			ToolTip("C_撤销映射_LShift", 120, 170, 3)
	}

	; 保持按下`Space`时, `Space`同等于`Ctrl`.
	Space::
	{
		if (按键状态_空格 == true)
			return
		if (GetKeyState("Space", "P"))
		{
			盲从发送("LCtrl Down")
			GLOBAL 按键状态_空格 := true
			if (DEBUGMODE)
				ToolTip("Space_已按下为_LCtrl", 120, 195, 4)
		}
	}
	~SPace Up::
	{
		盲从发送("LCtrl Up")
		GLOBAL 按键状态_空格 := false
		if (DEBUGMODE)
			ToolTip("Space_撤销映射_LCtrl", 120, 195, 4)
	}

#HotIf ; EndHotIf (按键状态_大写锁定 == true)

; ; 再次弹起, 是否能有效防止不回弹 Ctrl 和 Shift 回弹 (正在重新阅览逻辑).
; ~c Up::
; {
; 	盲从发送("LShift Up")
; }
; ~SPace Up::
; {
; 	盲从发送("LCtrl Up")
; }

; 以盲从模式发送按键.
盲从发送(Action)
{
	Send "{Blind}{" Action "}"
}



; 保持按下`;`时, `;`同等于`Ctrl`.
$;:: { ; 20230605:XPERZ
	global TICKRATE, PRESSWAIT, 按键状态_分号, 逻辑状态_分号 ; 全局引入.
	LOCAL 循环保持 := 0 ; 静态生命周期缓存.

	

	if (按键状态_分号 == true)
		return ; 强制阻塞.

	按键状态_分号 := true ; 初始化标记.

	SetTimer(状态检测, TICKRATE) ; 启动计时器.
	
	状态检测(*) {
		循环保持 += TICKRATE
		if (DEBUGMODE)
			ToolTip(循环保持, 300, 220, 15)

		if (循环保持 < PRESSWAIT) { ; 计时器小于等待时间.
			if (GetKeyState(";", "P") == true) { ; 按键保持.
				;...
			}
			else { ; 按键抬起.
				SendInput "{;}" ; 发送默认形态.
				SetTimer(状态检测, 0) ; 关闭计时器.
				按键状态_分号 := false ; 置空按键状态.
				循环保持 := 0 ; 重设循环值.
				if (DEBUGMODE)
					ToolTip(";_已发送为_;", 120, 220, 5)
			}
		}
		else { ; 计时器大于等于等待时间.
			if (GetKeyState(";", "P") == true) { ; 按键保持.
				if (逻辑状态_分号 == true)
					return ; 强制阻塞.
				SendInput "{LCtrl Down}" ; 发送预定逻辑.
				逻辑状态_分号 := true ; 更新状态标记.
				if (DEBUGMODE)
					ToolTip(";_已发送为_LCtrl Down", 120, 220, 5)
			}
			else { ; 按键抬起.
				SendInput "{LCtrl Up}" ; 发送预定逻辑.
				SetTimer(状态检测, 0) ; 关闭计时器.
				按键状态_分号 := false ; 置空按键状态.
				逻辑状态_分号 := false ; 置空逻辑状态.
				循环保持 := 0 ; 重设循环值.
				if (DEBUGMODE)
					ToolTip(";_已发送为_LCtrl Up", 120, 220, 5)
			}
		}
	}
}

; 保持按下`/`时, `/`同等于`Shift`.
$/:: { ; 20230605:XPERZ
	global TICKRATE, PRESSWAIT, 按键状态_斜杠, 逻辑状态_斜杠 ; 全局引入.
	LOCAL 循环保持 := 0 ; 静态生命周期缓存.

	if (按键状态_斜杠 == true)
		return ; 强制阻塞.
	按键状态_斜杠 := true ; 初始化标记.

	SetTimer(状态检测, TICKRATE) ; 启动计时器.
	
	状态检测(*) {
		循环保持 += TICKRATE
		if (DEBUGMODE)
			ToolTip(循环保持, 300, 245, 16)

		if (循环保持 < PRESSWAIT) { ; 计时器小于等待时间.
			if (GetKeyState("/", "P") == true) { ; 按键保持.
				;...
			}
			else { ; 按键抬起.
				SendInput "{/}" ; 发送默认形态.
				SetTimer(状态检测, 0) ; 关闭计时器.
				按键状态_斜杠 := false ; 置空按键状态.
				循环保持 := 0 ; 重设循环值.
				if (DEBUGMODE)
					ToolTip("/_已发送为_/", 120, 245, 6)
			}
		}
		else { ; 计时器大于等于等待时间.
			if (GetKeyState("/", "P") == true) { ; 按键保持.
				if (逻辑状态_斜杠 == true)
					return ; 强制阻塞.
				SendInput "{LShift Down}" ; 发送预定逻辑.
				逻辑状态_斜杠 := true ; 更新状态标记.
				if (DEBUGMODE)
					ToolTip("/_已发送为_LShift Down", 120, 245, 6)
			}
			else { ; 按键抬起.
				SendInput "{LShift Up}" ; 发送预定逻辑.
				SetTimer(状态检测, 0) ; 关闭计时器.
				按键状态_斜杠 := false ; 置空按键状态.
				逻辑状态_斜杠 := false ; 置空逻辑状态.
				循环保持 := 0 ; 重设循环值.
				if (DEBUGMODE)
					ToolTip("/_已发送为_LShift Up", 120, 245, 6)
			}
		}
	}
}
