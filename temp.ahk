#Requires AutoHotkey v2.0

Acc_Init(InitOnce := false)
{
    static h := ""
    
    if (!h && !InitOnce)
    {
        h := DllCall("LoadLibrary", "Str", "oleacc", "Ptr")
        if (!h)
            throw "Failed to load oleacc library."
        InitOnce := true
    }
}

Acc_ObjectFromEvent(&_idChild_, hWnd, idObject, idChild)
{
    Acc_Init()

    varChild := Buffer(8 + 2 * A_PtrSize, 0)
    pacc := 0

    ; 根据新要求，确保传递的参数是数字而非表达式，并确保“Ptr*”参数是VarRef或具有Ptr属性的对象
    result := DllCall("oleacc\AccessibleObjectFromEvent", "Ptr", hWnd, "UInt", idObject, "UInt", idChild, "Ptr*", &pacc, "Ptr", varChild.Ptr)

    if (result = 0)
    {
        ; 对获取到的COM指针调用ObjAddRef以增加引用计数，防止提前释放
        ObjAddRef(pacc)

        obj := ComObjFromPtr(pacc)
        _idChild_ := NumGet(varChild, 8, "UInt")

        Return obj
    }

    ; 若有必要，在不再使用obj时，应在合适的地方调用ObjRelease(obj)以减小引用计数
}

; ; 使用完毕后释放引用示例
; funcDone(obj)
; {
;     if (typeof(obj) == "object" && obj COM_Obj)
;         ObjRelease(obj)
; }

Acc_ObjectFromPoint(&_idChild_ := "", x := "", y := "")
{
    Acc_Init()

    ; 使用Buffer创建足够的内存空间来存储varChild变量
    varChild := Buffer(8 + 2 * A_PtrSize, 0)

    ; 根据坐标值构建64位Int64参数
    Coord := x == "" || y == "" ? 0 : (x & 0xFFFFFFFF) | (y << 32)
    
    ; 调用AccessibleObjectFromPoint函数，确保正确传递Ptr类型的参数
    result := DllCall("oleacc\AccessibleObjectFromPoint", "Int64", Coord, "Ptr*", &pacc, "Ptr", varChild.Ptr)

    if (result = 0)
    {
        ; 由于ComObjEnwrap已被替换，这里使用ComObjFromPtr来包装COM对象并增加引用计数
        obj := ComObjFromPtr(pacc)
        
        _idChild_ := NumGet(varChild, 8, "UInt")

        ; 返回封装后的COM对象和_idChild_
        Return {obj: obj, _idChild_: _idChild_}
    }
}

Acc_ObjectFromWindow(hWnd, idObject := -4)
{
    Acc_Init()

    ; 创建足够大小的缓冲区存储IID变量
    IID := Buffer(16, 0)

    ; 根据idObject的值填充IID
    If (idObject == -4)
        NumPut(0x46000000000000C0, IID, "Int64")  ; 使用IUIAutomation界面标识符
    Else
        NumPut(0x719B3800AA000C81, IID, "Int64")  ; 使用其他界面标识符

    ; 计算IID的高位部分
    If (idObject == 0xFFFFFFF0)
        NumPut(0x0000000000020400, IID, "Int64", 8)
    Else
        NumPut(0x11CF3C3D618736E0, IID, "Int64", 8)

    pacc := 0

    ; 调用AccessibleObjectFromWindow函数，确保正确传递Ptr类型的参数
    result := DllCall("oleacc\AccessibleObjectFromWindow", "Ptr", hWnd, "UInt", idObject&=0xFFFFFFFF, "Ptr", IID.Ptr, "Ptr*", &pacc)

    if (result = 0)
    {
        ; 使用ComObjFromPtr包装COM对象，并增加引用计数（如果ComObjFromPtr内部未处理）
        obj := ComObjFromPtr(pacc)

        ; 返回封装后的COM对象
        Return obj
    }
}

Acc_WindowFromObject(pacc)
{
    hWnd := 0
    ; 在AHK v2.0中，可以从ComObject直接获取其Ptr属性
    If (DllCall("oleacc\WindowFromAccessibleObject", "Ptr", pacc.Ptr, "Ptr*", hWnd) = 0)
        Return hWnd
    Else
        Return ""  ; 或者根据需求返回一个错误代码或特殊值来表示失败
}

; 在AutoHotkey v2.0中，A_IsUnicode始终为true，因为脚本被编译为Unicode。
Acc_GetRoleText(nRole)
{
    ; 首先，调用 GetRoleTextW 函数计算所需缓冲区大小
    nSize := DllCall("oleacc\GetRoleTextW", "Uint", nRole, "Ptr", 0, "Uint", 0)

    ; 分配足够的Unicode缓冲区（每个字符占用2个字节）
    roleBuffer := Buffer(nSize * 2)

    ; 再次调用 GetRoleTextW 函数，这次将缓冲区地址和大小传入，获取角色文本
    DllCall("oleacc\GetRoleTextW", "Uint", nRole, "Ptr", roleBuffer.Ptr, "Uint", nSize)

    ; 使用StrGet从缓冲区中提取并返回角色文本字符串
    Return StrGet(roleBuffer)
}

