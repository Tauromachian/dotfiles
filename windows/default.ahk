#Requires AutoHotkey v2.0

; Path to the DLL, relative to the script
VDA_PATH := A_ScriptDir . "\VirtualDesktopAccessor.dll"
hVirtualDesktopAccessor := DllCall("LoadLibrary", "Str", VDA_PATH, "Ptr")

#1:: GoToDesktop(0)
#2:: GoToDesktop(1)
#3:: GoToDesktop(2)
#4:: GoToDesktop(3)
#5:: GoToDesktop(4)

#k:: {
    Send "!{Tab}"
}

FocusFirstWindow() {
    Loop 20 {
        windows := WinGetList()
        if windows.Length > 0 {
            WinActivate windows[1]
            break
        }
        Sleep 50
    }
}

GetForemostWindowIdOnDesktop(n) {
    ; winIDList contains a list of windows IDs ordered from the top to the bottom for each desktop.
    winIDList := WinGetList()

    for winID in winIDList {
        isWindowOnDesktop := DllCall("VirtualDesktopAccessor\IsWindowOnDesktopNumber", "Ptr", winID, "Int", n, "Int")
        ; Select the first (and foremost) window which is in the specified desktop.
        if (isWindowOnDesktop == 1) {
            return winID
        }
    }

    return -1
}

FocusTheForemostWindow(targetDesktop) {
    foremostWindowId := GetForemostWindowIdOnDesktop(targetDesktop)

    if foremostWindowId == -1 {
        return
    }

    WinActivate ("ahk_id" foremostWindowId)
}

GoToDesktop(index) {
    ; Fixes the issue of active windows in intermediate desktops capturing the switch shortcut and therefore delaying or stopping the switching sequence. This also fixes the flashing window button after switching in the taskbar. More info: https://github.com/pmb6tz/windows-desktop-switcher/pull/19
    WinActivate("ahk_class Shell_TrayWnd")

    DllCall("VirtualDesktopAccessor\GoToDesktopNumber", "Int", index)

    Sleep 50
    FocusTheForemostWindow(index)
}


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
