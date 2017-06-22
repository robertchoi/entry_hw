; example1.nsi
;
; This script is perhaps one of the simplest NSIs you can make. All of the
; optional settings are left to their default settings. The installer simply 
; prompts the user asking them where to install, and drops a copy of example1.nsi
; there. 

!include MUI2.nsh


; MUI Settings / Icons
!define MUI_ICON "icon.ico"
!define MUI_UNICON "icon.ico"
!define PRODUCT_NAME "Entry_HW"
!define PROTOCOL_NAME "entryhw"
!define APP_NAME "Entry_HW.exe"
!define PRODUCT_VERSION "1.6.9"
!define PRODUCT_PUBLISHER "EntryLabs"
!define PRODUCT_WEB_SITE "http://www.play-entry.org/"
 
; MUI Settings / Header
;!define MUI_HEADERIMAGE
;!define MUI_HEADERIMAGE_RIGHT
;!define MUI_HEADERIMAGE_BITMAP "${NSISDIR}\Contrib\Graphics\Header\orange-r-nsis.bmp"
;!define MUI_HEADERIMAGE_UNBITMAP "${NSISDIR}\Contrib\Graphics\Header\orange-uninstall-r-nsis.bmp"
 
; MUI Settings / Wizard
;!define MUI_WELCOMEFINISHPAGE_BITMAP "${NSISDIR}\Contrib\Graphics\Wizard\orange-nsis.bmp"
;!define MUI_UNWELCOMEFINISHPAGE_BITMAP "${NSISDIR}\Contrib\Graphics\Wizard\orange-uninstall-nsis.bmp"

;--------------------------------

; The name of the installer
Name "��Ʈ�� �ϵ����"

; The file to write
OutFile "${PRODUCT_NAME}_${PRODUCT_VERSION}_Setup.exe"

; The default installation directory
InstallDir "C:\${PRODUCT_NAME}"

; Registry key to check for directory (so if you install again, it will 
; overwrite the old one automatically)
InstallDirRegKey HKLM "Software\${PRODUCT_NAME}" "Install_Dir"

; Request application privileges for Windows Vista
RequestExecutionLevel admin


;--------------------------------

; Pages

!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!define MUI_FINISHPAGE_NOAUTOCLOSE
!define MUI_FINISHPAGE_RUN
!define MUI_FINISHPAGE_RUN_FUNCTION "LaunchLink"

!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
;--------------------------------

; �ٱ��� ����
!insertmacro MUI_LANGUAGE "Korean" ;first language is the default language

LangString TEXT_ENTRY_TITLE ${LANG_KOREAN} "��Ʈ�� �ϵ���� (�ʼ�)"
LangString TEXT_START_MENU_TITLE ${LANG_KOREAN} "���۸޴��� �ٷΰ���"
LangString TEXT_DESKTOP_TITLE ${LANG_KOREAN} "����ȭ�鿡 �ٷΰ���"
LangString DESC_ENTRY ${LANG_KOREAN} "��Ʈ�� �ϵ����"
LangString START_ENTRY ${LANG_KOREAN} "��Ʈ�� �ϵ���� �����ϱ�"
LangString DESC_START_MENU ${LANG_KOREAN} "���۸޴��� �ٷΰ��� �������� �����˴ϴ�."
LangString DESC_DESKTOP ${LANG_KOREAN} "����ȭ�鿡 �ٷΰ��� �������� �����˴ϴ�."
LangString SETUP_UNINSTALL_MSG ${LANG_ENGLISTH} "��Ʈ�� �ϵ��� �̹� ��ġ�Ǿ� �ֽ��ϴ�. $\n$\r'Ȯ��' ��ư�� ������ ���� ������ ���� �� �缳ġ�ϰ� '���' ��ư�� ������ ���׷��̵带 ����մϴ�."


!insertmacro MUI_LANGUAGE "English"

LangString TEXT_ENTRY_TITLE ${LANG_ENGLISTH} "Entry HW (required)"
LangString TEXT_START_MENU_TITLE ${LANG_ENGLISTH} "Start menu shortcut"
LangString TEXT_DESKTOP_TITLE ${LANG_ENGLISTH} "Desktop shortcut"
LangString DESC_ENTRY ${LANG_ENGLISTH} "Entry HW Program"
LangString START_ENTRY ${LANG_ENGLISTH} "Start Entry HW Program"
LangString DESC_START_MENU ${LANG_ENGLISTH} "Create shortcut on start menu"
LangString DESC_DESKTOP ${LANG_ENGLISTH} "Create shortcut on desktop"
LangString SETUP_UNINSTALL_MSG ${LANG_ENGLISTH} "Entry_HW is already installed. $\n$\nClick 'OK' to remove the previous version or 'Cancel' to cancel this upgrade."