Acc_GetStateText(nState)
{
    ; 调用 GetStateTextW 函数获取所需的缓冲区大小（假设 oleacc\GetStateTextW 存在且用于获取Unicode文本）
    nSize := DllCall("oleacc\GetStateTextW", "Uint", nState, "Ptr", 0, "Uint", 0)

    ; 创建一个足够大的Unicode缓冲区，每个Unicode字符占用2个字节
    stateBuffer := Buffer(nSize * 2)

    ; 调用 GetStateTextW 函数填充缓冲区，注意这里的缓冲区大小应不包含额外的空字节
    DllCall("oleacc\GetStateTextW", "Uint", nState, "Ptr", stateBuffer.Ptr, "Uint", nSize)

    ; 将缓冲区内容转换为字符串并返回
    Return StrGet(stateBuffer)
}

; 注意：在AutoHotkey v2.0中，由于默认脚本编码为Unicode，因此一般会直接使用Unicode版的API函数，
; 并且在创建Buffer时直接按Unicode格式分配内存，这里假设oleacc库提供的API也是Unicode兼容的。

Acc_SetWinEventHook(eventMin, eventMax, pCallback)
{
	Return	DllCall("SetWinEventHook", "Uint", eventMin, "Uint", eventMax, "Uint", 0, "Ptr", pCallback, "Uint", 0, "Uint", 0, "Uint", 0)
}

Acc_UnhookWinEvent(hHook)
{
	Return	DllCall("UnhookWinEvent", "Ptr", hHook)
}

; Written by jethrow
Acc_Role(Acc, ChildId := 0) {
	try return ComObjType(Acc,"Name")="IAccessible"?Acc_GetRoleText(Acc.accRole(ChildId)):"invalid object"
}

Acc_State(Acc, ChildId := 0) {
	try return ComObjType(Acc,"Name")="IAccessible"?Acc_GetStateText(Acc.accState(ChildId)):"invalid object"
}

Acc_Location(Acc, ChildId := 0, &Position := "") 
{
    try
    {
        ; 初始化变量
        x := 0, y := 0, w := 0, h := 0
        
        ; 调用 accLocation 方法
        Acc.accLocation(x, y, w, h, ChildId)

        ; 构建位置信息字符串
        Position := "x" . x . " y" . y . " w" . w . " h" . h
        
        ; 返回位置尺寸对象
        return {x: x, y: y, w: w, h: h}
    }
    catch
    {
        return ; 或者自行处理错误，例如：LogError(e)
    }
}

Acc_Parent(Acc) {
    try
    {
        ; 尝试获取指定自动化对象 Acc 的父对象
        parent := Acc.accParent

        ; 如果成功获取到了父对象（parent 不为空或 0）
        if (parent)
        {
            ; 调用另一个名为 Acc_Query 的函数，传入父对象进行进一步查询或处理
            return Acc_Query(parent)
        }
    }
}

Acc_Child(Acc, ChildId := 0) {
    try
        {
            ; 尝试获取指定自动化对象 Acc 的父对象
            child := Acc.accParent
    
            ; 如果成功获取到了父对象（parent 不为空或 0）
            if (child)
            {
                ; 调用另一个名为 Acc_Query 的函数，传入父对象进行进一步查询或处理
                return Acc_Query(child)
            }
        }
}

Acc_Query(Acc) { ; thanks Lexikos - www.autohotkey.com/forum/viewtopic.php?t=81731&p=509530#509530
	try
        {
            ; 在 AHK v2.0 中，可能需要直接通过接口 IID 调用对象的方法或属性
            ; 假设 "618736e0-3c3d-11cf-810c-00aa00389b71" 是一个已知接口标识符
            ; 下面代码仅为示例，具体实现取决于 Acc 对象的实际接口
            interfaceID := "{618736e0-3c3d-11cf-810c-00aa00389b71}"
            QueryInterfaceMethod := Acc.getMethod(interfaceID)
            if (QueryInterfaceMethod)
            {
                queriedObj := QueryInterfaceMethod.invoke([])
                if (queriedObj)
                    return queriedObj
            }
            ; 如果查询失败或接口不存在，可以返回错误或空值
            return ""
        }
}

Acc_Error(&Param := "") {
    static Setting := 0
    
    if (Param == "")
    {
        return Setting
    }
    else
    {
        Setting := Param
        return Setting
    }
}

Acc_Children(Acc) {
    if (ComObjType(Acc, "Name") != "IAccessible") {
        ErrorLevel := "Invalid IAccessible Object"
    } else {
        Acc_Init()
        cChildren := Acc.accChildCount
        Children := []

        varChildren := Buffer(cChildren * (8 + 2 * A_PtrSize))
        Result := DllCall("oleacc\AccessibleChildren", "Ptr", ComObjValue(Acc), "Int", 0, "Int", cChildren, "Ptr", varChildren.Ptr, "Int*", cChildren)

        if (Result == 0) {
            Loop %cChildren%
            {
                i := (A_Index - 1) * (A_PtrSize * 2 + 8) + 8
                child := ComObjFromPtr(NumGet(varChildren, i, "Ptr"))
                if (NumGet(varChildren, i - 8, "UInt") == 9) {
                    child := Acc_Query(child)
                    ObjRelease(child)
                }
                Children.Insert(child)
            }
            return Children.MaxIndex() > 0 ? Children : []
        } else {
            ErrorLevel := "AccessibleChildren DllCall Failed"
        }
    }

    if (Acc_Error())
        throw Error(ErrorLevel, -1)
}

