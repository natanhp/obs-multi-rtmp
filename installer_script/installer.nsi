OutFile "obs-multi-rtmp-setup.exe"

Unicode true
RequestExecutionLevel user

SetDatablockOptimize on
SetCompress auto
SetCompressor /SOLID lzma

Name "obs-multi-rtmp"
Caption "Multiple RTMP Output Plugin for OBS Studio"
Icon "${NSISDIR}\Contrib\Graphics\Icons\win-install.ico"

Var /Global DefInstDir
Function .onInit
    ReadEnvStr $0 "ALLUSERSPROFILE"
    StrCpy $DefInstDir "$0\obs-studio\plugins\obs-multi-rtmp"
    StrCpy $INSTDIR "$DefInstDir"

    IfFileExists "$DefInstDir\*.*" AskUninst DontAskUninst
    AskUninst:
        MessageBox MB_YESNO|MB_ICONQUESTION "Uninstall obs-multi-rtmp?" IDYES DoUninst IDNO NotDoUninst
    DoUninst:
        RMDir /r "$DefInstDir"
        MessageBox MB_OK|MB_ICONINFORMATION "Done."
        Quit
    NotDoUninst:
    DontAskUninst:
FunctionEnd

Function onDirPageLeave
StrCmp "$INSTDIR" "$DefInstDir" DirNotModified DirModified
DirModified:
MessageBox MB_OK|MB_ICONSTOP "Please don't change the install directory."
Abort
DirNotModified:
FunctionEnd

Page directory "" "" onDirPageLeave
Page instfiles

Section
SetOutPath "$INSTDIR\bin\32bit"
File "plugins\obs-multi-rtmp\bin\32bit\obs-multi-rtmp.dll"

SetOutPath "$INSTDIR\bin\64bit"
File "plugins\obs-multi-rtmp\bin\64bit\obs-multi-rtmp.dll"

SetOutPath "$INSTDIR\data\locale"
File "plugins\obs-multi-rtmp\data\locale\*.ini"
SectionEnd

Section "Uninstaller"
RMDir /r /REBOOTOK "$INSTDIR\plugins\obs-multi-rtmp"
SectionEnd
