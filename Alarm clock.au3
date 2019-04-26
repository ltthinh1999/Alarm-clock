#cs ----------------------------------------------------------------------------

Alarm clock.

Author; Thinh Le

April 2019

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <Date.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>


GUICreate("Alarm clock", 477, 220, 444, 141)
;MsgBox(0, "Test", "Current time: " & @SEC)
GUICtrlCreateLabel("Current time: " & _NowTime(5), 2, 10)
GUICtrlCreateButton("Set", 420, 10, 50, 50)
GUISetState()
Local $idMsg = 0
While 1
	$idMsg = GUIGetMsg()
	Select
		Case $idMsg = $GUI_EVENT_CLOSE
			MsgBox($MB_SYSTEMMODAL, "", "Dialog was closed")
			ExitLoop
		Case $idMsg = $GUI_EVENT_MINIMIZE

		Case $idMsg = $GUI_EVENT_MAXIMIZE
			MsgBox($MB_SYSTEMMODAL, "", "Dialog restored", 2)
	EndSelect
WEnd

;msgbox (0 ,"Alarm clock" ,"")

#cs
GUICreate ("72ls.NET" ,400 ,250 ,100 ,200)           ;Tạo Window

GUICtrlCreateLabel ("Họ Tên:" , 2 , 7 , 43 , 16)      ;Tạo Label
GUICtrlSetBkColor (-1 ,0xFF0000)                  ;Chọn màu nên cho Label

GUICtrlCreateInput ("Nội dung" , 50 , 7 , 72 , 20)     ;Tạo Input

GUICtrlCreateEdit ("" , 2 , 34 , 180 , 70)           ;Tạo Edit

GUICtrlCreateCheckbox ("Đẹp Trai" , 2 , 120)        ;Tạo checkbox để chọn
GUICtrlCreateCheckbox ("Học Giỏi" , 2 , 140)       ;Tạo checkbox để chọn
GUICtrlCreateCheckbox ("Lắm Tiền" , 2 , 160)       ;Tạo checkbox để chọn

GUICtrlCreateRadio ("Keo Kiệt " , 92 , 120)        ;Tạo Radio để chọn
GUICtrlCreateRadio ("Rộng Lượng " , 92 , 140)     ;Tạo Radio để chọn

GUICtrlCreateGroup ("" ,-99 , -99 , 1 , 1)           ;Tạo Group
GUICtrlCreateRadio ("Đã Có Bồ " , 92 , 170)           ;Tạo checkbox để chọn
GUICtrlCreateRadio ("Thất Tình " , 92 , 190)       ;Tạo checkbox để chọn
GUICtrlCreateGroup ("" , -99 , -99 , 1 , 1)          ;Đóng Group

GUICtrlCreateTab (200 , 7 , 150 ,190)               ;Tạo Tab nền
GUICtrlCreateTabItem ("List Control")            ;Tạo vùng Tab của List Control

GUICtrlCreateList ("Nhà Lầu" ,210 , 37 , 100 ,90)      ;Tạo List Control
GUICtrlSetData (-1 , "Xe Hơi|Hồ Bơi|Máy Bay")        ;Thêm dữ liệu vào ComboBox

GUICtrlCreateTabItem ("Combo Box")               ;Tạo vùng Tab của Combo Box

GUICtrlCreateCombo ("Nhà Lầu" ,210 , 37 , 100 ,90)   ;Tạo ComboBox
GUICtrlSetData (-1 , "Xe Hơi|Hồ Bơi|Máy Bay")        ;Thêm dữ liệu vào ComboBox

GUICtrlCreateTabItem ("")                        ;Đóng Tab Nền

GUICtrlCreateButton ("Nhập" ,20 ,190 ,52)         ;Tạo nút có chữ Nhập

$File=GUICtrlCreateMenu ("File")               ;Tạo Menu File
GUICtrlCreateMenuItem ("Open" ,$File)
GUICtrlCreateMenuItem ("Save" ,$File)
GUICtrlCreateMenuItem ("" ,$File)
GUICtrlCreateMenuItem ("Exit" ,$File)

GUICtrlCreateMenu ("Edit")               ;Tạo Menu Edit

GUISetState ()   ;Hàm để hiện GUI ra

MsgBox (0 ,"72ls.NET", '')            ;Tạm dùng để xem GUI
#ce