Acc_ChildrenByRole(Acc, Role) {
    if (ComObjType(Acc, "Name") != "IAccessible") {
        ErrorLevel := "Invalid IAccessible Object"
    } else {
        Acc_Init()
        cChildren := Acc.accChildCount
        Children := []

        varChildren := Buffer(cChildren * (8 + 2 * A_PtrSize))
        Result := DllCall("oleacc\AccessibleChildren", "Ptr", ComObjValue(Acc), "Int", 0, "Int", cChildren, "Ptr", varChildren.Ptr, "Int*", cChildren)

        if (Result == 0) {
            Loop %cChildren%
            {
                i := (A_Index - 1) * (A_PtrSize * 2 + 8) + 8
                childPtr := NumGet(varChildren, i, "Ptr")

                if (NumGet(varChildren, i - 8, "UInt") == 9) {
                    AccChild := ComObjFromPtr(childPtr)
                    ObjAddRef(AccChild) ; 加入引用计数
                    if (Acc_Role(AccChild) == Role) {
                        Children.Insert(AccChild)
                        ObjRelease(AccChild) ; 减少引用计数
                    }
                } else {
                    if (Acc_Role(Acc, childPtr) == Role) {
                        Children.Insert(childPtr)
                    }
                }
            }

            if (Children.MaxIndex() > 0) {
                ErrorLevel := 0
                return Children
            }
        } else {
            ErrorLevel := "AccessibleChildren DllCall Failed"
        }
    }

    if (Acc_Error())
        throw Error(ErrorLevel, -1)
}

Acc_Get(Cmd, ChildPath := "", ChildID := 0, WinTitle := "", WinText := "", ExcludeTitle := "", ExcludeText := "") {
	static properties := {Action:"DefaultAction", DoAction:"DoDefaultAction", Keyboard:"KeyboardShortcut"}
	AccObj :=   IsObject(WinTitle)? WinTitle
			:   Acc_ObjectFromWindow( WinExist(WinTitle, WinText, ExcludeTitle, ExcludeText), 0 )
	if ComObjType(AccObj, "Name") != "IAccessible"
		ErrorLevel := "Could not access an IAccessible Object"
	else {
		ChildPath := StrReplace(ChildPath, "_", A_Space)
		AccError := Acc_Error(), Acc_Error()
		Loop Parse ChildPath, ".", A_Space
			try {
				if IsDigit(A_LoopField)
					Children := Acc_Children(AccObj), m2:=A_LoopField ; mimic "m2" output in else-statement
				else
					RegExMatch(A_LoopField, "(\D*)(\d*)", &m), Children:=Acc_ChildrenByRole(AccObj, &m1), m2:=(m2?m2:1)
				if Not Children.HasKey(m2)
					throw
				AccObj := Children[m2]
			} catch {
				ErrorLevel:="Cannot access ChildPath Item #" A_Index " -> " A_LoopField, Acc_Error(&AccError)
				if Acc_Error()
					throw Error("Cannot access ChildPath Item", -1, "Item #" A_Index " -> " A_LoopField)
				return
			}
		Acc_Error(&AccError)
		Cmd := StrReplace(Cmd, A_Space)
        if (properties.HasKey(Cmd)) {
            Cmd := properties[Cmd]
        }
        try {
            if (Cmd = "Location")
            {
                CoordVars := { x: 0, y: 0, w: 0, h: 0 }
                AccObj.accLocation(ComValue(0x4003 | 0x4000, &CoordVars.x),  ; VT_BYREF | VT_I4
                                ComValue(0x4003 | 0x4000, &CoordVars.y),
                                ComValue(0x4003 | 0x4000, &CoordVars.w),
                                ComValue(0x4003 | 0x4000, &CoordVars.h),
                                ChildId)
                ret_val := "x" CoordVars.x " y" CoordVars.y " w" CoordVars.w " h" CoordVars.h
            }
            else if (Cmd = "Object")
            {
                ret_val := AccObj
            }
            else if (Cmd = "Role" or Cmd = "State")
            {
                ret_val := Acc_%Cmd%(AccObj, ChildID+0)
            }
            else if (Cmd = "ChildCount" or Cmd = "Selection" or Cmd = "Focus")
            {
                ret_val := AccObj["acc" Cmd]
            }
            else
            {
                ret_val := AccObj["acc" Cmd](ChildID+0)
            }
        } catch {
            ErrorLevel := "`"" Cmd " Cmd Not Implemented"
            if Acc_Error()
                throw Error("Cmd Not Implemented", -1, Cmd)
            return
        }
		Return {ret_val: ret_val, ErrorLevel: 0}
	}
	if Acc_Error()
		throw Error(ErrorLevel,-1)
}