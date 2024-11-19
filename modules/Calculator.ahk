#Requires AutoHotkey v2.0

#HotIf WinActive("ahk_class CalcFrame")

a:: Send '1'
s:: Send '2'
d:: Send '3'
f:: Send '4'
g:: Send '5'
h:: Send '6'
j:: Send '7'
k:: Send '8'
l:: Send '9'
`;::  Send '0'

e:: Send '('
o:: Send ')'
r:: Send '{NumpadAdd}'
t:: Send '{NumpadMult}'
u:: Send '{NumpadDiv}'
i:: Send '{NumpadSub}'

Space:: Send '{Delete}'				; CE
+Space:: Send '{Escape}'			; C

+f:: GetButtons()

#HotIf

; Limited to 20 tooltips
; TODO: Workaround: Chunk control array and send to subroutines
GetButtons() {
	
	controls := WinGetControls("A")
	
	; Filter for buttons:
	controlsTmp := Array()
	for dings in controls {
		if (InStr(dings, "Button")) {
			controlsTmp.Push(controls[A_Index])
		}
	}
	controls := controlsTmp
	
	; Chunk control array to length 20 chunks for tooltips:
	chunkCount := Mod(controls.Length, 20) == 0 ? controls.Length / 20 : Ceil(controls.Length / 20)
	MsgBox "Chunk count: " . chunkCount
	Loop chunkCount {
		chunkSize := A_Index == chunkCount ? Mod(controls.Length, 20) : 20
		i := A_Index
		global controlArrayArray := Array()
		arrayChunk := Array()
		Loop chunkSize {
			superIndex := i*20-20 + A_Index
			arrayChunk.Push(controls[superIndex])
		}
		SpawnTooltips(arrayChunk)
	}
}

; Tooltip subroutine to bypass 20 tooltip limit
SpawnTooltips(controlArray) {
	for ccontrol in controlArray {
		ControlGetPos &X, &Y, &W, &H, ccontrol
		ToolTip ccontrol, X, Y, A_Index
	}
}