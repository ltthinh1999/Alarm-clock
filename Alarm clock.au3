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

MainGUI()

Func MainGUI()
	Global $MainGUI, $CurrentTime, $setH, $setM

	$MainGUI = GUICreate("Alarm clock", 477, 110, 444, 141)
	GUICtrlCreateLabel("Current time: ", 2, 10)
	Global $CurrentHour = GUICtrlCreateLabel(@HOUR, 65, 10)
	GUICtrlCreateLabel(":", 78, 10)
	Global $CurrentMin = GUICtrlCreateLabel(@MIN, 81, 10)
	GUICtrlCreateLabel(":", 94, 10)
	Global $CurrentSec = GUICtrlCreateLabel(@SEC, 97, 10)
	Global $SetButton = GUICtrlCreateButton("Set alarm", 404, 10, 60, 40)
	GUICtrlCreateLabel("Wake me up at: ", 2, 37)
	GUICtrlCreateLabel(" : ", 116, 37)

	Global $SetHour = GUICtrlCreateCombo("0", 80, 35, 37, 30, $CBS_DROPDOWNLIST + $WS_VSCROLL)
	_GUICtrlComboBoxEx_BeginUpdate($SetHour)
	For $i = 0 To 23 Step 1
		GUICtrlSetData($SetHour, $i)
	Next
	_GUICtrlComboBoxEx_EndUpdate($SetHour)

	Global $SetMin = GUICtrlCreateCombo("0", 124, 35, 37, 30, $CBS_DROPDOWNLIST + $WS_VSCROLL)
	_GUICtrlComboBoxEx_BeginUpdate($SetMin)
	For $j = 0 To 59 Step 1
		GUICtrlSetData($SetMin, $j)
	Next
	_GUICtrlComboBoxEx_EndUpdate($SetMin)

	GUISetState(@SW_SHOW, $MainGUI)

	MainState()

EndFunc

Func MainState()   ; Normal state, nothing set up yet
	While 1
		UpdateTime()
		$msg = GUIGetMsg()
		Select
			Case $msg = $GUI_EVENT_CLOSE
				Exit
			Case $msg = $SetButton
				$setH = Int(GUICtrlRead($SetHour))
				$setM = Int(GUICtrlRead($SetMin))
				GUICtrlSetState($SetHour, $GUI_DISABLE)
				GUICtrlSetState($SetMin, $GUI_DISABLE)
				GUICtrlSetState($SetButton, $GUI_DISABLE)
				Global $CancelAlarm = GUICtrlCreateButton("Cancel alarm", 400, 60)
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
	$Alarm = "Alarm.wav"
	DllCall( "winmm.dll", "int", "mciExecute", "str", "play " & $Alarm)

	GUICtrlDelete($CancelAlarm)
	GUICtrlSetState($SetHour, $GUI_ENABLE)
	GUICtrlSetState($SetMin, $GUI_ENABLE)
	GUICtrlSetState($SetButton, $GUI_ENABLE)
	MainState()
EndFunc




