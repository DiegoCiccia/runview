; AutoIt v3 script to run a Stata help-file from an external text editor
; Version 1.0.0, 16 June 2024
; Friedrich Huebler, fhuebler@gmail.com, www.huebler.info
; Diego Ciccia, cicciadiego99@gmail.com

; Declare variables
Global $ini, $statapath, $statawin, $statacmd, $dofile, $clippause, $winpause, $keypause

; File locations
; Path to INI file
$ini = @ScriptDir & "\runview.ini"
; Path to Stata executable
$statapath = IniRead($ini, "Stata", "statapath", "C:\Program Files\Stata16")
; Title of Stata window
$statawin = IniRead($ini, "Stata", "statawin", "Stata/SE 16.1")

; Keyboard shortcut for Stata command window
$statacmd = IniRead($ini, "Stata", "statacmd", "^1")

; Path to do-file that is passed to AutoIt
; Edit line to match editor used, if necessary
$dofile = $CmdLine[1]

; Delays
; Pause after copying of Stata commands to clipboard
$clippause = IniRead($ini, "Delays", "clippause", "100")
; Pause between window-related operations
$winpause = IniRead($ini, "Delays", "winpause", "200")
; Pause between keystrokes sent to Stata
$keypause = IniRead($ini, "Delays", "keypause", "1")

; Set WinWaitDelay and SendKeyDelay to speed up or slow down script
Opt("WinWaitDelay", $winpause)
Opt("SendKeyDelay", $keypause)

; If more than one Stata window is open, the window that was most recently active will be matched
Opt("WinTitleMatchMode", 2)

; Check if Stata is already open, start Stata if not
If WinExists($statawin) Then
  WinActivate($statawin)
  WinWaitActive($statawin)
  ; Activate Stata command window and select text (if any)
  Send($statacmd)
  Send("^a")
  ; Run saved do-file
  ; Double quotes around $dofile needed in case path contains blanks
  ClipPut("view " & '"' & $dofile & '"')
  ; Pause avoids problem with clipboard, may be AutoIt or Windows bug
  Sleep($clippause)
  Send("^v" & "{Enter}")
Else
  Run($statapath)
  WinWaitActive($statawin)
  ; Activate Stata command window
  Send($statacmd)
  ; Run saved do-file
  ; Double quotes around $dofile needed in case path contains blanks
  ClipPut("view " & '"' & $dofile & '"')
  ; Pause avoids problem with clipboard, may be AutoIt or Windows bug
  Sleep($clippause)
  Send("^v" & "{Enter}")
EndIf

; End of script
