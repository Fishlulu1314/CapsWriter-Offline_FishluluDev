#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

;宏定义
sleepTime := 500 ;提示窗口显示时间
;CapsLock键语音输入执行程序所在目录
CapsWriterRootPath := "D:\others\utils\CapsWriter-Offline-Windows-64bit\"

;Alt+Shift+1 启动capslock语音输入(后台执行bat脚本)
;如果bat已经执行，再次执行时会关闭(通过running_flag文件判断)
!+1::
{
    ; 启动脚本路径
    StartScript := CapsWriterRootPath . "CapWriterStart.bat"
    ; 关闭脚本路径
    CloseScript := CapsWriterRootPath . "CapWriterClose.bat"
    ; 判断运行标志文件路径
    RunningFlag := CapsWriterRootPath . "running.flag"

    ; 判断是否存在运行标志文件
    IfExist, %RunningFlag%
    {
        ; 如果存在运行标志文件，说明程序已经在运行中,给出提示是否关闭
        MsgBox, 36,, CapsWriter 正在运行中。是否关闭？
        IfMsgBox Yes
        {
            ; 如果选择关闭，执行关闭脚本
            RunWait, %CloseScript%, , Hide
            ShowTimedMessage("CapsWriter 关闭", sleepTime)
        }
        Else
        {
            ; 如果选择取消，直接返回
            Return
        }
    }
    else
    {
        ; 如果不存在，启动 CapsLock 语音输入
        Run, %StartScript%, , Hide
        ShowTimedMessage("CapsWriter 启动", sleepTime)
    }
    Return
}

; 函数：显示带定时关闭的提示窗口
ShowTimedMessage(message, sleepTime) {
    ; 创建一个新的 GUI 窗口
    Gui, TimedMessage:Add, Text,, %message%
    Gui, TimedMessage:+toolwindow
    
    ; 显示 GUI 窗口
    Gui, TimedMessage:Show
    
    ; 等待指定的时间后关闭 GUI 窗口
    Sleep, %sleepTime%
    
    ; 关闭 GUI 窗口
    Gui, TimedMessage:Destroy
}