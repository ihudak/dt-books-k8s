@ECHO OFF
CLS
ECHO.
ECHO ==============================================

SET BATCH_DIR=%~dp0
SET JAR_FILE=build\libs\*0.0.1-SNAPSHOT.jar

SET PREFIX=dt-books-
SET DT_JAVA_AGENT=%PREFIX%java-agents
SET DT_NO_AGENT=%PREFIX%noagents
SET DT_GUI=%PREFIX%gui

SET DT_PROJECTS[0]=clients
SET DT_PROJECTS[1]=books
SET DT_PROJECTS[2]=cart
SET DT_PROJECTS[3]=storage
SET DT_PROJECTS[4]=orders
SET DT_PROJECTS[5]=ratings
SET DT_PROJECTS[6]=payment
SET DT_PROJECTS[7]=dynapay
SET DT_PROJECTS[8]=dataloader

cd %BATCH_DIR%\..\%DT_JAVA_AGENT%
ECHO ============ Building Agents =================
CALL push_docker.bat
timeout 3
cd %BATCH_DIR%\..\%DT_NO_AGENT%
ECHO ============ Building NoAgent ================
CALL push_docker.bat
timeout 3
cd %BATCH_DIR%\..\%DT_GUI%
ECHO ============= Building GUI ===================
CALL push_docker.bat
timeout 3

ECHO ============= Building Java Projects ===================
setlocal ENABLEDELAYEDEXPANSION
SET "x=0"
:SymLoop
if defined DT_PROJECTS[%x%] (
    SET PROJ=!!DT_PROJECTS[%x%]!!
    SET PROJ_DIR=..\%PREFIX%!PROJ!
    CD %BATCH_DIR%\!PROJ_DIR!
    if not exist %JAR_FILE% (
        ECHO ===================== BUILDING !PROJ! ... ========================
        CALL .\gradlew.bat clean build
        timeout 3
    ) else (
        ECHO.
        ECHO No Gradle build is needed for !PROJ! . File exists: %JAR_FILE%
        ECHO.
    )
    CALL %BATCH_DIR%\push_docker.bat !PROJ! -noagent
    timeout 3
    CALL %BATCH_DIR%\push_docker.bat !PROJ! -agents
    timeout 3
    CALL %BATCH_DIR%\push_docker.bat !PROJ! -noagent -arm
    timeout 3
    CALL %BATCH_DIR%\push_docker.bat !PROJ! -agents -arm
    timeout 3
    SET /a "x+=1"
    GOTO :SymLoop
)
