@echo off
:: pone la ip y mascara que se le pasa o vuelve a dhcp 

setlocal enabledelayedexpansion
chcp 1250>nul
rem >>>cambiar siguiente linea si tarjeta de red tiene otro nombre <<<<<
set conex="Ethernet"
::set conex="Conexión de área local"
chcp 850>nul

net session >nul  2>&1
if NOT "%1"=="" (
if not %errorLevel% == 0 ( 
   echo Deteniendo script. No se ha ejecutado como administrador ^^!^^!
   exit /B 
)
)

if "%1"=="" (
  cls
  ECHO RED nueva_ip [nueva_mascara [puerta_enlace]] 
  ECHO                              :cambia ip de adaptador de red %conex%
  ECHO                               si se omite mascara se usa  255.255.255.0
  echo.                              si se omite puerta enlace se dejara en blanco 
  echo.  
  ECHO RED dhcp                     :activa dhcp de adaptador de red %conex%
  echo.
  ECHO RED                          :muestra esta ayuda 
  echo.
  ECHO NOTA1: Este script debe ejecutarse como administrador^^!^^!
  echo.
  ECHO NOTA2: Configurado para el adaptador de nombre %conex%. Si es otro, editar codigo
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
echo Cambio efectuado. Esperando 5 seg. para confirmar
timeout 5 >nul
netsh interface ip show addresses %conex%
pause