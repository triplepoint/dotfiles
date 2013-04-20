@ECHO OFF

DOSKEY ls=DIR $*
DOSKEY cp=COPY $*
DOSKEY xcp=XCOPY $*
DOSKEY mv=MOVE $*
DOSKEY clear=CLS
DOSKEY h=DOSKEY /HISTORY
DOSKEY vboxmanage=VBoxManage $*
DOSKEY subl="C:\Program Files\Sublime Text 2\sublime_text.exe" $*

PATH=%PATH%;C:\Program Files\Oracle\VirtualBox;E:\Users\jhanson\bin;E:\Users\jhanson\bin\putty
