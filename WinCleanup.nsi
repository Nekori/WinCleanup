; 安装程序初始定义常量
!define FILE_NAME "WinCleanup"
!define FILE_VERSION "0.0.0.8"
!define PRODUCT_NAME "Windows Automatic Clean up"
!define /date PRODUCT_VERSION "1.0.%y.%m%d"
!define PRODUCT_PUBLISHER "Nekori"
!include nsDialogs.nsh    ;窗口
!include LogicLib.nsh
!include MUI.nsh
!include "FileFunc.nsh"   ;为加入刷新桌面功能
!include "x64.nsh"
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
SetCompressor /SOLID lzma
BrandingText /TRIMright "Nekori：https://github.com/Nekori/WinCleanup"
InstallButtonText "全部清理"	;替换默认安装按钮
MiscButtonText "" "" "退出" ""  ;上一步 下一步 退出 关闭按钮文本
ShowInstDetails show

;分配变量
Var Dialog
Var Label1
Var Button0
Var Button1
Var Button2
Var Button3
Var Button4
Var Button5

;创建自定义界面
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

;函数区段
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
	${NSD_CreateLabel} 5% 5% 100% 10% "请选择清理项目：清理完成后程序将自行退出"
	
	${NSD_CreateButton} 5% 15% 40% 12% "回收站"
	Pop $Button1
	${NSD_OnClick} $Button1 B1

	${NSD_CreateButton} 5% 30% 40% 12% "用户文件夹"
	Pop $Button2
	${NSD_OnClick} $Button2 B2

	${NSD_CreateButton} 5% 45% 40% 12% "用户、系统及IE缓存"
	Pop $Button3
	${NSD_OnClick} $Button3 B3

	${NSD_CreateButton} 5% 60% 40% 12% "Windows.old"
	Pop $Button4
	${NSD_OnClick} $Button4 B4
	
	${NSD_CreateButton} 55% 15% 40% 12% "360"
	Pop $Button5
	${NSD_OnClick} $Button5 B5
	
	${NSD_CreateButton} 5% 75% 90% 12% "更新地址"
	Pop $Button0
	${NSD_OnClick} $Button0 http

	nsDialogs::Show
FunctionEnd

Function B1 #清理回收站
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
	RMDir /r "F:\360用户文件"
	RMDir /r "F:\360SoftMgrGame"
	RMDir /r "F:\360Downloads"
	SendMessage $HWNDPARENT ${WM_CLOSE} 0 0
FunctionEnd
Function http
	ExecShell open "https://github.com/Nekori/WinCleanup/releases"
FunctionEnd
