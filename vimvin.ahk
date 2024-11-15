#Requires AutoHotkey v2.0

#include config.ahk
#include WindowTracker.ahk
#include UI.ahk

; MODULES:
if (notepad == 1)
	#include "%A_ScriptDir%\modules\Notepad.ahk"

; MsgBox "Velcome to Vicki's Vimified Vindows`n`Press Win+x to gtfo"

; DEBUG
if (debugMode) {
	KeyHistory
}


SetMode(new_mode) {
	global mode := new_mode
	UIModeBarUpdate()					; TODO: Make general UI update function
	}

; ################
; ##	GENERAL	##
; ################

#x:: ExitApp
