#Requires AutoHotkey v2.0

; Used to circumvent tooltip limit

GetButtons() {
	
	controls := WinGetControls("A")
	; Chunk control array to length 20 chunks for tooltips
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

SpawnTooltips(controlArray) {
	for ccontrol in controlArray {
		ControlGetPos &X, &Y, &W, &H, ccontrol
		ToolTip ccontrol, X, Y, A_Index
	}
}