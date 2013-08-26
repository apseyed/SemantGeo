@ECHO off

:: Change these variables to reflect your file system
set semantecoannotator=C:\Users\student\Documents\GitHub\SemantEco\annotator-webapp
set semantecoannotatorfacet=C:\Users\student\Documents\GitHub\SemantEco\facets\annotator
set tomcat=C:\Users\student\Documents\apache-tomcat-7.0.37\

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: You should not need to change anything below this point ::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

echo ==========================================
echo = Running Deploy Script - Skipping Tests =
echo ==========================================

:: Kill tomcat server if it is running
cd /d %tomcat%bin\
call shutdown.bat

:: Build using maven (js, css, etc)
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

:: Build using maven (index.jsp)
cd /d %semantecoannotatorfacet%
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
rmdir annotator /s /q
del semanteco.war /F
del annotator.war /F

:: Initiate tomcat server so we can push new servlet to it
cd /d %tomcat%bin\
call startup.bat -Xmx1024m -Xms256m

:: Wait for server to start before calling deploy
echo =======================================================================
echo = Starting Tomcat Server. I will wait for 5 seconds and then continue =
echo =======================================================================
ping 192.0.2.2 -n 1 -w 5000 > nul

:: Deploy our built project as a servlet to the Tomcat server
cd /d %semantecoannotator%\
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
::start http://localhost:8080/semanteco/resources/annotator/SemantEcoAnnotator.html
start http://localhost:8080/annotator/

:: Echo out that we are done
echo.
echo ==============================
echo = Done running deploy script =
echo ==============================

:: Wait for user input to quit (debug)
::pause >nul
