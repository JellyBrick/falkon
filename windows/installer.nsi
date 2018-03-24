; Falkon Windows Installer NSIS Script
; Copyright (C) 2010-2017  David Rosca <nowrep@gmail.com>
;               2012-2017  S. Razi Alavizadeh <s.r.alavizadeh@gmail.com>
;
; For compiling this script you need following plugins:
; FindProcDLL_plug-in, KillProcDLL_plug-in and 'AllAssociation.nsh' needs
; Registry_plug-in, Application_Association_Registration_plug-in
; Unicode version of them can be downloaded from:
; http://sourceforge.net/projects/findkillprocuni/files/bin/
; http://nsis.sourceforge.net/Application_Association_Registration_plug-in
; http://nsis.sourceforge.net/Registry_plug-in

!ifndef CUSTOM
  !define VERSION 3.0.0
  !define ARCH x86
  !define MSVC_VER 140
  !define OPENSSL_BIN_DIR .
  !define MSVC_REDIST_DIR .
  !define FALKON_SRC_DIR ..\..\
  !define FALKON_BIN_DIR .
  !define ICU_BIN_DIR .
  !define QT_DIR .
  !define QT_BIN_DIR .
  !define QT_PLUGINS_DIR .
  !define QTWEBENGINE_DICTIONARIES_DIR qtwebengine_dictionaries
  !undef PORTABLE
!endif

; WinVer.nsh was added in the same release that RequestExecutionLevel so check
; if ___WINVER__NSH___ is defined to determine if RequestExecutionLevel is
; available.
!include /NONFATAL WinVer.nsh
!include x64.nsh

!ifndef PORTABLE
  RequestExecutionLevel admin
!else
  RequestExecutionLevel user
!endif

!addplugindir "wininstall\"

!include "StdUtils.nsh"
!include "FileFunc.nsh"
!include "wininstall\AllAssociation.nsh"
SetCompressor /SOLID /FINAL lzma

!define PRODUCT_NAME "Falkon"
!define /date PRODUCT_VERSION "${VERSION}"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\falkon.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"
!define PRODUCT_CAPABILITIES_KEY "Software\${PRODUCT_NAME}\Capabilities"

!include "MUI.nsh"
!define MUI_ABORTWARNING
!define MUI_ICON "wininstall\install.ico"
!define MUI_UNICON "wininstall\uninstall.ico"
!define MUI_WELCOMEFINISHPAGE_BITMAP "wininstall\welcome.bmp"
!define MUI_UNWELCOMEFINISHPAGE_BITMAP "wininstall\welcome.bmp"

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE ${FALKON_BIN_DIR}\COPYRIGHT.txt
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES

!define MUI_FINISHPAGE_RUN
!define MUI_FINISHPAGE_RUN_FUNCTION "RunFalkonAsUser"
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_LANGUAGE "Czech"
!insertmacro MUI_LANGUAGE "Slovak"
!insertmacro MUI_LANGUAGE "German"
!insertmacro MUI_LANGUAGE "Dutch"
!insertmacro MUI_LANGUAGE "Portuguese"
!insertmacro MUI_LANGUAGE "Greek"
!insertmacro MUI_LANGUAGE "French"
!insertmacro MUI_LANGUAGE "Italian"
!insertmacro MUI_LANGUAGE "Romanian"
!insertmacro MUI_LANGUAGE "Tradchinese"
!insertmacro MUI_LANGUAGE "Simpchinese"
!insertmacro MUI_LANGUAGE "Indonesian"
!insertmacro MUI_LANGUAGE "Georgian"
!insertmacro MUI_LANGUAGE "Japanese"
!insertmacro MUI_LANGUAGE "Swedish"
!insertmacro MUI_LANGUAGE "Polish"
!insertmacro MUI_LANGUAGE "Ukrainian"
!insertmacro MUI_LANGUAGE "Catalan"
!insertmacro MUI_LANGUAGE "Serbian"
!insertmacro MUI_LANGUAGE "SerbianLatin"
!insertmacro MUI_LANGUAGE "Farsi"
!insertmacro MUI_LANGUAGE "Hebrew"
!insertmacro MUI_LANGUAGE "Spanish"
!insertmacro MUI_LANGUAGE "Arabic"
!insertmacro MUI_LANGUAGE "Basque"
!insertmacro MUI_LANGUAGE "Danish"

