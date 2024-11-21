#Requires AutoHotkey v2.0

; 定义组合键操作，当按下capslock和相应方向键时，发送对应的键盘指令

; 发送a/w/s/d,模拟移动
capslock & h::
{
    SendBlind "{Left}"
}
capslock & k::
{
    SendBlind "{Up}"
}
capslock & j::
{
    SendBlind "{Down}"
}
capslock & l::
{
    SendBlind "{Right}"
}

; 发送x/z,模拟删除和后退操作
capslock & m::
{
    SendBlind "{Delete}"
}
capslock & n::
{
    SendBlind "{Backspace}"
}

; 发送q/e,模拟移动到行首或行尾
capslock & i::
{
    SendBlind "{Home}"
} ; 移动到行首
capslock & o::
{
    SendBlind "{End}"
} ; 移动到行尾