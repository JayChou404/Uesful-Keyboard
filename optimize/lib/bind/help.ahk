#Requires AutoHotkey v2.0

CapsLock & /::
{
    ; 目标帮助文档路径
    filePath := "C:\Users\Jay Chou\OneDrive\School\Program\AutoHotkey\Usely-Keyboard\optimize\lib\bind\help\hotkeys.txt"
    ; 获取快捷键内容

    try {
        fileContent := FileRead(filePath, "`n m5000 UTF-8")
    } catch OSError {
        MsgBox "读取文件失败" 
        return
    }
        
    ; 初始化帮助文本字符串
    ; 获取当前状态
    helpText := "当前状态：" WinGetTitle('A') "`n`n"

    ; 将文件内容分割成行，并遍历每一行
    lines := StrSplit(fileContent, "`n")
    for index, line in lines {
        if (line != "") { ; 忽略空行
            keyValue := StrSplit(line, "=") ; 分割每一行为键和值
            if (keyValue.Length >= 2) {
                
                if (keyValue[2] == ' ') {
                    helpText .= "`n"
                    helpText .= keyValue[1] "`n"
                } else {
                    helpText .= keyValue[1] "`t`t`t" keyValue[2] "`n"
                }
            }
        }
    }



    ; 显示帮助信息
    MsgBox helpText, "帮助"
}
