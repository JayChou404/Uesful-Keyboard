# Useful KeyBoard
[中文](README_CN.md) 和 [English](README.md)

在 Windows 平台中，通过 autoHotkey 重新利用自定义键盘功能。组合其它功能实现强大的



## 使用的技术
- AutoHotkey

## 平台

- Windows

## 个人方案
任何自定义功能都是根据个人习惯设置的，这些很多功能比较繁杂。

> 其中脚本中还存在我无法解决的 bug()
>
>- 按下`CapsLk` + 其它操作时，脚本极其容易崩溃，还会时不时的错误发送被禁用的按键，可能出现大写状态被 `;` 所控制，就很奇怪

## 修改 `;` 与 `/` 的长按功能

- 修改 `;` 长按功能（短按功能不变），长按为 `Ctrl` 键
- 修改 `/` 长按功能（短按功能不变），长按为 `Shift` 键

## 大写锁定键的修改
- 取消 `caps lock`原有的功能
- 长按进入超级模式

## 入超级模式

![useful Keyboard](images/capsLK-Down.png)
**长按**`caps lock`即可激活超级模式，而不像 vim 需要按下回弹后才能切换）。按下`caps lock` 键后，键盘功能改变：

- `h`/`j`/`k`/`l`实现**左**/**下**/**上**/**右**（就像**vim**移动的操作方式）
- `i`/`o` 实现 `Home`/`End`(移动到前面/后面)i
- `u`/`n`实现 `PgUp`/`PgDn` (上一页/下一页)
- `d` 实现 `Shift` + `F10` （快速打开快捷菜单）
- `w` 实现 `Alt` + `F4`（关闭程序或关闭窗口）
- `e` 实现 `Esc`（取消）
- `r` 实现 `Ctrl` + `z`(撤回) 
- `p`实现`Backspace`（退格键）
- `v`实现`Shift`+`Insert`（粘贴）
- `c`实现`Shift`（进行多选等操作）
- `Space`实现`Ctrl`

## 单手模式
> `caps lock`+`Alt`+`f` 打开**单手模式**

- 使用 `q`/`e` 实现向**上**/**下**翻页
- 使用 `w`/`s`/`a`/`d` 实现**上**/**下**/**左**/**右**

<!-- ## 想法
- 实现大众化
- 图形化界面
- 能简单自定义热键功能 -->

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
- [rcmdnk/vim_ahk：使用自动热键设置文件以模拟 vim (github.com)](https://github.com/rcmdnk/vim_ahk)
- [xiongyihui/keyboard: 解开键盘封印，释放生产力 (github.com)](https://github.com/xiongyihui/keyboard)
- [自用ahk热键脚本及相关回顾 - AutoHotkey Community](https://www.autohotkey.com/boards/viewtopic.php?f=28&t=85872&p=377029&hilit=%E7%83%AD%E9%94%AE%E8%BF%9E%E7%BB%AD%E6%8C%89%E4%BC%9A%E8%AF%AF%E8%A7%A6#p377029)
- [AutoHotkey/AutoHotkey: AutoHotkey - macro-creation and automation-oriented scripting utility for Windows. (github.com)](https://github.com/AutoHotkey/AutoHotkey)
- [rcmdnk/vim_ahk: Setting file to emulate vim with AutoHotkey (github.com)](https://github.com/rcmdnk/vim_ahk)