#cs ----------------------------------------------------------------------------

Alarm clock.

Author; Thinh Le

April 2019

#ce ----------------------------------------------------------------------------

#include <Date.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <GuiComboBoxEx.au3>

MainGUI()

Func MainGUI()
	Global $MainGUI, $CurrentTime, $setH, $setM
	Local $idMsg = 0

	$MainGUI = GUICreate("Alarm clock", 477, 220, 444, 141)
	GUICtrlCreateLabel("Current time: ", 2, 10)
	Global $CurrentHour = GUICtrlCreateLabel(@HOUR, 65,10)
	GUICtrlCreateLabel(":", 78, 10)
	Global $CurrentMin = GUICtrlCreateLabel(@MIN, 81,10)
	GUICtrlCreateLabel(":", 94, 10)
	Global $CurrentSec = GUICtrlCreateLabel(@SEC, 97,10)
	$SetButton = GUICtrlCreateButton("Set Alarm", 410, 10, 60, 40)
	GUICtrlCreateLabel("Wake me up at: ", 2, 37)
	GUICtrlCreateLabel(" : ", 115, 37)

	Global $SetHour = GUICtrlCreateCombo("0", 80, 35, 35, 30)
	_GUICtrlComboBoxEx_BeginUpdate($SetHour)
	For $i = 0 To 23 Step 1
		GUICtrlSetData($SetHour, $i)
	Next
	_GUICtrlComboBoxEx_EndUpdate($SetHour)

	Global $SetMin = GUICtrlCreateCombo("0", 124, 35, 35, 30)
	_GUICtrlComboBoxEx_BeginUpdate($SetMin)
	For $j = 0 To 59 Step 1
		GUICtrlSetData($SetMin, $j)
	Next
	_GUICtrlComboBoxEx_EndUpdate($SetMin)

	GUISetState(@SW_SHOW, $MainGUI)

	While 1
		UpdateGUI()
		$setH = GUICtrlRead($SetHour)
		$setM = GUICtrlRead($SetMin)
		TimeCouting()
		$idMsg = GUIGetMsg()
		Select
			Case $idMsg = $GUI_EVENT_CLOSE
				ExitLoop
			Case $idMsg = $SetButton
;~ 				???
		EndSelect
	WEnd
EndFunc

Func TimeCouting()

EndFunc

Func UpdateGUI()
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