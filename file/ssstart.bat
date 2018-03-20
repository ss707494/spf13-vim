@if not exist "%HOME%" @set HOME=%HOMEDRIVE%%HOMEPATH%
@echo off
start "" "%HOME%\.spf13-vim-3\app\AHK Script Manager\AHK Script Manager.a.lnk" /secondary /minimized
start "" "%HOME%\.spf13-vim-3\app\virgo\virgo.axe.lnk" /secondary /minimized
exit
