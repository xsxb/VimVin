#Requires AutoHotkey v2.0

; ############
; ##	UI	##
; ############

UI := Gui()
ModeBar := UI.Add("StatusBar",,) ; " - " . mode . " - " . caretString)
; ModeBar.OnEvent("Close", VimVinClose())
UIModeBarUpdate()
UI.Opt("+AlwaysOnTop")
UI.Show("w400 x" . A_ScreenWidth - 400 . " y" . A_ScreenHeight - 100)

; To be moved to WindowObj class
UIUpdateCaret(x, y) {
	global caretString := caretPosY . ", " . caretPosX
	UIModeBarUpdate()
}

UIModeBarUpdate() {
	GetActiveWindow						; Function call to be moved
	ModeBar.SetText(" - " . mode . " - " . caretString . " " . aWindowString)
}

GetActiveWindow() {
	global activeWindowID := WinExist("A")
	global activeWindowClass := WinGetClass("A")
	global aWindowString := "Window: " . activeWindowClass . " (" . activeWindowID . ")"
}

VimVinClose() {
	ExitApp
}