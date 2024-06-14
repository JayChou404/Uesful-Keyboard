#Requires AutoHotkey v2.0

; {定义窗口组
; Edit window mothods.
GroupAdd "edit", "ahk_exe Code.exe" ; VisCode
GroupAdd "edit", "ahk_exe idea64.exe" ; IntelliJ Idea
GroupAdd "edit", "ahk_exe pycharm64.exe" ; PyCharm
GroupAdd "edit", "ahk_exe Obsidian.exe" ; Obsidian文本编辑器

; Board window mode.
GroupAdd "board", "ahk_exe Xmind.exe"  ; 图片浏览器

; Clike window mode.
GroupAdd "oneButton", "ahk_id 25887856" ; 资源管理器

; English mode.
GroupAdd "English", "ahk_class ShImgVw:CPreviewWnd"  ; 图片浏览器
; }