!insertmacro MUI_RESERVEFILE_LANGDLL

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "${PRODUCT_NAME} Installer ${PRODUCT_VERSION}.exe"
InstallDir "$PROGRAMFILES\${PRODUCT_NAME}\"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails show
ShowUnInstDetails show

!include "wininstall\languages.nsh"

Section !$(TITLE_SecMain) SecMain
  SectionIn RO
  FindProcDLL::FindProc "falkon.exe"
  IntCmp $R0 1 0 notRunning
  MessageBox MB_OKCANCEL|MB_ICONEXCLAMATION "$(MSG_RunningInstance)" /SD IDOK IDCANCEL AbortInstallation
    KillProcDLL::KillProc "falkon.exe"
    Sleep 100
    Goto notRunning
AbortInstallation:
  Abort "$(MSG_InstallationCanceled)"

notRunning:
  SetOverwrite on

  SetOutPath "$INSTDIR"
  File "${FALKON_BIN_DIR}\COPYRIGHT.txt"
  File "${FALKON_BIN_DIR}\falkon.exe"
  File "${FALKON_BIN_DIR}\falkonprivate.dll"
  File "${FALKON_BIN_DIR}\qt.conf"
  File "${OPENSSL_BIN_DIR}\libeay32.dll"
  File "${OPENSSL_BIN_DIR}\ssleay32.dll"
  File "${MSVC_REDIST_DIR}\*"
  File "${ICU_BIN_DIR}\icudt54.dll"
  File "${ICU_BIN_DIR}\icuin54.dll"
  File "${ICU_BIN_DIR}\icuuc54.dll"
  File "${QT_BIN_DIR}\libEGL.dll"
  File "${QT_BIN_DIR}\libGLESv2.dll"
  File "${QT_BIN_DIR}\opengl32sw.dll"
  File "${QT_BIN_DIR}\D3Dcompiler_47.dll"
  File "${QT_BIN_DIR}\Qt5Core.dll"
  File "${QT_BIN_DIR}\Qt5Gui.dll"
  File "${QT_BIN_DIR}\Qt5Network.dll"
  File "${QT_BIN_DIR}\Qt5Positioning.dll"
  File "${QT_BIN_DIR}\Qt5PrintSupport.dll"
  File "${QT_BIN_DIR}\Qt5Qml.dll"
  File "${QT_BIN_DIR}\Qt5Quick.dll"
  File "${QT_BIN_DIR}\Qt5QuickWidgets.dll"
  File "${QT_BIN_DIR}\Qt5Sql.dll"
  File "${QT_BIN_DIR}\Qt5Svg.dll"
  File "${QT_BIN_DIR}\Qt5WinExtras.dll"
  File "${QT_BIN_DIR}\Qt5WebEngine.dll"
  File "${QT_BIN_DIR}\Qt5WebEngineCore.dll"
  File "${QT_BIN_DIR}\Qt5WebEngineWidgets.dll"
  File "${QT_BIN_DIR}\Qt5WebChannel.dll"
  File "${QT_BIN_DIR}\Qt5Widgets.dll"
  File "${QT_BIN_DIR}\QtWebEngineProcess.exe"

  SetOutPath "$INSTDIR\iconengines"
  File "${QT_PLUGINS_DIR}\iconengines\qsvgicon.dll"

  SetOutPath "$INSTDIR\imageformats"
  File "${QT_PLUGINS_DIR}\imageformats\*.dll"

  SetOutPath "$INSTDIR\platforms"
  File "${QT_PLUGINS_DIR}\platforms\qwindows.dll"

  SetOutPath "$INSTDIR\printsupport"
  File "${QT_PLUGINS_DIR}\printsupport\windowsprintersupport.dll"

  SetOutPath "$INSTDIR\qml\QtQuick.2"
  File "${QT_DIR}\qml\QtQuick.2\*"

  SetOutPath "$INSTDIR\qml\QtWebEngine"
  File "${QT_DIR}\qml\QtWebEngine\*"

  SetOutPath "$INSTDIR\resources"
  File "${QT_DIR}\resources\*"

  SetOutPath "$INSTDIR\sqldrivers"
  File "${QT_PLUGINS_DIR}\sqldrivers\qsqlite.dll"

  SetOutPath "$INSTDIR\styles"
  File "${QT_PLUGINS_DIR}\styles\*.dll"

  SetOutPath "$INSTDIR\translations\qtwebengine_locales"
  File "${QT_DIR}\translations\qtwebengine_locales\*"

  SetOutPath "$INSTDIR\qtwebengine_dictionaries\doc"
  ; In some packages underline '_' is used and in some other packages dash '-' is used so we use wildcard
  File "${QTWEBENGINE_DICTIONARIES_DIR}\doc\README*en*US.txt"

  SetOutPath "$INSTDIR\qtwebengine_dictionaries"
  ; in some packages *.bdic files use dash '-' instead of underline '_' followed by a version number. e.g. en-US-3-0.bdic
  File "${QTWEBENGINE_DICTIONARIES_DIR}\en*US*.bdic"

  !ifndef PORTABLE
    call RegisterCapabilities
  !endif
