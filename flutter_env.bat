@echo off
REM === Set Java 17 khusus untuk Flutter ===
set JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-17.0.15.6-hotspot
set PATH=%JAVA_HOME%\bin;%PATH%

echo ========================================
echo JAVA_HOME sudah di-set ke JDK 17
java -version
echo ========================================

REM === Aktifkan SDK Manager / Flutter ===
cmd
