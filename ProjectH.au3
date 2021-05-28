#include<GuiConstantsEx.au3>
#include<StaticConstants.au3>
#include<WindowsConstants.au3>
#include<FileConstants.au3>
#include<InetConstants.au3>
#include<File.au3>
#include<Inet.au3>
#include<ColorConstants.au3>
#include<EditConstants.au3>
#include<StringConstants.au3>
#include<FontConstants.au3>
#include <GuiListView.au3>
#include<Date.au3>
#include <MsgBoxConstants.au3>
#include <DateTimeConstants.au3>



Global $k
Global $Starting = False
$CollectStart = False

If FileExists(@TEMPDIR & "\DateProjectH\Dates.txt") = False then
   _FileCreate(@TEMPDIR & "\DateProjectH\Dates.txt")
   $oopp = FileOpen(@TEMPDIR & "\DateProjectH\Dates.txt", 1)
	  FileWrite($oopp,_NowDate() & "=0")
	  FileClose($oopp)
EndIf



If FileExists(@DESKTOPDIR & "\projectH\") = False then
   _FileCreate(@DESKTOPDIR & "\projectH\")
EndIf

$Gui = GuiCreate("Collect", 400, 200)
GuiCtrlCreateTab(0, 0, 420, 400)


;COLLECT //////////////////////////////////////////////////////////
GuiCtrlCreateTabItem("Collect")
GuiCtrlCreateLabel("", 0, 22, 400, 200)
GuiCtrlSetBkColor(-1, 0xE0E0E0)
GuiCtrlSetState(-1, $GUI_DISABLE)

$Category = GuiCtrlCreateInput("Exemple : super", 95, 40, 250, 20)
GuiCtrlSetColor(-1, $COLOR_GRAY)
GuiCtrlSetFont(-1, 8)
GuiCtrlCreateLabel("Category", 25, 42)


$SubCategory = GuiCtrlCreateInput("Example : abarrotes", 95, 70, 250, 20)
GuiCtrlSetColor(-1, $COLOR_GRAY)
GuiCtrlSetFont(-1, 8)
GuiCtrlCreateLabel("SubCategory", 25, 73)

GuiCtrlCreateLabel("Don't write the link, just write the name of category and subcategory.", 15, 170, 400)
GuiCtrlSetColor(-1, $COLOR_RED)
GuiCtrlSetFont(-1, -1, "", "", "MV Boli")

$Start = GuiCtrlCreateButton("Start", 117, 113, 100, 40)
GuiCtrlSetOnEvent($start, "start")

$Pause = GuiCtrlCreateButton("Pause", 218, 113, 100, 40)
GuiCtrlSetState(-1, $GUI_DISABLE)
GuiCtrlSetOnEvent($pause, "Pause")


$LabelCol = GuiCtrlCreateLabel("0", 367, 30, 40, 40)
GuiCtrlSetColor(-1, $COLOR_RED)
GuiCtrlSetFont(-1, 8)

$LastRun = GuiCtrlCreateLabel("Last run : " , 135, 24, 220, 40)
GuiCtrlSetColor(-1, $COLOR_BLACK)
GuiCtrlSetFont(-1, 8)

if fileexists(@TEMPDIR & "\projectHLastDate.txt") = true Then
   $pokem = FileOpen(@TEMPDIR & "\projectHLastDate.txt")
   $rito = fileread($pokem)
   fileclose($pokem)
   GuiCtrlSetData($LastRun, "Last run : " & $rito)
EndIf

$Refresh = GuiCtrlCreateButton("Refresh", 265, 92, 81, 20)
$change = GuiCtrlCreateButton("Change", 93, 92, 65, 20)



$ipp = GuiCtrlCreateLabel(" (IP) : Loading ..", 162, 94, 100, 18)
GuiCtrlSetColor(-1, $COLOR_BLUE)
GuiCtrlSetFont(-1, 8)


;ADD ////////////////////////////////////////////////////////////
GuiCtrlCreateTabItem("Add Time")
GuiCtrlCreateLabel("", 0, 22, 400, 200)
GuiCtrlSetBkColor(-1, 0xE0E0E0)
GuiCtrlSetState(-1, $GUI_DISABLE)

$List = GuiCtrlCreateListView("                Time                  ", 80, 35, 150, 100)
$ComboH = GuiCtrlCreateCombo("", 15, 38, 60)
GuiCtrlSetData(-1, "00|01|02|03|04|05|06|07|08|09|10|11|12|13|14|15|16|17|18|19|20|21|22|23")

GuiCtrlCreateLabel("Hour", 31, 25)
GuiCtrlSetColor(-1, $COLOR_GRAY)

$ComboM = GuiCtrlCreateCombo("", 15, 83, 60)
For $olio = 1 to 59  ;128
 GuiCtrlSetData($ComboM, $olio)
Next

GuiCtrlCreateLabel("Min", 31, 70)
GuiCtrlSetColor(-1, $COLOR_GRAY)

;_DateTimeFormat
$ComboD = GuiCtrlCreateDate( "01/08/2016", 15, 128, 60, $DTS_SHORTDATEFORMAT)
$sStyle = "dd/MM/yyyy"
GUICtrlSendMsg($ComboD, $DTM_SETFORMATW, 0, $sStyle)

GuiCtrlCreateLabel("Date", 31, 113)
GuiCtrlSetColor(-1, $COLOR_GRAY)



$add = GuiCtrlCreateButton("Add", 15, 155, 210)
$OpenData = GuiCtrlCreateButton("Open Data", 235, 35, 160, 150)

If FileExists(@DESKTOPDIR & "\ProjectHTime.txt") = TRUE Then
   $topkajLine = _FileCountLines(@DESKTOPDIR & "\ProjectHTime.txt")
   $opkaj = FileOpen(@DESKTOPDIR & "\ProjectHTime.txt")
   For $ipkaj = 1 to $topkajLine
   $topkaj = FileReadLine($opkaj, $ipkaj)

   _GuiCtrlListView_AddItem($list, $topkaj)
Next
FileClose(@DESKTOPDIR & "\ProjectHTime.txt")

EndIf

;NUMBER /////////////////////////////////////////////////////////
GuiCtrlCreateTabItem("Date")
GuiCtrlCreateLabel("", 0, 22, 400, 200)
GuiCtrlSetBkColor(-1, 0xE0E0E0)
GuiCtrlSetState(-1, $GUI_DISABLE)
$List2 = GuiCtrlCreateListView("Date                                   |Number of products         ", 13, 30, 305, 160)
$pp = FileOpen(@TEMPDIR & "\DateProjectH\Dates.txt")
$count = _FileCountLines(@TEMPDIR & "\DateProjectH\Dates.txt")

For $k = 1 to $count
   $ll = FileReadLine($pp)
   $spll = StringSplit($ll, "=")
   If isarray($spll) then
   GuiCtrlCreateListViewItem($spll[1] & "|" & $spll[2], $List2)
   endif
Next

;OPTION RUN //////////////////////////////////////////////////////
GuiCtrlCreateTabItem("Run Options")
GuiCtrlCreateLabel("", 0, 22, 400, 200)
GuiCtrlSetBkColor(-1, 0xE0E0E0)
GuiCtrlSetState(-1, $GUI_DISABLE)


GuiCtrlCreateLabel("Run Options : ", 5, 50, 120)
GuiCtrlSetFont(-1, 10, "", "", "MV Boli")
GuiCtrlSetColor(-1, $COLOR_RED)

GuiCtrlCreateLabel("Visibility Options : ", 283, 50, 120)
GuiCtrlSetFont(-1, 10, "", "", "MV Boli")
GuiCtrlSetColor(-1, $COLOR_RED)

GuiCtrlCreateLabel("1) Choose ""Run Now"" if you want to start the collect right now" & @CRLF & "Choose the second options if you want to start it withing your schedules" & @CRLF & "Then click start in the first tab" & @CRLF & @CRLF &  "2) Choose either the interface should be visible or hidden while collecting", 5, 130)
GuiCtrlSetColor(-1, $COLOR_GRAY)

GUIStartGroup()
$RunNow = GuiCtrlCreateRadio("Run Now", 5, 75)
$RunSpecified = GuiCtrlCreateRadio("Run in specified dates", 5, 105)



GUIStartGroup()
$HideGui = GuiCtrlCreateRadio("Program hidden", 285, 75)
$ShowGui = GuiCtrlCreateRadio("Program visible", 285, 105)

$DownloadImage = GuiCtrlCreateCheckBox("Download Images", 135,30)



GuiSetState(@SW_SHOW)

;IP//////////////////////////////////////////////////////////////////////////IP/////////////////////////////////////////IP////////////////////////IP
$InetIp = _InetGetSource("http://www.mon-ip.com/")

$StrIPP = StringRegExp($InetIp, "var Ip = ""([0123.456789]{1,40})""", $STR_REGEXPARRAYMATCH)
If IsArray($StrIPP) then
GuiCtrlSetData($ipp, $StrIPP[0] & " (IP)")
Else
   sleep(10)
EndIf
;IP//////////////////////////////////////////////////////////////////////////IP/////////////////////////////////////////IP////////////////////////IP

While 1
   sleep(20)
   $sms = GuiGetMsg()
   switch $sms
   case $GUI_EVENT_CLOSE
	  Exit

;START ////////////////////////////////////////////////////////////////START ///////////////////////////////START////////////////////////////////
   Case $start
   $RDownloadImage = GuiCtrlREad($DownloadImage)
   $RCategory = GuiCtrlRead($Category)
   $RSubCategory = GuiCtrlRead($SubCategory)
   $RRunNow = GuiCtrlRead($RunNow)
   $RRunSpecified = GuiCtrlRead($RunSpecified)
   $RHideGui = GuiCtrlRead($HideGui)



   If $RCategory = "" Or $RSubCategory = "" then
	  msgbox(16, "Error", "Please write a category and a subcategory then try again")
   else
	  If $RRunNow = $GUI_UNCHECKED AND $RRunSpecified = $GUI_UNCHECKED then
		 msgbox(16, "Error", "Please choose a run option from Run options tab then try again")
		 Else
	  $opaTimer = FileOpen(@DESKTOPDIR & "\ProjectHTime.txt")
	  $ReadOpaTimer = FileRead(@DESKTOPDIR & "\ProjectHTime.txt")
	  FileClose($opaTimer)


	  $ms = MsgBox(1, "Starting Program .. ", "Dates for program to run : " & @CRLF & $ReadOpaTimer & @CRLF & "Click ""OK"" to start the program, it will start collecting for each hour you designed")
   Switch $ms
   Case 2

	  sleep(200)
   Case 1

GuiCtrlSetState($start, $GUI_DISABLE)
GuiCtrlSetState($pause, $GUI_ENABLE)
If $RRunNow = $GUI_CHECKED then
   $COLLECTSTART = TRUE
EndIf
If $RHideGui = $GUI_CHECKED then
GuiSetState(@SW_HIDE)
EndIf
	  $STARTING = True

   EndSwitch
   EndIf
   EndIf
  ;REFRESHIP///////////////////////////////////////////////REFRESH IP/////////////////////////////////////REFRESH IP/////////.
CASE $REFRESH
   GuiCtrlSetData($Ipp, " (IP) : Loading ..")
   $InetIp = _InetGetSource("http://www.mon-ip.com/")
sleep(2000)
$StrIPP = StringRegExp($InetIp, "var Ip = ""([0123.456789]{1,40})""", $STR_REGEXPARRAYMATCH)
If IsArray($StrIPP) then
GuiCtrlSetData($ipp, $StrIPP[0] & " (IP)")
Else
   sleep(10)
EndIf
;REFRESHIP///////////////////////////////////////////////REFRESH IP/////////////////////////////////////REFRESH IP/////////.
CASE $CHANGE
   MsgBox(0, "In progress", "This feature can be added with a specific VPN from your choice.")


;PAUSE//////////////////////////////////////////PAUSE////////////////////////PAUSE///////////////////////////////
Case $Pause
GuiCtrlSetState($start, $GUI_ENABLE)
GuiCtrlSetState($pause, $GUI_DISABLE)
$CollectStart = False
$STARTING = False

;ADD TIME////////////////////////////////ADD TIME///////////////////////////////////////////////ADD TIME ///////////////////////////////
CASE $ADD
$ReadDate = GuiCtrlRead($ComboD)
$ReadHour = GuiCtrlRead($ComboH)
$ReadMin = GuiCtrlRead($ComboM)

If FileExists(@DESKTOPDIR & "\ProjectHTime.txt") = False Then
   _FileCreate(@DESKTOPDIR & "\ProjectHTime.txt")
EndIf

$WriteTime = FileOpen(@DESKTOPDIR & "\ProjectHTime.txt",1)
FileWrite($WriteTime, $ReadHour & ":" & $ReadMin & " : " & $ReadDate & @CRLF)
FileClose($WriteTime)

 _GUICtrlListView_AddItem($List, $ReadHour & ":" & $ReadMin & " : " & $ReadDate)
 ;ADD TIME////////////////////////////////ADD TIME///////////////////////////////////////////////ADD TIME ///////////////////////////////

 ;OPEN DATA////////////////////////OPEN DATA///////////////////////////////OPEN DATA ////////////////////////////////////////////////////
 Case $OpenData
	ShellExecute(@DESKTOPDIR & "\projectH\")
EndSwitch


;COLLECTING/////////////////////////////////////COLLECTING//////////////////////////////////COLLECTING/////////////////////////
If $STARTING = TRUE then

   $OpaStartC = FileOpen(@DESKTOPDIR & "\ProjectHTime.txt")
   $ReadOpaStartC = FileRead($OpaStartC)
   $StrStartRead = StringRegExp($ReadOpaStartC, @HOUR & ":" & @MIN & " : " & _NowDate())
   If $StrStartRead = TRUE then
	  $CollectStart = TRUE
   Else
	  sleep(10)
   EndIf
EndIf
If $CollectStart = TRUE then
   MsgBox(0, "Collecting", "Collecting .. ", 4)
GuiCtrlSetState($start, $GUI_DISABLE)
GuiCtrlSetState($pause, $GUI_DISABLE)


	  if fileexists(@TEMPDIR & "\projectHLastDate.txt") = False then
		 _FileCreate(@TEMPDIR & "\projectHLastDate.txt")
	  endif
	  $xdd = FileOpen(@TEMPDIR & "\projectHLastDate.txt", 2)
	  FileWrite($xdd,  _NowDate() & " " & @HOUR & ":" & @MIN & ":" & @SEC)
	  FileClose($xdd)


	  $m = 0
   $oopp = FileOpen(@TEMPDIR & "\DateProjectH\Dates.txt")
   $rroo = FileRead($oopp)
   $stroo = StringRegExp($rroo, _NowDate())
   If $stroo = TRUE then
	  sleep(20)
   Else
	  $oopp = FileOpen(@TEMPDIR & "\DateProjectH\Dates.txt", 1)
	  FileWrite($oopp, @CRLF & _NowDate() & "=0")
	  FileClose($oopp)
   Endif


   $RCategory = GuiCtrlRead($Category)
   $RSubCategory = GuiCtrlRead($SubCategory)
   $Link = "http://www.heb.com.mx/" & $RCategory & "/" & $SubCategory & ".html"
   $TimeNow = _DateDayOfWeek(@WDAY) & " " & @HOUR & " " & @MIN
$SPRC = StringReplace($RCategory, "/", "")
$SPRC2 = StringReplace($RSubCategory, "/", "")

$NAMESPRC = $SPRC & $SPRC2



$VERR = FALSE
$z = 1

While 1


If $VERR = FALSE then

$inet = _InetGetSource("http://www.heb.com.mx/" & $RCategory & "/" & $RSubCategory & ".html?p=" & $z)
$String = StringRegExp($inet, "(<h2 class=""product-name""><a href="")(http://www.heb.com.mx/[0123456789-è-'&é?.azertyuiopmlkjhgfAZERTYUIOPMLKJHGFDSQWXCVBN?dsqwxcvbn,ù$:!;*]{1,120})", $STR_REGEXPARRAYMATCH)
$ub = ubound($string)
If $ub = 2 then
$UrlProduct = $String[1]
GuiCtrlSetData($start, "Collecting")
Else
   MsgBox(16, "Error", "Problem connecting to website, or wrong URL " & @CRLF & "Please try later or verify your URL .")
   Exit
EndIf

_FileCreate(@DESKTOPDIR & "\projectH\" & $TIMENOW & "\" & $NAMESPRC & "\page" & $z & "\")
$i = 0
  EndIf

Do

$m = $m + 1
$i = $i + 1
$SpecialPrice = "NULL"


$Inet2 = _InetGetSource($UrlProduct)

;PRODUCT DESCRIPTION/////////////////////////////////////////
$StringDescription = StringRegExp($Inet2, "<meta name=""keywords"" content=""([0123456789-è- '&é?.azertyuiopmlkjhgfAZERTYUIOPMLKJHGFDSQWXCVBN?dsqwxcvbn,ù$:!;*]{1,120})", $STR_REGEXPARRAYMATCH)
If isarray($StringDescription) then
$ProductDesc = $StringDescription[0]
Else
$ProductDesc = ""
endif
;PRODUCT ID/////////////////////////////////////////
$StringId = StringRegExp($inet2, "<input type=""hidden"" name=""product"" value=""([0123456789-è- '&é?.azertyuiopmlkjhgfAZERTYUIOPMLKJHGFDSQWXCVBN?dsqwxcvbn,ù$:!;*]{1,120})", $STR_REGEXPARRAYMATCH)
If IsArray($StringId) then
$ProductId = $StringId[0]
Else
   $ProductId = ""
EndIf

;SEARCH FOR PRICE ///////////////////////////////
$StringPrice1 = StringRegExp($Inet2, "special-price", $STR_REGEXPARRAYMATCH)
If isArray($StringPrice1) then
   $VARI = TRUE
Else
   $VARI = False
EndIf

If $VARI = TRUE then
   $TrimOldPrice = StringTrimLeft($inet2, StringInStr($inet2, "old-price") )
   $StringOldPRice = StringRegExp($TrimOldPrice, "([0123456789]{1,10}.[0123456789]{1,10})   ", $STR_REGEXPARRAYMATCH)
   If IsArray($StringOldPrice) then
	  $OldPrice = $StringOldPrice[0]
   Else
	  $OldPrice = ""
   EndIf
   $TrimSpecialPrice = StringTrimLeft($inet2, StringInStr($inet2, "special-price") )
   $StringSpecialPrice = StringRegExp($TrimSpecialPrice, "([0123456789]{1,10}.[0123456789]{1,10})   ", $STR_REGEXPARRAYMATCH)
    If IsArray($StringSpecialPrice) then
	  $SpecialPrice = $StringSpecialPrice[0]
   Else
	  $SpecialPrice = "NULL"
   EndIf
Else
   $StringOldPrice = StringRegExp($inet2,"([0123456789]{1,10}.[0123456789]{1,10})</span>", $STR_REGEXPARRAYMATCH)
   If IsArray($StringOldPrice) then
   $OldPrice = $StringOldPrice[0]
Else
   $OldPrice = ""
EndIf
EndIf

$StringBrand = StringRegExp($inet2, """brand"":""([AZERTYUIOPMLKJHGFDSQWXCVBNazertyuiopmlkjhgfdsqwxcvbn]{1,20})", $STR_REGEXPARRAYMATCH)
If IsArray($StringBrand) then
   $ProductBrand = $StringBrand[0]
Else
   $ProductBrand = ""
EndIf

If $RDownloadImage = $GUI_CHECKED then
$TrimImage = StringTrimLeft($inet2, StringInStr($inet2, "class=""gallery-image visible""") )
$StringImage = StringRegExp($TrimImage, "src=""(.{1,550})""", $STR_REGEXPARRAYMATCH)

If IsArray($StringImage) then
   $Img = $StringImage[0]
   InetGet($StringImage[0], @DESKTOPDIR & "\projectH\" & $TIMENOW & "\" & $NAMESPRC & "\page" & $z & "\" & $i & " " & $ProductDesc & ".jpg")
Else
   $Img = ""
   sleep(200)
EndIf
Else
   $img = ""
EndIf

$op = FileOpen(@DESKTOPDIR & "\projectH\" & $TIMENOW & "\" & $NAMESPRC & "\page" & $z & "\" & $i & " " & $ProductDesc & ".txt", 2)
FileWrite($op, "ProductIdSource = " & $ProductId & @CRLF & "ProductURL = " & $UrlProduct & @CRLF & "ProductDescription = " & $ProductDesc & @CRLF & "ProductImage = " & $Img & @CRLF & "ProductBrand (marca-related) = " & $ProductBrand & @CRLF & "ProductCurrentPrice = " & $OldPrice & @CRLF & "ProductCurrentSpecialPrice = " & $SpecialPrice)
FileClose($op)

$pol = FileOpen(@TEMPDIR & "\DateProjectH\Dates.txt")
$polr = FileRead($pol)
$Strpol = StringRegExp($polr, _NowDate() & "=([0123456789]{1,6})", $STR_REGEXPARRAYMATCH)
FileClose($pol)

If isarray($Strpol) then
$Number = $strpol[0] + 1
Else
$Number = ""
EndIf

$ccol = _FileCountLines(@TEMPDIR & "\DateProjectH\Dates.txt")
_FileWriteToLine(@TEMPDIR & "\DateProjectH\Dates.txt", $ccol, _NowDate() & "=" & $number, TRUE)


$ccL = _GuiCtrlListView_GetItemCount($List2)
_GUICtrlListView_DeleteItem($List2, $ccL - 1)
sleep(50)
 _GUICtrlListView_AddItem($List2, _NowDate())
 sleep(100)
 _GUICtrlListView_AddSubItem($List2, $ccL - 1, $Number, 1)


GuiCtrlSetData($labelCol, $m)

$trim = StringTrimLeft($inet, StringInStr($inet, $String[0] & $String[1]) )

Global $String = StringRegExp($trim, "(<h2 class=""product-name""><a href="")(http://www.heb.com.mx/[0123456789-è-'&é?.azertyuiopmlkjhgfAZERTYUIOPMLKJHGFDSQWXCVBN?dsqwxcvbn,ù$:!;*]{1,120})", $STR_REGEXPARRAYMATCH)
$Verification = StringRegExp($trim, "(<h2 class=""product-name""><a href=""http://www.heb.com.mx/[0123456789-è-'&é?.azertyuiopmlkjhgfAZERTYUIOPMLKJHGFDSQWXCVBN?dsqwxcvbn,ù$:!;*]{1,120})", $STR_REGEXPARRAYMATCH)


If IsArray($Verification) then
Global $UrlProduct = $String[1]
$VERR = TRUE
   sleep(10)

Else
   $VERR = FALSE
   $Z = $Z + 1

   ExitLoop

Endif

Until $VERR = FALSE
Wend
EndIf


Wend