SectionEnd

SectionGroup $(TITLE_SecThemes) SecThemes

  Section Default SecDefault
  SectionIn RO
  SetOutPath "$INSTDIR\themes\windows"
  File "${FALKON_SRC_DIR}\themes\windows\*"
  SetOutPath "$INSTDIR\themes\windows\images"
  File "${FALKON_SRC_DIR}\themes\windows\images\*"
  SectionEnd

  Section Chrome SecChrome
  SetOutPath "$INSTDIR\themes\chrome"
  File "${FALKON_SRC_DIR}\themes\chrome\*"
  SetOutPath "$INSTDIR\themes\chrome\images"
  File "${FALKON_SRC_DIR}\themes\chrome\images\*"
  SectionEnd

  Section Mac SecMac
  SetOutPath "$INSTDIR\themes\mac"
  File "${FALKON_SRC_DIR}\themes\mac\*"
  SetOutPath "$INSTDIR\themes\mac\images"
  File "${FALKON_SRC_DIR}\themes\mac\images\*"
  SectionEnd
SectionGroupEnd

Section $(TITLE_SecTranslations) SecTranslations
  #SetOutPath "$INSTDIR\locale"
  #File "${FALKON_BIN_DIR}\locale\*.qm"
  #SetOutPath "$INSTDIR\qtwebengine_dictionaries\doc"
  #File "${QTWEBENGINE_DICTIONARIES_DIR}\doc\*"
  #SetOutPath "$INSTDIR\qtwebengine_dictionaries"
  #File "${QTWEBENGINE_DICTIONARIES_DIR}\*.bdic"
SectionEnd

Section $(TITLE_SecPlugins) SecPlugins
  SetOutPath "$INSTDIR\plugins"
  File "${FALKON_BIN_DIR}\plugins\*.dll"
SectionEnd


!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SecMain} $(DESC_SecMain)
  !insertmacro MUI_DESCRIPTION_TEXT ${SecTranslations} $(DESC_SecTranslations)
  !insertmacro MUI_DESCRIPTION_TEXT ${SecPlugins} $(DESC_SecPlugins)
  !ifndef PORTABLE
    !insertmacro MUI_DESCRIPTION_TEXT ${SecDesktop} $(DESC_SecDesktop)
    !insertmacro MUI_DESCRIPTION_TEXT ${SecExtensions} $(DESC_SecExtensions)
  !endif
  !insertmacro MUI_DESCRIPTION_TEXT ${SecThemes} $(DESC_SecThemes)

  !ifndef PORTABLE
    !insertmacro MUI_DESCRIPTION_TEXT ${SecSetASDefault} $(DESC_SecSetASDefault)
    !insertmacro MUI_DESCRIPTION_TEXT ${SecProtocols} $(DESC_SecProtocols)
  !endif
!insertmacro MUI_FUNCTION_DESCRIPTION_END


