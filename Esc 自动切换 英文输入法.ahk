;限定在vscode 程序里面发挥作用
#IfWinActive  ahk_exe Obsidian.exe	;vscode 的exe 名字叫做Code.exe 
Esc::
        sendinput,{Esc}
        PostMessage, 0x50, 0, 0x4090409, , A ;切换为英文0x4090409=67699721
return
#If