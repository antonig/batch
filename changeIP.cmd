@echo off
:: Saves you from navigating to the Net Adapter Settings dialog to change the IP address
::  for tests  by Antoni Gual
:: Must be run as Admin
:: Before use set the conex variable to the name of the net adapter you intend to change 
::
setlocal enabledelayedexpansion
chcp 1250>nul

rem >>>set next line according to the Windows name of the Adapter in your pc<<<<<
set conex="Ethernet"

chcp 850>nul
net session >nul  2>&1
if NOT "%1"=="" (
if not %errorLevel% == 0 ( 
   echo Stopping. Please run me as Admin ^^!^^!
   exit /B 
)
)

if "%1"=="" (
  cls
  ECHO changeIP new_ip [new_mask [new_default_gw]] 
  ECHO                              :Changes ip of the net adapter %conex%
  ECHO                               if new_mask is omitted it defaults to 255.255.255.0
  echo.                              if new_default_gw is omitted it wil be left blank
  echo.  
  ECHO changeIP dhcp                :sets the %conex% adapter to Use dhcp
  echo.
  ECHO RED                          :shows this help
  echo.
  ECHO NOTE: This script must be run with Admin privileges ^^!^^!
  echo.
  echo.
  pause
  exit /B 
 
) else ( 
   if /I "%1"=="DHCP" (
     netsh interface ip set address %conex% dhcp 
)  else (
     if not "%2"=="" ( set mask=%2 ) else ( set mask=255.255.255.0 ) 
     netsh interface ip set address %conex% static %1 !mask!  %3
)

)
echo Change done. Waiting 5 seg. to confirm settings
timeout 5 >nul
netsh interface ip show addresses %conex%
pause