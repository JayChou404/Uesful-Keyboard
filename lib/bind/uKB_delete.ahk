/************************************************************************
 * @description ----Delete
 * , = Del char after
 * . = Del word after
 * / = Del all  after
 * m = Del char before
 * n = Del word before
 * b = Del all  before
 * @file uKB_delete.ahk
 * @author 
 * @date 2023/06/07
 * @version 0.0.0
 ***********************************************************************/


CapsLock & ,:: Sd("{Del}")          ; , = Del char after
CapsLock & .:: Sd("^{Del}")         ; . = Del word after
; CapsLock & /:: Sd("+{End}{Del}")    ; / = Del all  after
CapsLock & m:: Sd("{BS}")           ; m = Del char before
CapsLock & n:: Sd("^{BS}")          ; n = Del word before
CapsLock & b:: Sd("+{Home}{Del}")   ; b = Del all  before