!ifndef PORTABLE
    SectionGroup $(TITLE_SecSetASDefault) SecSetASDefault
        Section $(TITLE_SecExtensions) SecExtensions
          SetOutPath "$INSTDIR"
          ${RegisterAssociation} ".htm" "$INSTDIR\falkon.exe" "FalkonHTML" "Falkon HTML Document" "$INSTDIR\falkon.exe,1" "file"
          ${RegisterAssociation} ".html" "$INSTDIR\falkon.exe" "FalkonHTML" "Falkon HTML Document" "$INSTDIR\falkon.exe,1" "file"
          ${UpdateSystemIcons}
        SectionEnd

        Section $(TITLE_SecProtocols) SecProtocols
          ${RegisterAssociation} "http" "$INSTDIR\falkon.exe" "FalkonURL" "Falkon URL" "$INSTDIR\falkon.exe,0" "protocol"
          ${RegisterAssociation} "https" "$INSTDIR\falkon.exe" "FalkonURL" "Falkon URL" "$INSTDIR\falkon.exe,0" "protocol"
          ${RegisterAssociation} "ftp" "$INSTDIR\falkon.exe" "FalkonURL" "Falkon URL" "$INSTDIR\falkon.exe,0" "protocol"
          ${UpdateSystemIcons}
        SectionEnd
    SectionGroupEnd

    Section -StartMenu
      SetOutPath "$INSTDIR"
      SetShellVarContext all
      CreateDirectory "$SMPROGRAMS\Falkon"
      CreateShortCut "$SMPROGRAMS\Falkon\Uninstall.lnk" "$INSTDIR\Uninstall.exe"
      CreateShortCut "$SMPROGRAMS\Falkon\Falkon.lnk" "$INSTDIR\falkon.exe"
      CreateShortCut "$SMPROGRAMS\Falkon\License.lnk" "$INSTDIR\COPYRIGHT.txt"
    SectionEnd

    Section $(TITLE_SecDesktop) SecDesktop
      SetOutPath "$INSTDIR"
      CreateShortCut "$DESKTOP\Falkon.lnk" "$INSTDIR\falkon.exe" ""
    SectionEnd

    Section -Uninstaller
      WriteUninstaller "$INSTDIR\uninstall.exe"
      WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\falkon.exe"
      WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
      WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\Uninstall.exe"
      WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\falkon.exe"
      WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
      WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "Falkon Team"
      WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "HelpLink" "https://userbase.kde.org/Falkon"
      WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "InstallLocation" "$INSTDIR"
      WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "InstallSource" "$EXEDIR"
      WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "https://kde.org"
      ${GetSize} "$INSTDIR" "/S=0K" $0 $1 $2
      WriteRegDWORD ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "EstimatedSize" "$0"
    SectionEnd

    Section Uninstall
      FindProcDLL::FindProc "falkon.exe"
      IntCmp $R0 1 0 notRunning
      MessageBox MB_OKCANCEL|MB_ICONEXCLAMATION "$(MSG_RunningInstance)" /SD IDOK IDCANCEL AbortInstallation
        KillProcDLL::KillProc "falkon.exe"
        Sleep 100
        Goto notRunning
    AbortInstallation:
      Abort "$(MSG_InstallationCanceled)"

    notRunning:
      SetShellVarContext all
      Delete "$DESKTOP\Falkon.lnk"

      Delete "$INSTDIR\falkon.exe"
      Delete "$INSTDIR\falkonprivate.dll"
      Delete "$INSTDIR\uninstall.exe"
      Delete "$INSTDIR\COPYRIGHT.txt"
      Delete "$INSTDIR\qt.conf"
      Delete "$INSTDIR\libeay32.dll"
      Delete "$INSTDIR\ssleay32.dll"
      Delete "$INSTDIR\libEGL.dll"
      Delete "$INSTDIR\libGLESv2.dll"
      Delete "$INSTDIR\opengl32sw.dll"
      Delete "$INSTDIR\D3Dcompiler_47.dll"
      Delete "$INSTDIR\QtWebEngineProcess.exe"

      ; Wildcard delete to compact script of uninstall section
      Delete "$INSTDIR\icu*.dll"
      Delete "$INSTDIR\Qt5*.dll"
      Delete "$INSTDIR\msvc*.dll"
      Delete "$INSTDIR\vc*.dll"
      Delete "$INSTDIR\concrt*.dll"

      ; Recursively delete folders in root of $INSTDIR
      RMDir /r "$INSTDIR\iconengines"
      RMDir /r "$INSTDIR\imageformats"
      RMDir /r "$INSTDIR\platforms"
      RMDir /r "$INSTDIR\printsupport"
      RMDir /r "$INSTDIR\qml"
      RMDir /r "$INSTDIR\resources"
      RMDir /r "$INSTDIR\translations"
      RMDir /r "$INSTDIR\sqldrivers"
      RMDir /r "$INSTDIR\styles"
      RMDir /r "$INSTDIR\qtwebengine_dictionaries"
      RMDir /r "$INSTDIR\themes"
      RMDir /r "$INSTDIR\locale"
      RMDir /r "$INSTDIR\plugins"

      ; Remove $INSTDIR if it is empty
      RMDir "$INSTDIR"

      ; Remove start menu programs folder
      RMDir /r "$SMPROGRAMS\${PRODUCT_NAME}"

      DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
      DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"

      DeleteRegKey HKLM "Software\${PRODUCT_NAME}"
      DeleteRegValue HKLM "SOFTWARE\RegisteredApplications" "${PRODUCT_NAME}"

      ${UnRegisterAssociation} ".htm" "FalkonHTML" "$INSTDIR\falkon.exe" "file"
      ${UnRegisterAssociation} ".html" "FalkonHTML" "$INSTDIR\falkon.exe" "file"
      ${UnRegisterAssociation} "http" "FalkonURL" "$INSTDIR\falkon.exe" "protocol"
      ${UnRegisterAssociation} "https" "FalkonURL" "$INSTDIR\falkon.exe" "protocol"
      ${UnRegisterAssociation} "ftp" "FalkonURL" "$INSTDIR\falkon.exe" "protocol"
      ${UpdateSystemIcons}
    SectionEnd
