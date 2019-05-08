;~ #cs ----------------------------------------------------------------------------

;~ Simple alarm clock

;~ Author: Thinh Le

;~ April 2019

;~ #ce ----------------------------------------------------------------------------

;~ #include <WINAPI.au3>
;~ #include <WinAPIMisc.au3>
;~ #include <WindowsConstants.au3>
;~ #include <Date.au3>
;~ #include <GUIConstantsEx.au3>
;~ #include <MsgBoxConstants.au3>
;~ #include <GuiComboBoxEx.au3>

;~ MainGUI()

;~ Func MainGUI()
;~ 	Global $MainGUI, $CurrentTime, $setH, $setM

;~ 	$MainGUI = GUICreate("Alarm clock", 477, 110, 444, 141)
;~ 	GUICtrlCreateLabel("Current time: ", 2, 10)
;~ 	Global $CurrentHour = GUICtrlCreateLabel(@HOUR, 65, 10)
;~ 	GUICtrlCreateLabel(":", 78, 10)
;~ 	Global $CurrentMin = GUICtrlCreateLabel(@MIN, 81, 10)
;~ 	GUICtrlCreateLabel(":", 94, 10)
;~ 	Global $CurrentSec = GUICtrlCreateLabel(@SEC, 97, 10)
;~ 	Global $SetButton = GUICtrlCreateButton("Set alarm", 404, 10, 60, 40)
;~ 	GUICtrlCreateLabel("Wake me up at: ", 2, 37)
;~ 	GUICtrlCreateLabel(" : ", 116, 37)

;~ 	Global $SetHour = GUICtrlCreateCombo("0", 80, 35, 37, 30, $CBS_DROPDOWNLIST + $WS_VSCROLL)
;~ 	_GUICtrlComboBoxEx_BeginUpdate($SetHour)
;~ 	For $i = 0 To 23 Step 1
;~ 		GUICtrlSetData($SetHour, $i)
;~ 	Next
;~ 	_GUICtrlComboBoxEx_EndUpdate($SetHour)

;~ 	Global $SetMin = GUICtrlCreateCombo("0", 124, 35, 37, 30, $CBS_DROPDOWNLIST + $WS_VSCROLL)
;~ 	_GUICtrlComboBoxEx_BeginUpdate($SetMin)
;~ 	For $j = 0 To 59 Step 1
;~ 		GUICtrlSetData($SetMin, $j)
;~ 	Next
;~ 	_GUICtrlComboBoxEx_EndUpdate($SetMin)

;~ 	GUISetState(@SW_SHOW, $MainGUI)

;~ 	MainState()

;~ EndFunc

;~ Func MainState()   ; Normal state, nothing set up yet
;~ 	While 1
;~ 		UpdateTime()
;~ 		$setH = GUICtrlRead($SetHour)
;~ 		$setM = GUICtrlRead($SetMin)
;~ 		$msg = GUIGetMsg()
;~ 		Select
;~ 			Case $msg = $GUI_EVENT_CLOSE
;~ 				Exit
;~ 			Case $msg = $SetButton
;~ 				GUICtrlSetState($SetHour, $GUI_DISABLE)
;~ 				GUICtrlSetState($SetMin, $GUI_DISABLE)
;~ 				GUICtrlSetState($SetButton, $GUI_DISABLE)
;~ 				Global $CancelAlarm = GUICtrlCreateButton("Cancel alarm", 400, 60)
;~ 				While Int($setH) <> @HOUR Or Int($setM) <> @MIN
;~ 					UpdateTime()
;~ 					$msg = GUIGetMsg()
;~ 					Select
;~ 						Case $msg = $CancelAlarm
;~ 							GUICtrlSetState($SetHour, $GUI_ENABLE)
;~ 							GUICtrlSetState($SetMin, $GUI_ENABLE)
;~ 							GUICtrlSetState($SetButton, $GUI_ENABLE)
;~ 							GUICtrlDelete($CancelAlarm)
;~ 							MainState()
;~ 						Case $msg = $GUI_EVENT_CLOSE
;~ 							Exit
;~ 					EndSelect
;~ 				WEnd
;~ 				AlarmState()
;~ 		EndSelect
;~ 	WEnd
;~ EndFunc

;~ Func UpdateTime()
;~ 	If GUICtrlRead($CurrentSec) <> @SEC Then
;~ 		GUICtrlSetData($CurrentSec, @SEC)
;~ 	EndIf

;~ 	If GUICtrlRead($CurrentMin) <> @MIN Then
;~ 		GUICtrlSetData($CurrentMin, @MIN)
;~ 	EndIf

;~ 	If GUICtrlRead($CurrentHour) <> @HOUR Then
;~ 		GUICtrlSetData($CurrentHour, @HOUR)
;~ 	EndIf
;~ EndFunc

;~ Func AlarmState()
;~ 	Local Const $sAlarm = "C:\Users\letan\Desktop\Alarm-clock\Alarm.mp3"
;~ 	Local $dAlarm = FileRead($sAlarm)
;~ 	If @error Then
;~ 		MsgBox(0, "Error!", "Error!")
;~ 	EndIf

;~ 	Local $tAlarm = DllStructCreate('byte[' & BinaryLen($dAlarm) & ']')
;~ 	DllStructSetData($tAlarm, 1, $dAlarm)
;~ 	Local $pAlarm = DllStructGetPtr($tAlarm)
;~ 	_WinAPI_PlaySound($pAlarm, BitOR($SND_ASYNC, $SND_LOOP, $SND_MEMORY))



;~ 	GUICtrlDelete($CancelAlarm)
;~ 	GUICtrlSetState($SetHour, $GUI_ENABLE)
;~ 	GUICtrlSetState($SetMin, $GUI_ENABLE)
;~ 	GUICtrlSetState($SetButton, $GUI_ENABLE)
;~ 	MainState()
;~ EndFunc

#include <Sound.au3>
;open sound file
$sound = _SoundOpen(@WindowsDir & "\media\Windows XP Startup.wav", "Startup")
If @error = 2 Then
 MsgBox(0, "Error", "The file does not exist")
 Exit
ElseIf @error = 3 Then
 MsgBox(0, "Error", "The alias was invalid")
 Exit
ElseIf @extended <> 0 Then
 $extended = @extended ;assign because @extended will be set after DllCall
 $stText = DllStructCreate("char[128]")
 $errorstring = DllCall("winmm.dll", "short", "mciGetErrorStringA", "str", $extended, "ptr", DllStructGetPtr($stText), "int", 128)
 MsgBox(0, "Error", "The open failed." & @CRLF & "Error Number: " & $extended & @CRLF & "Error Description: " & DllStructGetData($stText, 1) & @CRLF & "Please Note: The sound may still play correctly.")
Else
 MsgBox(0, "Success", "The file opened successfully")
EndIf
_SoundPlay($sound, 1)

_SoundClose($sound)