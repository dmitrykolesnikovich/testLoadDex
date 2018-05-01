echo on

SET PREV_PATH=%CD%
cd /d %0\..

rmdir "bin" /S /Q
mkdir "bin" || goto EXIT
mkdir "bin\dex" || goto EXIT

REM Define android.jar
SET ANDROID_JAR=%ANDROID_HOME%\platforms\android-26\android.jar

REM Define aapt
SET ANDROID_AAPT="%ANDROID_HOME%\build-tools\25.0.3\aapt.exe"

REM Define aapt pack and generate resources command
SET ANDROID_AAPT_PACK=%ANDROID_AAPT% package -v -f -I %ANDROID_JAR%

REM Define dx
SET ANDROID_DX="%ANDROID_HOME%\build-tools\25.0.3\dx.bat"  --dex

REM Define Java compiler command
SET JAVAC=javac.exe -source 1.7 -target 1.7 -classpath "%ANDROID_JAR%;..\testLoadDex\testLoadDex1\target\classes"
SET JAVAC_BUILD=%JAVAC% -sourcepath "src" -d "bin"

REM Compile sources. All *.class files will be put into the bin folder
call %JAVAC_BUILD% src\testLoadDex2\*.java || goto EXIT

REM Generate dex files with compiled Java classes
call %ANDROID_DX% --output="%CD%\bin\dex\classes.dex" %CD%\bin || goto EXIT

REM Generate apk
call cd bin
call %ANDROID_AAPT_PACK% -F testLoadDex2.jar dex
call cd ..

:EXIT
cd "%PREV_PATH%"
ENDLOCAL
exit /b %ERRORLEVEL%
