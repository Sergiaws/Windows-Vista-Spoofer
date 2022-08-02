#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.16.0
 Author:         Sergiaws

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
$appname=""
;I made a loop to be sure that the application name won't be empty, that's an important data
While $appname=""
	$appname=InputBox("what application do you want to spoof?", "put the path in this field")
	if $appname="" Then
		msgbox(16, "Error", "The name of the application or the path Cannot be empty")
	EndIf
WEnd

msgbox(4096, "atention", "now, you need to choose The Windows that you want to spoof. Windows 2000, XP, Vista, 7, 8, 8.1, 10 or 11. We recommend to choose Windows 7.")
;Now, I create a Combo with a deffault value (Windows 7)
Local $hGUI = GUICreate("Spoofer", 300, 200)
Local $idComboBox = GUICtrlCreateCombo("", 10, 10, 185, 20)
Local $idButton_Ok = GUICtrlCreateButton("Ok", 210, 170, 85, 25)
Local $idButton_Close = GUICtrlCreateButton("Close", 300, 170, 85, 25)
;Here I put the data to the combo
GUICtrlSetData($idComboBox, "Windows2000|WindowsXP|WindowsServer2003|WindowsVista|Windows7|Windows8|Windows8.1|Windows10|Windows11", "Windows7")
;Then here I show the gui
GUISetState(@SW_SHOW, $hGUI)
Local $sComboRead = ""
;This Variable will countain the result of the function that reads the combo
While 1
Switch GUIGetMsg()
Case $GUI_EVENT_CLOSE, $idButton_Close
ExitLoop
Case $idButton_Ok
$sComboRead = GUICtrlRead($idComboBox)
GUIDelete($hGUI)
;This function will check the combo and then write the data to the file
OsWriter($appname, $sComboRead)
EndSwitch
WEnd

; Delete the previous GUI and all controls.
GUIDelete($hGUI)


Func OsWriter($appname, $osname)
	
Local $DefaultBuildNumber=""
	Local $ServicePack=""
	Local $MajorVersion=""
	Local $MinorVersion=""
	Local $Extra=""
	Local $BuildNumber=""
	;Here I verify what Windows was selected
	if $osname="Windows2000" then
		$DefaultBuildNumber="2195"
		$ServicePack="Service Pack 4"
		$MajorVersion="5"
		$MinorVersion="0"
		ElseIf $osname="WindowsXP" then
		$DefaultBuildNumber="2600"
		$ServicePack="Service Pack 3"
		$MajorVersion="5"
		$MinorVersion="1"
		ElseIf $osname="WindowsServer2003" then
		$DefaultBuildNumber="3790"
		$ServicePack="Service Pack 2"
		$MajorVersion="5"
		$MinorVersion="2"
		ElseIf $osname=	"WindowsVista" then
		$DefaultBuildNumber="6003"
		$ServicePack="Service Pack 2 with extended Kernel"
		$MajorVersion="6"
		$MinorVersion="0"
		ElseIf $osname=	"Windows7" then
		$DefaultBuildNumber="7601"
		$ServicePack="Service Pack 1"
		$MajorVersion="6"
		$MinorVersion="1"
		;The extra variable is for some older releases of the Extended Kernel if someone use it, it will countain data such as Win7SuperVerFix
		$Extra="Win7SuperVerFix=1"
		ElseIf $osname=	"Windows8" then
		$DefaultBuildNumber="9200"
		$ServicePack=""
		$MajorVersion="6"
		$MinorVersion="2"
		$Extra="Win8SuperVerFix=1"
		ElseIf $osname=	"Windows7" then
		$DefaultBuildNumber="9600"
		$ServicePack=""
		$MajorVersion="6"
		$MinorVersion="3"
		$Extra="Win8SuperVerFix=1"
		ElseIf $osname=	"Windows10" then
		$DefaultBuildNumber="19044"
		$ServicePack=""
		$MajorVersion="10"
		$MinorVersion="0"
		$Extra="Win10SuperVerFix=1"
		ElseIf $osname=	"Windows11" then
		$DefaultBuildNumber="22000"
		$ServicePack=""
		$MajorVersion="10"
		$MinorVersion="0"
		$Extra="Win10SuperVerFix=1"
	Else 
		;Here I throw an error
		msgbox(16, "Error", "There is an error. Check that you had selected your desired Windows to spoof properly")
		Return ""
	EndIf
	$ChangeBuild=msgbox(68, "", "Your system is "&$osname&" and the default build number for this version is "&$DefaultBuildNumber&". Do you want to change the build number? That could be useful if you want to spoof your system as a beta version of Windows")
	Select
	Case $ChangeBuild=6
		;Here I decided to create a loop to control the input
		While $BuildNumber=""
			$BuildNumber=InputBox("Build Number", "Put here your desired build number")
			if $BuildNumber="" Then
				msgbox(16, "error", "The Build Number cannot be empty")
			EndIf
		WEnd
		
	Case $ChangeBuild=7
		$BuildNumber=$DefaultBuildNumber
	EndSelect
	msgbox(4096, "", "Your Build Number is "&$BuildNumber&". Writing changes to osver.ini")
	$OsverFile=FileOpen(@ScriptDir & "\osver.ini", 1)
	FileWrite($OsverFile, @CRLF & "[" & $appname & "]" & @CRLF)
	FileWrite($OsverFile, "MajorVersion=" & $MajorVersion & @CRLF)
	FileWrite($OsverFile, "MinorVersion=" & $MinorVersion & @CRLF)
	FileWrite($OsverFile, "BuildNumber=" & $BuildNumber & @CRLF)
	If $ServicePack<>"" Then
		FileWrite($OsverFile, "CSDVersion=" & $ServicePack & @CRLF)
	EndIf
	if $Extra<>"" Then
		FileWrite($OsverFile, $Extra & @CRLF)
	EndIf
	FileClose($OsverFile)
EndFunc
