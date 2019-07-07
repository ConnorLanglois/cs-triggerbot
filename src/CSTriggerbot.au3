Local $team = 0

_Main()

Func _Main()
	_Init()
	_Run()
EndFunc

Func _Init()
	; AutoItSetOption('MouseCoordMode', 2)
	HotKeySet('{PAUSE}', '_Exit')
	HotKeySet('`', '_ChangeTeam')
	HotKeySet('f', '_MouseReset')
	MouseMove(960, 523, 0)
	MouseDown('primary')
EndFunc

Func _Run()
	Local $hWnd = WinWait('BlueStacks App Player', '', 5)
	Local $mouseOffset = 5
	Local $color
	Local $colorVariation
	Local $mouse
	Local $crosshair[2] = [960, 523]
	Local $fire
	Local $timer
	Local $nShots = 0

	While True
		$mouse = MouseGetPos()
		$color = $team = 0 ? 0x0000B5 : $team = 1 ? 0xB50000 : 0
		$colorVariation = $team = 0 ? 40 : $team = 1 ? 40 : 0

		If $mouse[0] < 680 Or $mouse[0] > @DesktopWidth - 75 Or $mouse[1] < 75 Or $mouse[1] > @DesktopHeight - 75 Then
			_MouseReset()
		EndIf

		ToolTip('    ' & ($team = 0 ? 'Blue' : $team = 1 ? 'Red' : 'None') & @CRLF & '    ' & $nShots, 0, 0, 'CS Triggerbot')

		$fire = PixelSearch($crosshair[0] - $mouseOffset, $crosshair[1] - $mouseOffset, $crosshair[0] + $mouseOffset, $crosshair[1] + $mouseOffset, $color, $colorVariation, 1, $hWnd)

		If $fire <> 0 Then
			; $mouse = MouseGetPos()

			; MouseMove($mouse[0] + ($fire[0] - $crosshair[0]), $mouse[1] + ($fire[1] - $crosshaier[1]), 0)
			; Send('ee')

			$nShots += 1

			Sleep(500)
		EndIf
	WEnd
EndFunc

Func _Run2()
	Local $hWnd = WinWait('BlueStacks App Player', '', 5)
	Local $mouseOffset = 50
	Local $color
	Local $colorVariation
	Local $mouse
	Local $fire
	Local $fireColor
	Local $isMouseRight

	While True
		$color = $team = 0 ? 0x6494B0 : $team = 1 ? 0xCD4448 : 0
		$colorVariation = $team = 0 ? 37 : $team = 1 ? 35 : 0
		$mouse = MouseGetPos()
		$fire = PixelSearch($mouse[0] - $mouseOffset, $mouse[1] - 5, $mouse[0] + $mouseOffset, $mouse[1] + 5, $color, $colorVariation, 1, $hWnd)

		If $fire <> 0 Then
			$fireColor = PixelGetColor($fire[0], $fire[1], $hWnd)

			While $fire <> 0
				$mouse = MouseGetPos()
				$isMouseRight = $mouse[0] >= $fire[0] ? True : False
				MouseMove($fire[0], $fire[1], 0)
				Sleep(50)

				If $isMouseRight Then
					MouseClick('primary', $mouse[0] - 4, $mouse[1] + 4, 1, 0)
				Else
					MouseClick('primary', $mouse[0] + 4, $mouse[1] + 4, 1, 0)
				EndIf

				$fire = PixelSearch($mouse[0] - $mouseOffset, $mouse[1] - 5, $mouse[0] + $mouseOffset, $mouse[1] + 5, $fireColor, 0, 1, $hWnd)

				Sleep(250)
			WEnd
		EndIf
	WEnd
EndFunc

Func _ChangeTeam()
	If $team = 1 Then
		$team = 0
	Else
		$team += 1
	EndIf
EndFunc

Func _MouseReset()
	MouseUp('primary')
	MouseMove(960, 523, 0)
	MouseDown('primary')
EndFunc

Func _Exit()
	Exit
EndFunc