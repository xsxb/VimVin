#Requires AutoHotkey v2.0

; Module for Windows default Notepad

; TODO: Get EditControl properties


; Listening for any keystroke
; Doesn't register arrow keys
ih := InputHook("L1 M V")
ih.NotifyNonText := 1
ih.MinSendLevel := 0
AnyKeyListen:
	ih.Start()
	ih.Wait()
	if (ih.Input){
		;UpdateText()
		UpdatePos()
		Goto AnyKeyListen
	}

; SetTimer UpdateText, 100							; To be called once on editor open (and on keystroke?)
UpdateText() {
		if WinActive("ahk_class Notepad") {
		text := WinGetText()
		}											; Remember to free memory on window close
}

; SetTimer UpdatePos, 100
UpdatePos() {
	if WinActive("ahk_class Notepad") {
		controlsArray := WinGetControlsHwnd("A")
		if EditGetCurrentLine(controlsArray[1]) {
			global editPosY := EditGetCurrentLine(controlsArray[1])
			global editPosX := EditGetCurrentCol(controlsArray[1])		; Column doesn't update on shift marking
		}
	}
}

; SetTimer WatchCaret, 100
WatchCaret() {
    if CaretGetPos(&x, &y) {
		global caretPosX := x
		global caretPosY := y
		UIUpdateCaret(x, y)
        ToolTip "X" x " Y" y, x, y - 20		; Not my line, Y value doesn't make sense
		}
    else {
        ; ToolTip "No caret"
	}
}

~LButton:: UpdatePos()


; ########################
; ##	 NORMAL Mode	##
; ########################

#HotIf mode == "NORMAL" && WinActive("ahk_class Notepad")
	; Mode switch
	v:: SetMode("VISUAL")
	i:: SetMode("INSERT")
	::: SetMode("COMMAND")

	; Motions
	h:: {
		Send '{LEFT}'
		UpdatePos()
		}
	l:: { 
		Send '{RIGHT}'
		UpdatePos()
		}
	j:: {
		Send '{DOWN}'
		UpdatePos()
		}
	k:: {
		Send '{UP}'
		UpdatePos()
		}
	_:: {
		Send '{Home}'	
		UpdatePos()
		}
	$:: {
		Send '{End}'
		UpdatePos()
		}
	e:: {
		Send '^{RIGHT}{LEFT}'					; when followed by space ; TODO: end of line
		UpdatePos()
		}
	b:: {
		Send '^{LEFT}'
		UpdatePos()
		}
	w:: {
		Send '^{RIGHT}'
		UpdatePos()
		}
	g:: {
		if (A_PriorHotkey == A_ThisHotkey) {	;	gg
		Send '^{Home}'
		UpdatePos()
		}
	}	
	+g:: {
	Send '^{End}'
	UpdatePos()
	}
	[::return
	]::return
	+i:: {
		Send '{Home}'
		SetMode("INSERT")
		UpdatePos()
		}
	+a:: {
		Send '{End}'
		SetMode("INSERT")
		UpdatePos()
		}	
	o:: {
		Send '{End}'
		Send Chr(10)
		SetMode("INSERT")
		UpdatePos()
		}
	+o:: {
		Send '{Home}'
		Send Chr(10)
		SetMode("INSERT")
		UpdatePos()
		}
	
	u:: {
		Send "^z"
		UpdatePos()
		}
	
	Backspace:: Send '{LEFT}'
	
	>:: {
		if (A_PriorHotkey == A_ThisHotkey) {				; >>
			Send '{Home}{Tab}'
			UpdatePos()
			}
		}
	
	; Unbinds/TODO
	+l::return					; L - end of page
	q::return						; q - record macro
	+q::return
	+k::return					; K - get manual entry
	+j::return					; J - concatenate lines
	r::return					; r - replace character
	+r::return					; R - replace until ESC
	+t::return
	t::return
	s::return
	f::return
	m::return
	+m::return
	{::return					; - jump to end of paragraph
	}::return					; - jump to start of paragraph
	.::return
	,::return
	`;::return
	/:: Send '^f'				; TODO: Set search forward
	?:: Send '^f'				; TODO: Set search backward
	0::return
	1::return
	2::return
	3::return
	4::return
	5::return
	6::return
	7::return
	8::return
	9::return
	!::return
	#::return
	%::return
	^::return
	&::return
	*::return
	(::return
	)::return
	Space::return
	
#HotIf



; ############################
; ##	NORMAL + VISUAL		##
; ############################


#HotIf mode == "NORMAL" && WinActive("ahk_class Notepad") || mode == "VISUAL" && WinActive("ahk_class Notepad")				; || "VISUAL-LINE" || "VISUAL-BLOCK"
	d:: {
		if (A_PriorHotkey != A_ThisHotkey) {				; d
			Send "^x"
			UpdatePos()
		}
		if (A_PriorHotkey == A_ThisHotkey) {				; dd
			Send '{Home}+{End}^x{Backspace}{Home}'
			UpdatePos()
		}
	}
	+d:: Send "^{Delete}"
	y:: {													; y
		if(A_PriorHotkey != A_ThisHotkey) {
			Send "^c"
			UpdatePos()
		}
		else {												; yy
			Send '{Home}+{End}^c'
			UpdatePos()
		}	
	}
	p:: {
	Send "^v"
	UpdatePos()
	}
	+p:: {
		Send '{Home}'
		Send Chr(10)
		Send "{UP}^{v}"
		UpdatePos()
	}
	x:: {
	Send '{Delete}'
	UpdatePos()
	}
	
#HotIf


; ########################
; ##	 INSERT Mode	##
; ########################

#HotIf mode == "INSERT" && WinActive("ahk_class Notepad")

	ESCAPE:: SetMode("NORMAL")
	
#HotIf


; ########################
; ##	 VISUAL Mode	##
; ########################

#HotIf mode == "VISUAL" && WinActive("ahk_class Notepad")

	ESCAPE:: SetMode("NORMAL")
	i:: SetMode("INSERT")

	; Motions
	h:: { 
		Send '{SHIFT}+{LEFT}'
		UpdatePos()
		}
	l:: {
		Send '{SHIFT}+{RIGHT}'
		UpdatePos()
		}
	j:: {
		Send '{SHIFT}+{DOWN}'
		UpdatePos()
		}
	k:: {
		Send '{SHIFT}+{UP}'
		UpdatePos()
		}
	e:: {
		Send '^{RIGHT}{LEFT}'
		UpdatePos()
		}
	b:: {
		Send '^{LEFT}'
		UpdatePos()
		}
		
#HotIf


; ########################
; ##	COMMAND Mode	##
; ########################

#HotIf mode == 'COMMAND' && WinActive("ahk_class Notepad")

	ESCAPE:: SetMode("NORMAL")
	

#HotIf