; The stuff to install
Section $(TEXT_ENTRY_TITLE) SectionEntry
  SectionIn RO
  
  ; Set output path to the installation directory.
  ;SetOutPath $INSTDIR
  

  ; Put file there
  SetOutPath "$INSTDIR\locales"
  File "..\dist\win-ia32-unpacked\locales\*.*"
  
  SetOutPath "$INSTDIR\resources"
  File /r "..\dist\win-ia32-unpacked\resources\*.*"
  
  SetOutPath "$INSTDIR"
  File "..\dist\win-ia32-unpacked\*.*"
  File "icon.ico"
  
  WriteRegStr HKCR "${PROTOCOL_NAME}" "URL Protocol" ""
  WriteRegStr HKCR "${PROTOCOL_NAME}\DefaultIcon" "" "$INSTDIR\icon.ico"  
  WriteRegStr HKCR "${PROTOCOL_NAME}\Shell\Open" "" "&Open"
  WriteRegStr HKCR "${PROTOCOL_NAME}\Shell\Open\Command" "" '"$INSTDIR\${PRODUCT_NAME}.exe" "%1"'
  
  ; Write the installation path into the registry
  WriteRegStr HKLM "SOFTWARE\${PRODUCT_NAME}" "Install_Dir" "$INSTDIR"
  
  ; Write the uninstall keys for Windows
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "DisplayName" "��Ʈ�� �ϵ����"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "Publisher" "${PRODUCT_PUBLISHER}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"  
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "UninstallString" '"$INSTDIR\��Ʈ�� �ϵ���� ����.exe"'
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "DisplayIcon" '"$INSTDIR\icon.ico"'
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "NoRepair" 1
  WriteUninstaller "\��Ʈ�� �ϵ���� ����.exe"
  
SectionEnd

; Optional section (can be disabled by the user)
Section $(TEXT_START_MENU_TITLE) SectionStartMenu

  SetShellVarContext all
  CreateDirectory "$SMPROGRAMS\EntryLabs\${PRODUCT_NAME}"
  CreateShortCut "$SMPROGRAMS\EntryLabs\${PRODUCT_NAME}\��Ʈ�� �ϵ���� ����.lnk" "$INSTDIR\��Ʈ�� �ϵ���� ����.exe" "" "$INSTDIR\��Ʈ�� �ϵ���� ����.exe" 0
  CreateShortCut "$SMPROGRAMS\EntryLabs\${PRODUCT_NAME}\��Ʈ�� �ϵ����.lnk" "$INSTDIR\${PRODUCT_NAME}.exe" "" "$INSTDIR\icon.ico" 0
  
SectionEnd

;--------------------------------

; Optional section (can be disabled by the user)
Section $(TEXT_DESKTOP_TITLE) SectionDesktop

	SetShellVarContext all
    CreateShortCut "$DESKTOP\��Ʈ�� �ϵ����.lnk" "$INSTDIR\${PRODUCT_NAME}.exe" "" "$INSTDIR\icon.ico" 0
  
SectionEnd

!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
	!insertmacro MUI_DESCRIPTION_TEXT ${SectionEntry} $(DESC_ENTRY)
    !insertmacro MUI_DESCRIPTION_TEXT ${SectionStartMenu} $(DESC_START_MENU)
    !insertmacro MUI_DESCRIPTION_TEXT ${SectionDesktop} $(DESC_DESKTOP)
!insertmacro MUI_FUNCTION_DESCRIPTION_END

;--------------------------------

; Uninstaller

Section "Uninstall"
  SetShellVarContext all
  ; Remove registry keys
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
  DeleteRegKey HKLM "SOFTWARE\${PRODUCT_NAME}"
  DeleteRegKey HKCR "${PRODUCT_NAME}"
  DeleteRegKey HKCR "${PROTOCOL_NAME}"

  ; Remove files and uninstaller
  Delete $INSTDIR\*

  ; Remove shortcuts, if any
  Delete "$SMPROGRAMS\EntryLabs\${PRODUCT_NAME}\*.*"
  
  Delete "$DESKTOP\��Ʈ�� �ϵ����.lnk"

  ; Remove directories used
  RMDir "$SMPROGRAMS\EntryLabs\${PRODUCT_NAME}"
  RMDir /r "$INSTDIR"

SectionEnd

Function LaunchLink
  Exec "${APP_NAME}"
FunctionEnd

Function .onInit
  FindProcDLL::FindProc "${APP_NAME}"
  StrCmp $R0 1 mfound notRunning
  mfound:
	KillProcDLL::KillProc "${APP_NAME}"
  notRunning:
 
  ReadRegStr $R0 HKLM \
  "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" \
  "UninstallString"
  StrCmp $R0 "" done
  
  ReadRegStr $R1 HKLM "SOFTWARE\${PRODUCT_NAME}" "Install_Dir" 
  StrCmp $R1 "" done
 
  MessageBox MB_OKCANCEL|MB_ICONEXCLAMATION \
  $(SETUP_UNINSTALL_MSG) \
  IDOK uninst
  Abort
 
  ;Run the uninstaller
  uninst:
    ClearErrors
    ;ExecWait '$R0 _?=$INSTDIR'
    ExecWait '$R0 _?=$R1'
 
    ;IfErrors no_remove_uninstaller done
    ;no_remove_uninstaller:
    IfErrors 0 +2
	  Goto no_remove_uninstaller
	  RMDir /r /REBOOTOK $R1 
	  Goto done
	  
  no_remove_uninstaller:
    DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
    DeleteRegKey HKLM "SOFTWARE\${PRODUCT_NAME}"
    DeleteRegKey HKCR "${PRODUCT_NAME}"
    DeleteRegKey HKCR "${PROTOCOL_NAME}"
	
  done:
 
FunctionEnd