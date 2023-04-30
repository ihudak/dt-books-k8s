@ECHO OFF
CLS
ECHO.
ECHO ==============================================

SET BATCH_DIR=%~dp0
SET PREFIX=dt-books-

SET DT_PROJECTS[0]=clients
SET DT_PROJECTS[1]=books
SET DT_PROJECTS[2]=cart
SET DT_PROJECTS[3]=storage
SET DT_PROJECTS[4]=orders
SET DT_PROJECTS[5]=ratings
SET DT_PROJECTS[6]=payment
SET DT_PROJECTS[7]=dynapay
SET DT_PROJECTS[8]=dataloader

ECHO ============= Building Projects ===================
setlocal ENABLEDELAYEDEXPANSION
SET "x=0"
:SymLoop
if defined DT_PROJECTS[%x%] (
    SET PROJ=!!DT_PROJECTS[%x%]!!
    SET PROJ_DIR=..\%PREFIX%!PROJ!
    CD %BATCH_DIR%\!PROJ_DIR!
    ECHO ===================== BUILDING !PROJ! ... ========================
    CALL .\gradlew.bat clean build
    timeout 3
    SET /a "x+=1"
    GOTO :SymLoop
)
