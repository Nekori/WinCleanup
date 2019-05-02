; ��װ�����ʼ���峣��
!define FILE_NAME "WinCleanup"
!define FILE_VERSION "0.0.0.3"
!define PRODUCT_NAME "Windows Automatic Clean up"
!define /date PRODUCT_VERSION "1.0.%y.%m%d"
!define PRODUCT_PUBLISHER "Nekori"
!include nsDialogs.nsh    ;����
!include LogicLib.nsh
;!include "x64.nsh"
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
SetCompressor lzma
BrandingText /TRIMright "Nekori��https://github.com/Nekori/WinCleanup"

;�������
Var Dialog
Var Label1
Var Button1
Var Button2
Var Buttonh

;�����Զ������
Page custom nsDialogs "" "WinCleanup"
Page instfiles

Section -Post
	SetOutPath "$PLUGINSDIR"
	File "README.md"
	call B1
	call B2
SectionEnd

;��������
Function nsDialogs
;	${If} ${RunningX64}
;	      SetRegView 64
;	${Else}
;	       SetRegView 32
;	${EndIf}
	
	nsDialogs::Create /NOUNLOAD 1018
	Pop $Dialog
		${If} $Dialog == error
			Abort
		${EndIf}
	Pop $Label1
	${NSD_CreateLabel} 5% 5% 100% 10% "��ѡ�����"
	
	${NSD_CreateButton} 10% 20% 80% 20% "�������վ"
	Pop $Button1
	${NSD_OnClick} $Button1 B1

	${NSD_CreateButton} 10% 45% 80% 20% "�����û��ļ���"
	Pop $Button2
	${NSD_OnClick} $Button2 B2
	
	${NSD_CreateButton} 10% 70% 80% 20% "���µ�ַ"
	Pop $Buttonh
	${NSD_OnClick} $Buttonh Bhttp

	nsDialogs::Show
FunctionEnd

Function B1 #�������վ
	RMDir /r "C:\$$RECYCLE.BIN"
	RMDir /r "D:\$$RECYCLE.BIN"
	RMDir /r "E:\$$RECYCLE.BIN"
	RMDir /r "F:\$$RECYCLE.BIN"
	RMDir /r "G:\$$RECYCLE.BIN"
	RMDir /r "H:\$$RECYCLE.BIN"
	SendMessage $HWNDPARENT ${WM_CLOSE} 0 0
FunctionEnd
Function B2
	ReadEnvStr $R1 userprofile
	RMDir /r "$R1\.android"
	SendMessage $HWNDPARENT ${WM_CLOSE} 0 0
FunctionEnd
Function Bhttp
	ExecShell open "https://github.com/Nekori/WinCleanup/releases"
FunctionEnd
