#Requires AutoHotkey v2.0

; Path to the DLL, relative to the script
VDA_PATH := A_ScriptDir . "\VirtualDesktopAccessor.dll"
hVirtualDesktopAccessor := DllCall("LoadLibrary", "Str", VDA_PATH, "Ptr")

#1:: GoToDesktop(0)
#2:: GoToDesktop(1)
#3:: GoToDesktop(2)
#4:: GoToDesktop(3)
#5:: GoToDesktop(4)


FocusFirstWindow() {
    windows := WinGetList()
    if windows.Length > 0
        WinActivate windows[1]
}

GoToDesktop(index) {
    DllCall("VirtualDesktopAccessor\GoToDesktopNumber", "Int", index)

    FocusFirstWindow()
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
