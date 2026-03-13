#Requires AutoHotkey v2.0

#Enter:: {
    Run "alacritty.exe"
}

#m:: {
    WinMaximize "A"
}

#+c:: {
    WinClose "A"
}

^!Up:: {
    Send "#{Tab}"
}

#1:: SwitchToDesktop(1)
#2:: SwitchToDesktop(2)
#3:: SwitchToDesktop(3)
#4:: SwitchToDesktop(4)
#5:: SwitchToDesktop(5)

SwitchToDesktop(n) {
    ; Send Win+Ctrl+Left/Right the correct number of times
    ; First, read current desktop from registry
    current := 1
    try {
        regVal := RegRead("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VirtualDesktops", "CurrentVirtualDesktop")
        allVal := RegRead("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VirtualDesktops", "VirtualDesktopIDs")
        ; Each desktop ID is 16 bytes
        total := StrLen(allVal) // 32  ; rough count
        Loop total {
            if (SubStr(allVal, (A_Index-1)*32+1, 32) = regVal) {
                current := A_Index
                break
            }
        }
    }
    
    ; Navigate left or right
    while (current < n) {
        Send("^#{Right}")
        current++
        Sleep(50)
    }
    while (current > n) {
        Send("^#{Left}")
        current--
        Sleep(50)
    }

    windows := WinGetList()
    if (windows.Length >= 1)
        WinActivate windows[1]
}

