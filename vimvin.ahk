#Requires AutoHotkey v2.0

#include config.ahk
#include WindowTracker.ahk
#include UI.ahk

activeModule := ""

; MODULES:
#include "%A_ScriptDir%\modules\Notepad.ahk"
#include "%A_ScriptDir%\modules\Calculator.ahk"


; DEBUG
if (debugMode) {
	KeyHistory
}

#x:: ExitApp

SetTimer UpdateActiveModule, 100
UpdateActiveModule() {
	if WinActive("ahk_class Notepad") && notepad{
		global activeModule := "Notepad"
	}
}

SetMode(new_mode) {
	global mode := new_mode
	UILastLineUpdate()					; TODO: Make general UI update function
	}
