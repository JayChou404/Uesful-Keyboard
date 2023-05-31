# Useful KeyBoard

我想在 Windows 平台中，拥有跟有用的自定义键盘（从软件层面修改）。

对于普通的键盘，通过`长按(long press)`、`组合键`和`层(layer)`这3个，即可实现强大的功能

## 使用的技术
- AutoHotkey（简单易上手）

## 平台
`autohotkey` 仅支持 windows

- Windows

## 个人方案
任何自定义都是根据个人个性化的，所以它太可能不适合你。你可以选择自己 fork 后，再自定义属于自己的功能。后续更新图形化界面实现自定义键盘。

>其中脚本中还存在我无法解决的 bug()
>
>- 当按上/下/左/右等热键时，如果**操作过快**，脚本会崩溃无法使用
>- 当按下 `Ctrl`/`Shift` 键时，**无法回弹**

- 修改 `;` 长按功能（短按功能不变），长按为 `Ctrl` 键
- 修改 `/` 长按功能（短按功能不变），长按为 `Shift` 键

## 大写锁定键的修改
利用过时的 `caps lock` 按键
取消 `caps lock`功能

## 入超级模式

![useful Keyboard](images/Pasted%20image%2020230531111221.png)
单击`caps lock`即可激活超级模式（这就像你有一个秘密基地），再次单击即可退出（这个功能可以快速切换模式，而不像 vim 需要按下回弹后才能切换）。进入此模式后，你就可以：
- 使用`h`/`j`/`k`/`l`实现**左**/**下**/**上**/**右**（就像**vim**移动的操作方式）
%%- 使用`a`/`;`实现`Ctrl`键的功能%%
%%- 使用`Space`实现`Shift`键的功能（我认为可以实现完全替换大写锁定键）%%j
- `caps lock`+`i`/`o` 实现 `Home`/`End`(移动到前面/后面)
- `caps lock`+`u`/`n`实现 `PgUp`/`PgDn` (上一页/下一页)
- `caps lock`+`'`实现`Enter`
- `caps lock+` `d` 实现 `Shift` + `F10` （快速打开快捷菜单）
- `caps lock+` `w` 实现 `Alt` + `F4`（关闭程序或关闭窗口）
- `caps lock+` `z` 实现 `Esc`（取消）

- `caps lock+` `r` 实现 `Ctrl` + `z`(撤回) 
- `caps lock`+`p`实现`Backspace`（退格键）
- `caps lock`+`v`实现`Shift`+`Insert`（粘贴）
- `caps lock`+`c`实现`Shift`（进行多选等操作）
- `caps lock`+`Space`实现`Ctrl`

## 单手模式
> `caps lock`+`Alt`+`f` 打开**单手模式**

- 使用 q/e 实现向**上**/**下**翻页
- 使用 w/s/a/d 实现**上**/**下**/**左**/**右**

### App模式

## 想法
- 实现大众化
- 图形化界面
- 能简单自定义热键功能

## 安装
**不安装任何软件的方法**
直接下载启用[usefulKB.exe](usefulKB.exe)

**安装AutoHotkey的方法**
1. 下载安装[AutoHotKey](https://www.autohotkey.com/)
2. `win`+`r`打开命令行，输入
```
shell:startup
```
将文件[usefulKB.ahk](usefulKB.ahk)，让这个AutoHotKey脚本可以在开机时自启动

## 感谢以下

- [jasonrudolph/keyboard: ⌨ Toward a more useful keyboard (github.com)](https://github.com/jasonrudolph/keyboard#a-more-useful-caps-lock-key)
- [boppreh/keyboard: Hook and simulate global keyboard events on Windows and Linux. (github.com)](https://github.com/boppreh/keyboard#keyboard.on_press)
- [超详细的基础QMK键盘固件制作教程（Windows版） - 哔哩哔哩 (bilibili.com)](https://www.bilibili.com/read/cv7323725/)
- [rcmdnk/vim_ahk：使用自动热键设置文件以模拟 vim (github.com)](https://github.com/rcmdnk/vim_ahk)
- [xiongyihui/keyboard: 解开键盘封印，释放生产力 (github.com)](https://github.com/xiongyihui/keyboard)
- [自用ahk热键脚本及相关回顾 - AutoHotkey Community](https://www.autohotkey.com/boards/viewtopic.php?f=28&t=85872&p=377029&hilit=%E7%83%AD%E9%94%AE%E8%BF%9E%E7%BB%AD%E6%8C%89%E4%BC%9A%E8%AF%AF%E8%A7%A6#p377029)
- [AutoHotkey/AutoHotkey: AutoHotkey - macro-creation and automation-oriented scripting utility for Windows. (github.com)](https://github.com/AutoHotkey/AutoHotkey)
- [rcmdnk/vim_ahk: Setting file to emulate vim with AutoHotkey (github.com)](https://github.com/rcmdnk/vim_ahk)
- [Tag: AutoHotkey (rcmdnk.com)](https://rcmdnk.com/blog/tags/autohotkey/)