!endif

BrandingText "${PRODUCT_NAME} ${PRODUCT_VERSION} Installer"

Function .onInit
        ;Prevent running installer of 64-bit Falkon on 32-bit Windows
        ${If} ${RunningX64}
          ${If} ${ARCH} == "x64"
            StrCpy $InstDir "$PROGRAMFILES64\${PRODUCT_NAME}\"
          ${Else}
            StrCpy $InstDir "$PROGRAMFILES32\${PRODUCT_NAME}\"
          ${Endif}
        ${Else}
          ${If} ${ARCH} == "x64"
            MessageBox MB_OK|MB_ICONEXCLAMATION "This installation requiers Windows x64!"
            Quit
          ${Else}
            StrCpy $InstDir "$PROGRAMFILES\${PRODUCT_NAME}\"
          ${Endif}
        ${EndIf}

        !ifdef PORTABLE
            StrCpy $InstDir "$DESKTOP\${PRODUCT_NAME} Portable\"
        !endif

        ;Prevent Multiple Instances
        System::Call 'kernel32::CreateMutexA(i 0, i 0, t "FalkonInstaller-4ECB4694-2C39-4f93-9122-A986344C4E7B") i .r1 ?e'
        Pop $R0
        StrCmp $R0 0 +3
          MessageBox MB_OK|MB_ICONEXCLAMATION "Falkon installer is already running!" /SD IDOK
        Abort

        ;Language selection dialog¨
        ;Return when running silent instalation

        IfSilent 0 +2
          return

        Push ""
        Push ${LANG_ENGLISH}
        Push English
        Push ${LANG_CZECH}
        Push Czech
        Push ${LANG_SLOVAK}
        Push Slovak
        Push ${LANG_GERMAN}
        Push German
        Push ${LANG_DUTCH}
        Push Dutch
        Push ${LANG_PORTUGUESE}
        Push Portuguese
        Push ${LANG_GREEK}
        Push Greek
        Push ${LANG_FRENCH}
        Push French
        Push ${LANG_ITALIAN}
        Push Italian
        Push ${LANG_ROMANIAN}
        Push Romanian
        Push ${LANG_TRADCHINESE}
        Push TraditionalChinese
        Push ${LANG_SIMPCHINESE}
        Push SimplifiedChinese
        Push ${LANG_INDONESIAN}
        Push Indonesian
        Push ${LANG_GEORGIAN}
        Push Georgian
        Push ${LANG_JAPANESE}
        Push Japanese
        Push ${LANG_SWEDISH}
        Push Swedish
        Push ${LANG_POLISH}
        Push Polish
        Push ${LANG_UKRAINIAN}
        Push Ukrainian
        Push ${LANG_CATALAN}
        Push Catalan
        Push ${LANG_SERBIAN}
        Push Serbian
        Push ${LANG_SERBIANLATIN}
        Push SerbianLatin
        Push ${LANG_FARSI}
        Push Persian
        Push ${LANG_HEBREW}
        Push Hebrew
        Push ${LANG_SPANISH}
        Push Spanish
        Push ${LANG_DANISH}
        Push Danish
        Push A ; A means auto count languages
               ; for the auto count to work the first empty push (Push "") must remain
        LangDLL::LangDialog "Installer Language" "Please select the language of the installer"

        Pop $LANGUAGE
        StrCmp $LANGUAGE "cancel" 0 +2
                Abort
