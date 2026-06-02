#Requires AutoHotkey v2.0
#SingleInstance Force
ListLines False
KeyHistory 0
ProcessSetPriority "High"

; -----------------------------------------------------------------------------
; CONFIGURATION
; -----------------------------------------------------------------------------
; Update this path to your folder containing the .jpg files
global WallpaperDir := "C:\Users\skyle\AppData\Config\wallpapers\" 
global Wallpapers := []
global CurrentIndex := 0

; Scan directory and cache image paths in memory to avoid costly runtime disk I/O
Loop Files, WallpaperDir "\*.jpg" {
    Wallpapers.Push(A_LoopFileFullPath)
}

; Fallback if folder is empty or path is incorrect
if (Wallpapers.Length == 0) {
    MsgBox("No .jpg files found in: " WallpaperDir, "Wallpaper Cycler Error", 0x10)
    ExitApp()
}

; -----------------------------------------------------------------------------
; HOTKEY DEFINITION: Win + \  (# is Win, \ is \)
; -----------------------------------------------------------------------------
#\:: {
    global CurrentIndex, Wallpapers
    
    ; Increment index and wrap around cleanly (modulo math)
    CurrentIndex := Mod(CurrentIndex, Wallpapers.Length) + 1
    targetWallpaper := Wallpapers[CurrentIndex]
    
    ; Direct Win32 API call: SPI_SETDESKWALLPAPER = 0x0014
    ; SPIF_UPDATEINIFILE (0x01) | SPIF_SENDCHANGE (0x02) = 0x03 to write changes and update DWM instantly
    DllCall("user32\SystemParametersInfoW", 
        "UInt", 0x0014, 
        "UInt", 0, 
        "Str", targetWallpaper, 
        "UInt", 3
    )
}