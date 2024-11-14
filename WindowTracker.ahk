#Requires AutoHotkey v2.0

class WindowObj extends Object {
	winID := 0
	winClass := ""
	
	caretOffset := 0
	caretScale := 1
	
	winPosX := 0
	winPosY := 0
	winWidth :=0
	winHeight := 0
	
	GetCaretOffset() {
	}
	GetCaretScale() {
	}
	
	__New() {
	; GetCaretOffset()
	; GetCaretScale()
	}
	
}


caretPosX := 0 ; move to WindowObj
caretPosY := 0 ; move to WindowObj
aWindowString := "Window: " ; move to WindowObj
activeWindowClass := "" ; move to WindowObj

activeWindowID := 0

caretString := caretPosY . ", " . caretPosX
mode := "NORMAL"

testWindowObj0 := WindowObj()
testWindowObj1 := WindowObj()

testWindowArray := Array(testWindowObj0, testWindowObj1)

; INIT
WinGetPos &X, &Y, &W, &H, "A"

allTheWindowIDs := WinGetList()
winIDstring := ""
for winID in allTheWindowIDs {
	winClass := WinGetClass("ahk_id " . winID)
	winIDstring := winIDstring . " " . winClass
}

; MsgBox "Found windows: " .  winIDstring