FunctionEnd

Function RegisterCapabilities
    !ifdef ___WINVER__NSH___
        ${If} ${AtLeastWinVista}
            ; even if we don't associate Falkon as default for ".htm" and ".html"
            ; we need to write these ProgIds for future use!
            ;(e.g.: user uses "Default Programs" on Win7 or Vista to set Falkon as default.)
            ${CreateProgId} "FalkonHTML" "$INSTDIR\falkon.exe" "Falkon HTML Document" "$INSTDIR\falkon.exe,1"
            ${CreateProgId} "FalkonURL" "$INSTDIR\falkon.exe" "Falkon URL" "$INSTDIR\falkon.exe,0"

            ; note: these lines just introduce capabilities of Falkon to OS and don't change defaults!
            WriteRegStr HKLM "${PRODUCT_CAPABILITIES_KEY}" "ApplicationDescription" "$(PRODUCT_DESC)"
            WriteRegStr HKLM "${PRODUCT_CAPABILITIES_KEY}" "ApplicationIcon" "$INSTDIR\falkon.exe,0"
            WriteRegStr HKLM "${PRODUCT_CAPABILITIES_KEY}" "ApplicationName" "${PRODUCT_NAME}"
            WriteRegStr HKLM "${PRODUCT_CAPABILITIES_KEY}\FileAssociations" ".htm" "FalkonHTML"
            WriteRegStr HKLM "${PRODUCT_CAPABILITIES_KEY}\FileAssociations" ".html" "FalkonHTML"
            WriteRegStr HKLM "${PRODUCT_CAPABILITIES_KEY}\URLAssociations" "http" "FalkonURL"
            WriteRegStr HKLM "${PRODUCT_CAPABILITIES_KEY}\URLAssociations" "https" "FalkonURL"
            WriteRegStr HKLM "${PRODUCT_CAPABILITIES_KEY}\URLAssociations" "ftp" "FalkonURL"
            WriteRegStr HKLM "${PRODUCT_CAPABILITIES_KEY}\Startmenu" "StartMenuInternet" "$INSTDIR\falkon.exe"
            WriteRegStr HKLM "SOFTWARE\RegisteredApplications" "${PRODUCT_NAME}" "${PRODUCT_CAPABILITIES_KEY}"
        ${EndIf}
    !endif
FunctionEnd

Function RunFalkonAsUser
    ${StdUtils.ExecShellAsUser} $0 "$INSTDIR\falkon.exe" "open" ""
FunctionEnd

Function un.onInit
    ReadRegStr $R0 ${PRODUCT_UNINST_ROOT_KEY}  "${PRODUCT_UNINST_KEY}" "InstallLocation"
    IfErrors +2 0
        StrCpy $INSTDIR "$R0"

    IfFileExists "$INSTDIR\falkon.exe" found
        MessageBox MB_OK|MB_ICONSTOP "$(MSG_InvalidInstallPath)"
        Abort
    found:
FunctionEnd
