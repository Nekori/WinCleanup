; 安装程序初始定义常量
!define FILE_NAME "WinCleaner"
!define FILE_VERSION "0.0.0.1"
!define PRODUCT_NAME "Windows Automatic Clean up"
!define /date PRODUCT_VERSION "1.0.%y.%m%d"
!define PRODUCT_PUBLISHER "Nekori"
!include nsDialogs.nsh    ;窗口
!include LogicLib.nsh
;!include "x64.nsh"
;!include "InstallOptions.nsh"

;安装程序的版本信息
VIProductVersion "${FILE_VERSION}"	;版本号，格式为 X.X.X.X (若使用则本条必须)
VIAddVersionKey /LANG=2052 ProductName "${PRODUCT_NAME} ${PRODUCT_VERSION}"	;产品名称
VIAddVersionKey /LANG=2052 ProductVersion "${PRODUCT_VERSION}"	;产品版本
VIAddVersionKey /LANG=2052 Comments "${PRODUCT_NAME}${PRODUCT_VERSION}"	;备注
VIAddVersionKey /LANG=2052 LegalCopyright "Copyright (C) ${PRODUCT_PUBLISHER}"	;合法版权
VIAddVersionKey /LANG=2052 FileDescription "${PRODUCT_NAME}"	;文件描述(标准信息)
VIAddVersionKey /LANG=2052 FileVersion "${FILE_VERSION}"	;文件版本(标准信息)
;VIAddVersionKey /LANG=2052 CompanyName "${PRODUCT_PUBLISHER}"	;公司名
;VIAddVersionKey /LANG=2052 LegalTrademarks "${PRODUCT_PUBLISHER}"		;合法商标

Name "${PRODUCT_NAME} ${FILE_VERSION}"
OutFile "${FILE_NAME} v${FILE_VERSION}.exe"
InstallDir "$PLUGINSDIR"
Icon "G:\ICON\洛克人ico\X.ico"
RequestExecutionLevel user
;SilentInstall silent	;静默安装
SetCompressor lzma
BrandingText /TRIMright "Nekori：https://github.com/Nekori/WinCleaner"

;分配变量
Var Dialog
Var Label1
Var Button1
;Var Button2
Var Buttonhttp

;创建自定义界面
Page custom nsDialogs "" "WinCleaner"
Page instfiles

Section -Post
	SetOutPath "$PLUGINSDIR"
	File "README.md"
SectionEnd

;函数区段
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
	${NSD_CreateLabel} 5% 5% 100% 10% "请选择组件"
	
	${NSD_CreateButton} 10% 20% 80% 20% "清理回收站"
	Pop $Button1
	${NSD_OnClick} $Button1 B1

	${NSD_CreateButton} 10% 70% 80% 20% "更新地址"
	Pop $Buttonhttp
	${NSD_OnClick} $Buttonhttp Bhttp

	nsDialogs::Show
FunctionEnd

Function B1 #清理回收站
	RMDir /r "C:\$$RECYCLE.BIN"
	RMDir /r "D:\$$RECYCLE.BIN"
	RMDir /r "E:\$$RECYCLE.BIN"
	RMDir /r "F:\$$RECYCLE.BIN"
	RMDir /r "G:\$$RECYCLE.BIN"
	RMDir /r "H:\$$RECYCLE.BIN"
	SendMessage $HWNDPARENT ${WM_CLOSE} 0 0
FunctionEnd
;Function B2
;	ReadEnvStr $R1 userprofile
;	SendMessage $HWNDPARENT ${WM_CLOSE} 0 0
;FunctionEnd
Function Bhttp
	ExecShell open "https://github.com/Nekori/WinCleaner/releases"
FunctionEnd
