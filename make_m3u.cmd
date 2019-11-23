@echo off
::crea fichero indice m3u para CoolPlayer
setlocal 
cd  /d "%~dp0"

for /R /D  %%i in (*.*) do (
  echo %%i 
   if  NOT exist "%%i\x.m3u" (
      if exist "%%i\*.mp3" dir "%%i\*.mp3" /b > "%%i\m.m3u" 
      if exist "%%i\*.ogg" dir "%%i\*.mp3" /b > "%%i\o.m3u" 
      if exist "%%i\*.flac" dir "%%i\*.flac" /b > "%%i\f.m3u" 
      if exist "%%i\*.wma" dir "%%i\*.wma" /b > "%%i\w.m3u"    
   )
)
endlocal
pause
