@ECHO off

:: Change these variables to reflect your system
set semantecoannotator=C:\Users\student\Documents\GitHub\SemantEco\facets\annotator\
set semantaqua=C:\Users\student\Documents\GitHub\SemantEco\
set tomcat=C:\Users\student\Desktop\apache-tomcat-7.0.37\

echo ==========================================
echo = Running Deploy Script - Skipping Tests =
echo ==========================================

:: Kill tomcat server if it is running
cd /d %tomcat%bin\
call shutdown.bat

:: Build using maven
cd /d %semantecoannotator%
call mvn clean install -fail-fast -DskipTests
if not "%ERRORLEVEL%" == "0" (
	cd /d %~dp0
	echo .
	echo =====================================
	echo = !!!!!!!! COMPILE FAILURE !!!!!!!! =
	echo =====================================
	pause > nul
	exit /b
)

:: Delete old compiled servlet
cd /d %tomcat%webapps\
rmdir semanteco /s /q
del semanteco.war /F

:: Initiate tomcat server so we can push new servlet to it
cd /d %tomcat%bin\
call startup.bat -Xmx1024m -Xms256m

:: Wait for server to start before calling deploy
echo =======================================================================
echo = Starting Tomcat Server. I will wait for 5 seconds and then continue =
echo =======================================================================
ping 192.0.2.2 -n 1 -w 5000 > nul

:: Deploy our built project as a servlet to the Tomcat server
cd /d %semantaqua%webapp\
call mvn clean tomcat7:deploy -DskipTests
if not "%ERRORLEVEL%" == "0" (
	cd /d %~dp0
	echo .
	echo ====================================
	echo = !!!!!!!! DEPLOY FAILURE !!!!!!!! =
	echo ====================================
	pause > nul
	exit /b
)

:: Return to original directory (for conveinence)
cd /d %~dp0

:: Start up webview for the annotator
start http://localhost:8080/semanteco/resources/annotator/SemantEcoAnnotator.html

:: Echo out that we are done
echo.
echo ==============================
echo = Done running deploy script =
echo ==============================

:: Wait for user input to quit (debug)
::pause >nul
