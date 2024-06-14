; 状态标记和管理
global capslock := false
global c_one_hand := false
global c_v_down := false
global c_s_down := false
global c_f_down := false
global c_app := false
global stime := false
global single := 0

; 状态检测逻辑优化，确保每个状态的更新都是必要且有效的
; 这里省略了具体的状态更新逻辑，建议检查相关函数和操作，以确保状态管理尽可能高效

; 根据需要引入外部状态脚本
; 仅在确实需要时使用#include，避免不必要的依赖
