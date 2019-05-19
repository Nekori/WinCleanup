; ��װ�����ʼ���峣��
!define FILE_NAME "WinCleanup"
!define FILE_VERSION "0.0.0.8"
!define PRODUCT_NAME "Windows Automatic Clean up"
!define /date PRODUCT_VERSION "1.0.%y.%m%d"
!define PRODUCT_PUBLISHER "Nekori"
!include nsDialogs.nsh    ;����
!include LogicLib.nsh
!include MUI.nsh
!include "FileFunc.nsh"   ;Ϊ����ˢ�����湦��
!include "x64.nsh"
;!include "InstallOptions.nsh"

;��װ����İ汾��Ϣ
VIProductVersion "${FILE_VERSION}"	;�汾�ţ���ʽΪ X.X.X.X (��ʹ����������)
VIAddVersionKey /LANG=2052 ProductName "${PRODUCT_NAME} ${PRODUCT_VERSION}"	;��Ʒ����
VIAddVersionKey /LANG=2052 ProductVersion "${PRODUCT_VERSION}"	;��Ʒ�汾
VIAddVersionKey /LANG=2052 Comments "${PRODUCT_NAME}${PRODUCT_VERSION}"	;��ע
VIAddVersionKey /LANG=2052 LegalCopyright "Copyright (C) ${PRODUCT_PUBLISHER}"	;�Ϸ���Ȩ
VIAddVersionKey /LANG=2052 FileDescription "${PRODUCT_NAME}"	;�ļ�����(��׼��Ϣ)
VIAddVersionKey /LANG=2052 FileVersion "${FILE_VERSION}"	;�ļ��汾(��׼��Ϣ)
;VIAddVersionKey /LANG=2052 CompanyName "${PRODUCT_PUBLISHER}"	;��˾��
;VIAddVersionKey /LANG=2052 LegalTrademarks "${PRODUCT_PUBLISHER}"		;�Ϸ��̱�

Name "${PRODUCT_NAME} ${FILE_VERSION}"
OutFile "${FILE_NAME} v${FILE_VERSION}.exe"
InstallDir "$PLUGINSDIR"
Icon "G:\ICON\�����ico\X.ico"
RequestExecutionLevel user
;SilentInstall silent	;��Ĭ��װ
SetCompressor /SOLID lzma
BrandingText /TRIMright "Nekori��https://github.com/Nekori/WinCleanup"
InstallButtonText "ȫ������"	;�滻Ĭ�ϰ�װ��ť
MiscButtonText "" "" "�˳�" ""  ;��һ�� ��һ�� �˳� �رհ�ť�ı�
ShowInstDetails show

;�������
Var Dialog
Var Label1
Var Button0
Var Button1
Var Button2
Var Button3
Var Button4
Var Button5

;�����Զ������
Page custom nsDialogs "" "WinCleanup"
Page instfiles

Section -Post
	SetOutPath "$PLUGINSDIR"
	File "README.md"
	call B1
	call B2
	call B3
	call B4
SectionEnd

;��������
Function .onInit
	${If} ${RunningX64}
    SetRegView 64
	${Else}
    SetRegView 32
	${EndIf}
FunctionEnd

Function nsDialogs
	nsDialogs::Create /NOUNLOAD 1018
	Pop $Dialog
		${If} $Dialog == error
			Abort
		${EndIf}
	Pop $Label1
	${NSD_CreateLabel} 5% 5% 100% 10% "��ѡ��������Ŀ��������ɺ���������˳�"
	
	${NSD_CreateButton} 5% 15% 40% 12% "����վ"
	Pop $Button1
	${NSD_OnClick} $Button1 B1

	${NSD_CreateButton} 5% 30% 40% 12% "�û��ļ���"
	Pop $Button2
	${NSD_OnClick} $Button2 B2

	${NSD_CreateButton} 5% 45% 40% 12% "�û���ϵͳ��IE����"
	Pop $Button3
	${NSD_OnClick} $Button3 B3

	${NSD_CreateButton} 5% 60% 40% 12% "Windows.old"
	Pop $Button4
	${NSD_OnClick} $Button4 B4
	
	${NSD_CreateButton} 55% 15% 40% 12% "360"
	Pop $Button5
	${NSD_OnClick} $Button5 B5
	
	${NSD_CreateButton} 5% 75% 90% 12% "���µ�ַ"
	Pop $Button0
	${NSD_OnClick} $Button0 http

	nsDialogs::Show
FunctionEnd

Function B1 #�������վ
	RMDir /r "C:\$$RECYCLE.BIN"
	RMDir /r "D:\$$RECYCLE.BIN"
	RMDir /r "E:\$$RECYCLE.BIN"
	RMDir /r "F:\$$RECYCLE.BIN"
	RMDir /r "G:\$$RECYCLE.BIN"
	RMDir /r "H:\$$RECYCLE.BIN"
	${RefreshShellIcons}
	SendMessage $HWNDPARENT ${WM_CLOSE} 0 0
FunctionEnd
Function B2
;	ReadEnvStr $R1 userprofile
	RMDir /r "$PROFILE\.android"
	RMDir "$PROFILE\ansel\Filters"
	RMDir "$PROFILE\ansel"
	SendMessage $HWNDPARENT ${WM_CLOSE} 0 0
FunctionEnd
Function B3
	RMDir /r "$WINDIR\TEMP"
	RMDir /r "$TEMP"
	RMDir /r "$INTERNET_CACHE"
	SendMessage $HWNDPARENT ${WM_CLOSE} 0 0
FunctionEnd
Function B4
	ReadEnvStr $R2 SYSTEMDRIVE
	RMDir /r "$R2\Windows.old"
	SendMessage $HWNDPARENT ${WM_CLOSE} 0 0
FunctionEnd
Function B5
	RMDir /r "F:\360�û��ļ�"
	RMDir /r "F:\360SoftMgrGame"
	RMDir /r "F:\360Downloads"
	SendMessage $HWNDPARENT ${WM_CLOSE} 0 0
FunctionEnd
Function http
	ExecShell open "https://github.com/Nekori/WinCleanup/releases"
FunctionEnd
