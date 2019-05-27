#cs ----------------------------------------------------------------------------

Simple alarm clock

Author: Thinh Le

April 2019

#ce ----------------------------------------------------------------------------

#include <WINAPI.au3>
#include <WinAPIMisc.au3>
#include <WindowsConstants.au3>
#include <Date.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <GuiComboBoxEx.au3>

Main()

Func Main()
	MainGUI()
	MainState()
EndFunc

Func MainGUI()
	Local $MainGUI = GUICreate("Alarm clock", 476, 110, 444, 141)
	GUICtrlCreateLabel("Current time: ", 5, 10)
	Global $CurrentHour = GUICtrlCreateLabel(@HOUR, 68, 10)
	GUICtrlCreateLabel(":", 80, 10)
	Global $CurrentMin = GUICtrlCreateLabel(@MIN, 84, 10)
	GUICtrlCreateLabel(":", 97, 10)
	Global $CurrentSec = GUICtrlCreateLabel(@SEC, 100, 10)
	Global $SetButton = GUICtrlCreateButton("Set alarm", 404, 10, 60, 40)
	GUICtrlCreateLabel("Wake me up at: ", 5, 37)
	GUICtrlCreateLabel(" : ", 119, 37)

	Global $SetHour = GUICtrlCreateCombo("0", 83, 35, 37, 30, $CBS_DROPDOWNLIST + $WS_VSCROLL)
	_GUICtrlComboBoxEx_BeginUpdate($SetHour)
	For $i = 0 To 23 Step 1
		GUICtrlSetData($SetHour, $i)
	Next
	_GUICtrlComboBoxEx_EndUpdate($SetHour)

	Global $SetMin = GUICtrlCreateCombo("0", 127, 35, 37, 30, $CBS_DROPDOWNLIST + $WS_VSCROLL)
	_GUICtrlComboBoxEx_BeginUpdate($SetMin)
	For $j = 0 To 59 Step 1
		GUICtrlSetData($SetMin, $j)
	Next
	_GUICtrlComboBoxEx_EndUpdate($SetMin)

	GUISetState(@SW_SHOW, $MainGUI)

EndFunc

Func MainState() ;	Normal state, nothing set up yet
	While 1
		UpdateTime()
		$msg = GUIGetMsg()
		Select
			Case $msg = $GUI_EVENT_CLOSE
				Exit

			Case $msg = $SetButton
				Global $CancelAlarm = GUICtrlCreateButton("Cancel alarm", 400, 60)

				WaitingState()
				AlarmState()
		EndSelect
	WEnd
EndFunc

Func UpdateTime()
	If GUICtrlRead($CurrentSec) <> @SEC Then
		GUICtrlSetData($CurrentSec, @SEC)
	EndIf

	If GUICtrlRead($CurrentMin) <> @MIN Then
		GUICtrlSetData($CurrentMin, @MIN)
	EndIf

	If GUICtrlRead($CurrentHour) <> @HOUR Then
		GUICtrlSetData($CurrentHour, @HOUR)
	EndIf
EndFunc

Func AlarmState()
	Local $Stop = GUICtrlCreateButton("Stop", 264, 65, 112, 30)
	Local $Snooze = GUICtrlCreateButton("Snooze", 100, 65, 112, 30)
	GUICtrlDelete($CancelAlarm)
	$Ringtone = "Ringtone.wav"
	$msg = GUIGetMsg()

	While $msg <> $Stop And $msg <> $Snooze
		UpdateTime()
		$msg = GUIGetMsg()

		;	Start playing ringtone
		DllCall("winmm.dll", "int", "mciExecute", "str", "play " & $Ringtone)
	WEnd

	Select
		Case $msg = $Stop
			;	Stop playing ringtone
			DllCall("winmm.dll", "int", "mciExecute", "str", "stop " & $Ringtone)

			GUICtrlDelete($Stop)
			GUICtrlDelete($Snooze)
			GUICtrlSetState($SetHour, $GUI_ENABLE)
			GUICtrlSetState($SetMin, $GUI_ENABLE)
			GUICtrlSetState($SetButton, $GUI_ENABLE)

		Case $msg = $Snooze
			Global $CancelAlarm = GUICtrlCreateButton("Cancel alarm", 400, 60)

			DllCall("winmm.dll", "int", "mciExecute", "str", "stop " & $Ringtone)
			GUICtrlDelete($Stop)
			GUICtrlDelete($Snooze)
			If @MIN + 5 > 59 Then
				If @HOUR + 1 > 23 Then
					GUICtrlSetData($SetHour, @HOUR - 23)
					GUICtrlSetData($SetMin, @MIN - 55)
				Else
					GUICtrlSetData($SetMin, @MIN - 55)
				EndIf
			Else
				GUICtrlSetData($SetMin, @MIN + 5)
			EndIf

			WaitingState()
			AlarmState()
	EndSelect
	MainState()
EndFunc

Func WaitingState()	;	Ends when current time reaches set up time
	$setH = Int(GUICtrlRead($SetHour))
	$setM = Int(GUICtrlRead($SetMin))
	GUICtrlSetState($SetHour, $GUI_DISABLE)
	GUICtrlSetState($SetMin, $GUI_DISABLE)
	GUICtrlSetState($SetButton, $GUI_DISABLE)

	While $setH <> @HOUR Or $setM <> @MIN
		UpdateTime()
		$msg = GUIGetMsg()
		Select
			Case $msg = $CancelAlarm
				GUICtrlSetState($SetHour, $GUI_ENABLE)
				GUICtrlSetState($SetMin, $GUI_ENABLE)
				GUICtrlSetState($SetButton, $GUI_ENABLE)
				GUICtrlDelete($CancelAlarm)
				MainState()
			Case $msg = $GUI_EVENT_CLOSE
				Exit
		EndSelect
	WEnd
EndFunc

