setlocal enabledelayedexpansion
if not exist 99-logo md 99-logo
if not exist 99-logo md input
if not exist 99-logo md output
for %%X in (ffmpeg.exe) do (
  set directori=%%~dpX\
  )
  echo logo to array
for /R 99-logo/ %%X in (*.*) do (
  set /A n+=1
  set logos[!n!]=%%~dpnxX
  )
set b=%n%
set /A reset=%b%
set list=0
echo work imagens jpg png
setlocal enabledelayedexpansion
for /R "input/" %%X in (*.jpg, *.png) do (
  set output=%%~nxX
  set input=%%X
  set /A a+=1
  if "%%~xX"==".jpg" (call :jpgconv)
 //if "%%~xX"==".mp4" (call :videoconv)
  )
  )
goto end
:jpgconv

echo converting with logo arrays
 if %reset% LEQ %list% (set list=1) Else (set /A list=%list%+1)
 set logo=!logos[%list%]!
 set /A a+=1
 if %a%==100 (set a=1)
 ffmpeg -i "%input%" -i "%logo%" -y -filter_complex "[0:v]scale=-1:1500[logo0]; [1:v]scale=50:50[logo1]; [logo0][logo1] overlay=x=%a%" -q:v 0 -huffman optimal "Output/%output%"

goto end

//:videoconv
 //if %reset% LEQ %list% (set list=1) Else (set /A list=%list%+1)
 //set logo=!logos[%list%]!
 //If Exist "pruebas/%output%" (goto end)
 //set /A a+=1
 //if %a%==100 (set a=1)
 //ffmpeg -i "%input%" -i "%logo%" -filter_complex "[1:v]scale=4:4[logo1]; [0:v][logo1] overlay=x=%a%" -qscale 0 -huffman optimal "Output/%output0%"
:end

