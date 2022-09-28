:: prime generator using a sorted multiples list stored in a priority queue
:: uses the environment as the priority queue, limited to maxprime 100000
:: from a problem in Knuth's TAOCP
:: Be warned it will crash when the environment size reaches 64K!!

@echo off
setlocal enabledelayedexpansion 
set path=
mode con cols=90
set @25=-10
set /a num=7,inc1=4,cnt=0,inc2=0,num1=0, maxprime=65535
set lin=    0:       2       3       5

:nextnum
if defined @%num% ( 
  for %%i in (!@%num%!) do (
   
    set /a n2=num1*num1
    if !n2! leq %maxprime%  (  if %%i lss 0  (set /a num1=%num%-%%i,"inc2=-%%i<<1") else (set /a num1=%num%+%%i,"inc2=-(%%i>>1)")
    for %%j in (@!num1!) do  set %%j=!inc2! !%%j! )
    )
  set @%num%=
)else (
  set num2=       %num%
  set lin=%lin%!num2:~-8!
  if not "!lin:~80,1!" equ "" (
    echo !lin! 
    set /a cnt+=10
    set cnt1=    !cnt!
    set lin=!cnt1:~-5!:
  )
  
  if %inc1% equ 4 (set/a "inc2=num<<2") else (set /a "inc2=-(num<<1)")
  set @!num1!=!inc2! 
)
set /a num+=inc1, inc1=6-inc1
if %num% lss %maxprime% goto nextnum
echo %lin%
pause
exit /b
