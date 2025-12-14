@echo off
setlocal
title Run Spring MVC - Local JDK + Tomcat 10

rem =============================
rem  CẤU HÌNH ĐƯỜNG DẪN TƯƠNG ĐỐI
rem =============================

rem Thư mục chứa run.bat = gốc project
set "BASE_DIR=%~dp0"
set "PROJECT_DIR=%BASE_DIR%"

rem JDK đặt trong tools\jdk
set "JDK_DIR=%BASE_DIR%tools\jdk"

rem Tomcat 9 đặt trong tools\tomcat
set "TOMCAT_DIR=%BASE_DIR%tools\tomcat"

rem Tên app khi deploy vào webapps
set "WEBAPP_NAME=ProjectSpringMVC"

rem =============================
rem  CHỌN JDK LOCAL
rem =============================
set "JAVA_HOME=%JDK_DIR%"
set "JRE_HOME=%JDK_DIR%"
set "PATH=%JAVA_HOME%\bin;%PATH%"

echo PROJECT_DIR = %PROJECT_DIR%
echo JDK_DIR     = %JDK_DIR%
echo TOMCAT_DIR  = %TOMCAT_DIR%
echo WEBAPP_NAME = %WEBAPP_NAME%
echo.

echo Java version dung de build:
java -version
echo.

rem =============================
rem  COMPILE SOURCE
rem =============================

cd /d "%PROJECT_DIR%"

echo [1/3] Compiling Java source...

"%JAVA_HOME%\bin\javac" -encoding UTF-8 ^
  -cp "WebContent\WEB-INF\lib\*;." ^
  -d "WebContent\WEB-INF\classes" ^
  src\com\demo\controller\*.java

if errorlevel 1 (
  echo.
  echo !!! Compile FAILED. Kiem tra lai loi o tren.
  pause
  exit /b 1
)

echo Compile OK.
echo.

rem =============================
rem  COPY WEBCONTENT -> TOMCAT
rem =============================

echo [2/3] Copy WebContent to Tomcat...

rmdir /S /Q "%TOMCAT_DIR%\webapps\%WEBAPP_NAME%" 2>nul
xcopy "WebContent" "%TOMCAT_DIR%\webapps\%WEBAPP_NAME%" /E /I /Y >nul

echo Copy OK.
echo.

rem =============================
rem  RESTART TOMCAT
rem =============================

echo [3/3] Restart Tomcat...

echo Go to: "%TOMCAT_DIR%\bin"
cd /d "%TOMCAT_DIR%\bin" || (
    echo !!!
    echo Khong vao duoc thu muc bin cua Tomcat. Kiem tra lai TOMCAT_DIR trong run.bat
    pause
    exit /b 1
)

call shutdown.bat >nul 2>&1
ping 127.0.0.1 -n 3 >nul
call startup.bat

echo.
echo DONE!
echo Open: http://localhost:8080/%WEBAPP_NAME%/
echo.

pause
endlocal