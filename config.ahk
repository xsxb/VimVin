#Requires AutoHotkey v2.0

debugMode := 0
notepad := 1

lastLinePos := "BottomRight"	; ["WindowBottom", "BottomRight"]
lastLineOffsetY := -50
activeModuleUpdateTimer := 100

uiOn := 0					; not in use
uiUpdateTimer := 100		; not in use