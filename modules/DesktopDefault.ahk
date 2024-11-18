#Requires AutoHotkey v2.0

; Module for Windows Desktop
; Work in progress and unused


; ########################
; ##	 NORMAL Mode	##
; ########################

#HotIf mode == "NORMAL"
	; Mode switch
	v:: SetMode("VISUAL")
	i:: SetMode("INSERT")
	::: SetMode("COMMAND")

	; Motions
	h:: Send '{LEFT}'
	l:: Send '{RIGHT}'
	j:: Send '{DOWN}'
	k:: Send '{UP}'
	_:: Send '{Home}'
	$:: Send '{End}'
	e:: Send '^{RIGHT}{LEFT}'
	b:: Send '^{LEFT}'
	w:: Send '^{RIGHT}'
	g:: {
		if (A_PriorHotkey == A_ThisHotkey) {	;	gg
		Send '^{Home}'
		}
	}	
	+g:: Send '^{End}'
	[::return
	]::return
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
	
	u:: Send "^z"
	
	>:: {
		if (A_PriorHotkey == A_ThisHotkey) {				; >>
			Send '{Home}{Tab}'
		}
	}
	
	+l::return					; L - end of page
	q::return						; q - record macro
	+q::return
	+k::return					; K - get manual entry
	+j::return					; J - concatenate lines
	r::return					; r - replace character
	+r::return					; R - replace until ESC
	+t::return
	t::return
	m::return
	+m::return
	{::return					; - jump to end of paragraph
	}::return					; - jump to start of paragraph
	.::return
	,::return
	`;::return
	/::return					; Search forward
	?::return					; Search backward
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


#HotIf mode == "NORMAL" OR mode == "VISUAL" 				; || "VISUAL-LINE" || "VISUAL-BLOCK"
	d:: {
		if (A_PriorHotkey != A_ThisHotkey) {				; d
			Send "^x"
		}
		if (A_PriorHotkey == A_ThisHotkey) {				; dd
			Send '{Home}+{End}^x{Backspace}{Home}'
		}
	}
	+d:: Send "^{Delete}"
	y:: {													; y
		if(A_PriorHotkey != A_ThisHotkey) {
			Send "^c"
		}
		else {												; yy
			Send '{Home}+{End}^c'
		}	
	}
	p:: Send "^v"
	+p:: {
		Send '{Home}'
		Send Chr(10)
		Send "{UP}^{v}"
	}
	x:: Send '{Delete}'
	
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

	ESCAPE:: SetMode("NORMAL")
	i:: SetMode("INSERT")

	; Motions
	h:: Send '{SHIFT}+{LEFT}'
	l:: Send '{SHIFT}+{RIGHT}'
	j:: Send '{SHIFT}+{DOWN}'
	k:: Send '{SHIFT}+{UP}'
	e:: Send '^{RIGHT}{LEFT}'
	b:: Send '^{LEFT}'
	
#HotIf


; ########################
; ##	COMMAND Mode	##
; ########################

#HotIf mode == 'COMMAND'

	ESCAPE:: SetMode("NORMAL")
	

#HotIf