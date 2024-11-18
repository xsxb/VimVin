#Requires AutoHotkey v2.0

; ############
; ##	UI	##
; ############

editPosX := 0
editPosY := 0

editPosString := ""
caretString := ""

UI := Gui()
LastLine := UI.Add("StatusBar",,) ; " - " . mode . " - " . caretString)
; LastLine.OnEvent("Close", VimVinClose())
UILastLineUpdate()
UI.Opt("+AlwaysOnTop")
UI.Show("w400 x" . A_ScreenWidth - 400 . " y" . A_ScreenHeight - 100)


; To be moved to WindowObj class
UIUpdateCaret(x, y) {
	global caretString := caretPosY . ", " . caretPosX
	UILastLineUpdate()
}

SetTimer UILastLineUpdate, 100
UILastLineUpdate() {
	if (lastLinePos == "WindowBottom") {
		UIMoveToActiveWindow
	}
	editPosString := editPosY . " : " . editPosX
	LastLine.SetText(" - " . mode . " - " . caretString . " " . aWindowString . " " . editPosString)
}

UIMoveToActiveWindow() {
	global activeWindowID := WinExist("A")
	global activeWindowClass := WinGetClass("A")
	global aWindowString := "Window: " . activeWindowClass . " (" . activeWindowID . ")"
	WinGetPos &X, &Y, &W, &H, "A"
	UI.Move(X, Y + H + lastLineOffsetY, W)
	}

VimVinClose() {
	ExitApp
}