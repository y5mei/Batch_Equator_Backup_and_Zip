REM ===============    COPY AND BACKUP RESULT FILES     =================
REM =====Mar. 6 2020 Yaowen Mei Quality Specialist  Stackpole PMDA=======
REM =====================================================================
REM =====================================================================

REM =============Setup the current dirctory and the parent directory=====
set currentdir=%CD%
cd..
set parentdir=%CD%
cd %currentdir%

Rem ==========================SETUP Sourcefile dirctory===================
REM =====================Sourcefile = where you want to copy from=========
REM =Copyfromfile=where the Zeiss Calypso merge file master copy is stored
Rem ============ABSOLUTLY NO SPACE BEFORE ANY EQUAL SIGN==================
REM Set "Sourcefile=C:\Renishaw\Programs\GF9 Clutch Hub\outputs\"
REM Set "Copyfromfile=C:\result Master Copy\"
Set "Sourcefile=%parentdir%\OUTPUTS\"

Rem =================================SETUP TIME============================
@echo off
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"

set "datestamp=%YYYY%%MM%%DD%" & set "timestamp=%HH%%Min%%Sec%"
set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"
echo datestamp: "%datestamp%"
rem echo timestamp: "%timestamp%"
rem echo fullstamp: "%fullstamp%"
rem echo backupfilename: "%datestamp:~0,4%-%datestamp:~4,2%-%datestamp:~-2%-Backup"
Set Backupfilename="%datestamp:~0,4%-%datestamp:~4,2%-%datestamp:~-2%-M09875Backup"

Rem ===========================BACKUP WITH 7ZIP===========================
REM ===================SWITCH -R FOR SUBDIRECTORY, -SDEL for delete=======
"%CD%\App\7-Zip\7z.exe" a "%parentdir%\Backup Folder\%Backupfilename%.7z" "%Sourcefile%" -r

Rem =====================Delete the result files=======================
CD "%Sourcefile%"

DEL *.RTF /S /Q
DEL *.OUT /S /Q
DEL *.RES /S /Q

Rem ===========================Put Merge file back for Zeiss CMM==========
REM copy "%Copyfromfile%*.txt" "%Sourcefile%"
REM @pause
