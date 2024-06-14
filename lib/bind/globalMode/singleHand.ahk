#Requires AutoHotkey v2.0

; 发送a/w/s/d,模拟移动
capslock & a::
{
    SendBlind "{Left}"
}
capslock & w::
{
    SendBlind "{Up}"
}
capslock & s::
{
    SendBlind "{Down}"
}
capslock & d::
{
    SendBlind "{Right}"
}
capslock & x::
{
    SendBlind "{Delete}"
}
capslock & z::
{
    SendBlind "{Backspace}"
}
capslock & f::SendBlind "{Enter}"
capslock & c::
{
    SendBlind "{Ctrl Down}{Left}{Ctrl Up}"
}
capslock & v::
{
    SendBlind "{Ctrl Down}{Right}{Ctrl Up}"
}
capslock & q::
{
    SendBlind "{Home}"
} ; 移动到行首
capslock & e::
{
    SendBlind "{End}"
} ; 移动到行尾
