;;
;; An autohotkey script that provides emacs-like keybinding on Windows
;;
#InstallKeybdHook
#UseHook
;SendMode Play

; The following line is a contribution of NTEmacs wiki http://www49.atwiki.jp/ntemacs/pages/20.html
SetKeyDelay 0

; turns to be 1 when ctrl-x is pressed
is_pre_x = 0
; turns to be 1 when ctrl-space is pressed
is_pre_spc = 0

; Applications you want to disable emacs-like keybindings
; (Please comment out applications you don't use)
is_target()
{
  IfWinActive,ahk_class ConsoleWindowClass ; Cygwin
    Return 1 
;  IfWinActive,ahk_class MEADOW ; Meadow
;    Return 1 
;  IfWinActive,ahk_class cygwin/x X rl-xterm-XTerm-0
;    Return 1
;  IfWinActive,ahk_class MozillaUIWindowClass ; keysnail on Firefox
;    Return 1
  ; Avoid VMwareUnity with AutoHotkey
;  IfWinActive,ahk_class VMwareUnityHostWndClass
;    Return 1
;  IfWinActive,ahk_class Vim ; GVIM
;    Return 1
;  IfWinActive,ahk_class SWT_Window0 ; Eclipse
;    Return 1
;   IfWinActive,ahk_class Xming X
;     Return 1
;   IfWinActive,ahk_class SunAwtFrame
;     Return 1
;   IfWinActive,ahk_class Emacs ; NTEmacs
;     Return 1  
;   IfWinActive,ahk_class XEmacs ; XEmacs on Cygwin
;     Return 1
  IfWinActive,ahk_class VTWin32 ; Teraterm
    Return 1
  IfWinActive,ahk_class mintty  ; BoW10
    Return 1
  IfWinActive,ahk_class Chrome_WidgetWin_1
  IfWinActive,	ahk_exe Code.exe ; VSCode
    Return 1
  IfWinActive,ahk_class Chrome_WidgetWin_1 ; Google Chrome
    Return 0
  Return 0
}

delete_char()
{
  Send {Del}
  global is_pre_spc = 0
  Return
}
delete_backward_char()
{
  Send {BS}
  global is_pre_spc = 0
  Return
}
kill_line()
{
  Send {ShiftDown}{END}{SHIFTUP}
  Sleep 50 ;[ms] this value depends on your environment
  Send ^x
  global is_pre_spc = 0
  Return
}
open_line()
{
  Send {END}{Enter}{Up}
  global is_pre_spc = 0
  Return
}
quit()
{
  Send {ESC}
  global is_pre_spc = 0
  Return
}
newline()
{
  Send {Enter}
  global is_pre_spc = 0
  Return
}
indent_for_tab_command()
{
  Send {Tab}
  global is_pre_spc = 0
  Return
}
newline_and_indent()
{
  Send {Enter}{Tab}
  global is_pre_spc = 0
  Return
}
isearch_forward()
{
  Send ^f
  global is_pre_spc = 0
  Return
}
isearch_backward()
{
  Send ^f
  global is_pre_spc = 0
  Return
}
kill_region()
{
  Send ^x
  global is_pre_spc = 0
  Return
}
kill_ring_save()
{
  Send ^c
  global is_pre_spc = 0
  Return
}
yank()
{
  Send ^v
  global is_pre_spc = 0
  Return
}
undo()
{
  Send ^z
  global is_pre_spc = 0
  Return
}
find_file()
{
  Send ^o
  global is_pre_x = 0
  Return
}
save_buffer()
{
  Send, ^s
  global is_pre_x = 0
  Return
}
;kill_emacs()
;{
;  Send !{F4}
;  global is_pre_x = 0
;  Return
;}

move_beginning_of_line()
{
  global
  if is_pre_spc
    Send +{HOME}
  Else
    Send {HOME}
  Return
}
move_end_of_line()
{
  global
  if is_pre_spc
    Send +{END}
  Else
    Send {END}
  Return
}
previous_line()
{
  global
  if is_pre_spc
    Send +{Up}
  Else
    Send {Up}
  Return
}
next_line()
{
  global
  if is_pre_spc
    Send +{Down}
  Else
    Send {Down}
  Return
}
forward_char()
{
  global
  if is_pre_spc
    Send +{Right}
  Else
    Send {Right}
  Return
}
backward_char()
{
  global
  if is_pre_spc
    Send +{Left} 
  Else
    Send {Left}
  Return
}
scroll_up()
{
  global
  if is_pre_spc
    Send +{PgUp}
  Else
    Send {PgUp}
  Return
}
scroll_down()
{
  global
  if is_pre_spc
    Send +{PgDn}
  Else
    Send {PgDn}
  Return
}
;;;; iTunes
prev(){
     IfWinExist, ahk_class iTunes
     ControlSend, ahk_parent, ^{LEFT}
}
next(){
     IfWinExist, ahk_class iTunes
     ControlSend, ahk_parent, ^{RIGHT}
}
sound_up(){
     IfWinExist, ahk_class iTunes
     ControlSend, ahk_parent, ^{Up}
}
sound_down(){
     IfWinExist, ahk_class iTunes
     ControlSend, ahk_parent, ^{Down}
}

^x::
  If is_target()
    Send %A_ThisHotkey%
  Else
    is_pre_x = 1
  Return 
^f::
  If is_target()
    Send %A_ThisHotkey%
  Else
  {
    If is_pre_x
      find_file()
    Else
      forward_char()
  }
  Return  
;^c::
;  If is_target()
;    Send %A_ThisHotkey%
;  Else
;  {
;    If is_pre_x
;      kill_emacs()
;  }
;  Return  
^d::
  If is_target()
    Send %A_ThisHotkey%
  Else
    delete_char()
  Return
^h::
  If is_target()
    Send %A_ThisHotkey%
  Else
    delete_backward_char()
  Return
^k::
  If is_target()
    Send %A_ThisHotkey%
  Else
    kill_line()
  Return
;; ^o::
;;   If is_target()
;;     Send %A_ThisHotkey%
;;   Else
;;     open_line()
;;   Return
;^g::
;  If is_target()
;    Send %A_ThisHotkey%
;  Else
;    quit()
;  Return
;; ^j::
;;   If is_target()
;;     Send %A_ThisHotkey%
;;   Else
;;     newline_and_indent()
;;   Return
^m::
  If is_target()
    Send %A_ThisHotkey%
  Else
    newline()
  Return
^i::
  If is_target()
    Send %A_ThisHotkey%
  Else
    indent_for_tab_command()
  Return
;^s::
;  If is_target()
;    Send %A_ThisHotkey%
;  Else
;  {
;    If is_pre_x
;      save_buffer()
;    Else
;      isearch_forward()
;  }
;  Return
^r::
  If is_target()
    Send %A_ThisHotkey%
  Else
    isearch_backward()
  Return
;^w::
;  If is_target()
;    Send %A_ThisHotkey%
;  Else
;    kill_region()
;  Return
;!w::
;  If is_target()
;    Send %A_ThisHotkey%
;  Else
;    kill_ring_save()
;  Return
^y::
  If is_target()
    Send %A_ThisHotkey%
  Else
    yank()
  Return
^/::
  If is_target()
    Send %A_ThisHotkey%
  Else
    undo()
  Return  
  
;$^{Space}::
;^vk20sc039::
;  If is_target()
;    Send {CtrlDown}{Space}{CtrlUp}
;  Else
;  {
;    If is_pre_spc
;      is_pre_spc = 0
;    Else
;      is_pre_spc = 1
;  }
;  Return
^@::
  If is_target()
    Send %A_ThisHotkey%
  Else
  {
    If is_pre_spc
      is_pre_spc = 0
    Else
      is_pre_spc = 1
  }
  Return
^a::
  If is_target()
    Send %A_ThisHotkey%
  Else
    move_beginning_of_line()
  Return
^e::
  If is_target()
    Send %A_ThisHotkey%
  Else
    move_end_of_line()
  Return
^p::
  If is_target()
    Send %A_ThisHotkey%
  Else
    previous_line()
  Return
^n::
  If is_target()
    Send %A_ThisHotkey%
  Else
    next_line()
  Return
^b::
  If is_target()
    Send %A_ThisHotkey%
  Else
    backward_char()
  Return
^v::
  If is_target()
    Send %A_ThisHotkey%
  Else
    scroll_down()
  Return
!v::
  If is_target()
    Send %A_ThisHotkey%
  Else
    scroll_up()
  Return
;; Suspend
;^j::
Scrolllock::
  Suspend , Toggle
  Return
;; Paste instead of ^v
;^y::
;  yank()
;  Return


;;;; Show Calendar
;#c::
;  Send, #b
;  Loop, 9
;  {
;    Send, {Right}
;  }
;  Send, {Space}
;  Return


;;;; Global volume
;; Change Volume
^NumpadAdd::
  Send,{Volume_Up 1}
  SoundPlay,*64
  Return
^NumpadSub::
  Send,{Volume_Down 1}
  SoundPlay,*64
  Return
^NumpadMult::
  Send,{Volume_Mute}
  SoundPlay,*64
  Return

;;;; iTunes control
^Up::
  sound_up()
  Return
^Down::
  sound_down()
  Return
;; Play, Pause
^NumpadEnter::
  Send,{Media_Play_Pause}
  Return
;; Preview, Nest
^Left::
  prev()
  Return
^Right::
  next()
  Return

;;;; hhkb
;; Kana/Hira -> Esc
sc070::Send,{sc001}

;; Shift+Space -> Zenkaku/Hankaku
+Space::Send,{vkF3sc029}
  Return

;; Ctrl+Shift+Space -> Half-Space
^+Space::Send,+{Space}
  Return

;;;; Microsoft Ergonomics Mouse
RWin::Send,!{Right}
      Return
;RWin::S4end,{vkF3sc029}
;   Return


;;;; Muhenkan -> hankaku/zenkaku
;sc07B::Send,{sc029}
;       Return

;;;; chattering canceler
$MButton::
    If (A_PriorHotkey = A_ThisHotKey && A_TimeSincePriorHotkey < 70){
    }
    else{
      Send,{MButton}
    }
    Return

;;;; For Office
+WheelUp:: ; Shift+MouseWheelUp
  If WinActive("ahk_exe EXCEL.EXE")
  {
    SetScrollLockState, On
    SendInput {Left}
    SetScrollLockState, Off
  }
  Else If WinActive("ahk_exe POWERPNT.EXE")
  {
    Send {WheelLeft}
  }
  Else
  {
    MouseGetPos,,,id, fcontrol,1
    Loop 10
    SendMessage, 0x114, 0, 0, %fcontrol%, ahk_id %id%
  }
Return

+WheelDown:: ; Shift+MouseWheelDown
  If WinActive("ahk_exe EXCEL.EXE")
  {
    SetScrollLockState, On
    SendInput {Right}
    SetScrollLockState, Off
  }
  Else If WinActive("ahk_exe POWERPNT.EXE")
  {
    Send {WheelLeft}
  }
  Else
  {
    MouseGetPos,,,id, fcontrol,1
    Loop 10
    SendMessage, 0x114, 0, 0, %fcontrol%, ahk_id %id%
  }
Return



;;;; For Powershell
#IfWinActive, ahk_class ConsoleWindowClass ; Powershell
{
  ^a::SendInput {HOME}
  ^e::SendInput {END}
  ^u::SendInput {ESC}
  ^p::SendInput {Up}
  ^n::SendInput {Down}
  ^l::SendInput {ESC}cls{ENTER}
  ^k::SendInput {F4}
  ^f::SendInput {right}
  ^b::SendInput {left}
  ^h::SendInput {BS}
  Return
}

;;;; For Cubase and Studio One
scroll_left(){
  #If WinActive("ahk_class SteinbergWindowClass") || WinActive("ahk_class CCLWindowClass") || WinActive("ahk_class CCLShadowWindowClass")
  ;ControlSend, ahk_parent, +WheelDown
  Send,+{WheelDown}
}
scroll_right(){
  #If WinActive("ahk_class SteinbergWindowClass") || WinActive("ahk_class CCLWindowClass") || WinActive("ahk_class CCLShadowWindowClass")
  ;ControlSend, ahk_parent, +WheelUp
  Send,+{WheelUp}
}
; Shift + WheelUp   : scroll left
+WheelUp::
  ;scroll_left()
  scroll_right()
  Return
; Shift + WheelDown : scroll right
+WheelDown::
  ;scroll_right()
  scroll_left()
  Return


;;;; For Studio One
vscaling_up(){
  #If WinActive("ahk_class CCLWindowClass") || WinActive("ahk_class CCLShadowWindowClass")
  ;ControlSend, ahk_parent, ^WheelDown
  Send,^{WheelDown}
}
vscaling_down(){
  #If WinActive("ahk_class CCLWindowClass") || WinActive("ahk_class CCLShadowWindowClass")
  ;ControlSend, ahk_parent, ^WheelUp
  Send,^{WheelUp}
}
hscaling_up(){
  #If WinActive("ahk_class CCLWindowClass") || WinActive("ahk_class CCLShadowWindowClass")
  ;ControlSend, ahk_parent, ^+WheelDown
  Send,^+{WheelDown}
}
hscaling_down(){
  #If WinActive("ahk_class CCLWindowClass") || WinActive("ahk_class CCLShadowWindowClass")
  ;ControlSend, ahk_parent, ^+WheelUp
  Send,^+{WheelUp}
}

;; Shift + Ctrl + WheelUp   : vertical scaling down
^+WheelUp::
  vscaling_down()
  Return
;; Shift + Ctrl + WheelDown : vertical scaling up
^+WheelDown::
  vscaling_up()
  Return
;; Ctrl + WheelUp   : horizontal scaling down
^WheelUp::
  hscaling_down()
  Return
;; Ctrl + WheelDown : horizontal scaling up
^WheelDown::
  hscaling_up()
  Return
