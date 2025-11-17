@echo off
title Run Spring MVC - Tomcat 10 (old folder)

rem =============================
rem  CẤU HÌNH ĐƯỜNG DẪN
rem =============================

rem Thư mục project Spring MVC (thư mục cũ bạn đang dùng)
set PROJECT_DIR=D:\ProjectSpringMVC

rem Thư mục Tomcat 10 (đúng như bạn đã gửi trước đó)
set TOMCAT_DIR=D:\apache-tomcat-10.1.46-windows-x64\apache-tomcat-10.1.46

rem Tên app khi deploy vào webapps
set WEBAPP_NAME=ProjectSpringMVC

echo PROJECT_DIR = %PROJECT_DIR%
echo TOMCAT_DIR  = %TOMCAT_DIR%
echo WEBAPP_NAME = %WEBAPP_NAME%
echo.

rem =============================
rem  COMPILE SOURCE
rem =============================

cd /d "%PROJECT_DIR%"

echo [1/3] Compiling Java source...

javac -encoding UTF-8 ^
  -cp "WebContent\WEB-INF\lib\*;." ^
  -d WebContent\WEB-INF\classes ^
  src\com\demo\controller\*.java

if errorlevel 1 (
  echo.
  echo !!! Compile FAILED. Kiểm tra lại lỗi ở trên.
  pause
  exit /b 1
)

echo Compile OK.
echo.

rem =============================
rem  COPY WEBCONTENT -> TOMCAT
rem =============================

echo [2/3] Copy WebContent to Tomcat...

rem Xoá app cũ (nếu có)
rmdir /S /Q "%TOMCAT_DIR%\webapps\%WEBAPP_NAME%" 2>nul

xcopy "WebContent" "%TOMCAT_DIR%\webapps\%WEBAPP_NAME%" /E /I /Y >nul

echo Copy OK.
echo.

rem =============================
rem  RESTART TOMCAT 10
rem =============================

echo [3/3] Restart Tomcat 10...

cd /d "%TOMCAT_DIR%\bin"

call shutdown.bat >nul 2>&1
ping 127.0.0.1 -n 3 >nul
call startup.bat

echo.
echo DONE!
echo Open: http://localhost:8080/%WEBAPP_NAME%/
echo.

pause
