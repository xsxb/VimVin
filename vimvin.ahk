#Requires AutoHotkey v2.0

MsgBox "Velcome to Vicki's Vimified Vindows`n`Press Win+x to gtfo"

; Read config
;if (FileRead("C:\...

; DEBUG
; KeyHistory


; TODO:
; r - replace char
; R - replace until ESC
; gg - go to top of doc
; G - go to bottom of doc
; Ctrl + r - redo
; u - change to lower (visual)
; U - change to upper (visual)
; > - shift text right
; >> - tab
; <
; <<
;
; Execute n times:
; GetCount() {}							; Read [0-9] with KeybdHook into hotstring for executing n times
;


; INIT
WinGetPos &X, &Y, &W, &H, "A"
mode := "NORMAL"


; ############
; ##	UI	##
; ############

UI := Gui()
ModeBar := UI.Add("StatusBar",, " - " . mode . " - ")
UI.Opt("+AlwaysOnTop")
UI.Show("w400 x" . A_ScreenWidth - 400 . " y" . A_ScreenHeight - 100)

SetMode(new_mode) {
	global mode := new_mode
	ModeBar.SetText(" - " . mode . " - ")
	}

; ################
; ##	GENERAL	##
; ################

#x:: ExitApp


; ########################
; ##	 NORMAL Mode	##
; ########################

#HotIf mode == "NORMAL"
	; Mode switch
	v:: SetMode("VISUAL")
	i:: SetMode("INSERT")
	::: SetMode("COMMAND")

	; Motions
	h:: {
		Send '{LEFT}'
	}
	l:: {
		Send '{RIGHT}'
	}
	j:: {
		Send '{DOWN}'
	}
	k:: {
		Send '{UP}'
	}
	_:: {
		Send '{Home}'
	}
	$:: {
		Send '{End}'
	}
	e:: {
		Send '^{RIGHT}{LEFT}'
	}
	b:: {
		Send '^{LEFT}'
	}
	w:: {
		Send '^{RIGHT}'
	}


	+i:: {
		Send '{Home}'
		SetMode("INSERT")
	}
	
	+a:: {
		Send '{End}'
		SetMode("INSERT")
	}
	
	o:: {
		Send '{End}'
		Send Chr(10)
		SetMode("INSERT")
	}
	+o:: {
		Send '{Home}'
		Send Chr(10)
		SetMode("INSERT")
	}
	
	u:: {
		Send "^z"
	}
	
	q:: {
	}
	
#HotIf


; ########################
; ##		 Edit		##
; ########################


#HotIf mode == "NORMAL" OR mode == "VISUAL" 				; || "VISUAL-LINE" || "VISUAL-BLOCK"
	d:: {
		if (A_PriorHotkey != A_ThisHotkey) {				; d
			Send "^x"
		}
		if (A_PriorHotkey == A_ThisHotkey) {				; dd
			Send '{Home}+{End}^x{Backspace}{Home}'
		}
	}
	+d:: {
		Send "^{Delete}"
	}
	y:: {													; y
		if(A_PriorHotkey != A_ThisHotkey) {
			Send "^c"
		}
		else {												; yy
			Send '{Home}+{End}^c'
		}	
	}
	p:: {
		Send "^v"
	}
	+p:: {
		Send '{Home}'
		Send Chr(10)
		Send "{UP}^{v}"
	}
	x:: {
		Send '{Delete}'
	}
	
#HotIf


; ########################
; ##	 INSERT Mode	##
; ########################

#HotIf mode == "INSERT"

	ESCAPE:: SetMode("NORMAL")
	
#HotIf


; ########################
; ##	 VISUAL Mode	##
; ########################

#HotIf mode == "VISUAL"
	; Escape to NORMAL mode
	ESCAPE:: SetMode("NORMAL")
	i:: SetMode("INSERT")

	; Motions
	h:: {
		Send '{SHIFT}+{LEFT}'
	}
	l:: {
		Send '{SHIFT}+{RIGHT}'
	}
	j:: {
		Send '{SHIFT}+{DOWN}'
	}
	k:: {
		Send '{SHIFT}+{UP}'
	}
	e:: {
		Send '^{RIGHT}{LEFT}'
	}
	b:: {
		Send '^{LEFT}'
	}
	
#HotIf


; ########################
; ##	COMMAND Mode	##
; ########################

#HotIf mode == 'COMMAND'
ESCAPE:: SetMode("NORMAL")
#HotIf