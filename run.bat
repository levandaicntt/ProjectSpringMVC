@echo off
echo =============================
echo  Compiling Spring MVC Project
echo =============================

cd /d D:\ProjectSpringMVC

REM Compile tất cả .java trong src
javac -encoding UTF-8 -cp "WebContent\WEB-INF\lib\*;." ^
 -d WebContent\WEB-INF\classes ^
 src\com\demo\controller\*.java

echo =============================
echo  Copy WebContent to Tomcat
echo =============================

xcopy WebContent "D:\apache-tomcat-10.1.46-windows-x64\apache-tomcat-10.1.46\webapps\ProjectSpringMVC" /E /Y >nul

echo =============================
echo  Starting Tomcat
echo =============================

cd /d D:\apache-tomcat-10.1.46-windows-x64\apache-tomcat-10.1.46\bin
startup.bat

echo DONE!
pause
