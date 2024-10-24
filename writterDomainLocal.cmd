@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    ECHO --------------------------------------------------------
    ECHO This Program Created For Get Domain Name For Flask App by EvstiAl 2024 Github @EvstiAL
    ECHO --------------------------------------------------------
    ECHO Enter This Script With Administration Privilegies.
    PAUSE
    EXIT /B
)


:MENU
title WritterDomainLocal WINDOWS
CLS
ECHO --------------------------------------------------------
ECHO This Program Created For Get Domain Name For Flask App by EvstiAl 2024 Github @EvstiAL
ECHO --------------------------------------------------------
ECHO ===========================
ECHO         MENU
ECHO ===========================
ECHO [1] AISSERVERHOSTS WRITE
ECHO [2] Custom domain record
ECHO [3] Deleting an entry from hosts
ECHO [4] Open HOSTS File
ECHO [5] Exit
ECHO ===========================

SET /P choice=Enter the desired menu item (1-5): 

IF "%choice%"=="1" GOTO AISSERVERHOSTS
IF "%choice%"=="2" GOTO CUSTOM_DOMAIN
IF "%choice%"=="3" GOTO DELETE_ENTRY
IF "%choice%"=="4" GOTO OPEN_HOSTS
IP "%choice"=="5" GOTO EXIT

ECHO ERROR Retry Again.
PAUSE
GOTO MENU

:AISSERVERHOSTS
SET HOSTS_FILE=%WINDIR%\System32\drivers\etc\hosts
ECHO -------- AISSERVERHOSTS WRITE -----------
SET  IP_ADDRESS=10.69.180.230:5000
SET  DOMAIN_NAME=eisschool41.sc41
ECHO --------------------------------------------------------
FINDSTR /C:"%DOMAIN_NAME%" "%HOSTS_FILE%" > NUL
IF %ERRORLEVEL% NEQ 0 (
    ECHO %IP_ADDRESS% %DOMAIN_NAME% >> "%HOSTS_FILE%"
    ECHO Write "%IP_ADDRESS% %DOMAIN_NAME%" go to hosts.
) ELSE (
    ECHO Write "%DOMAIN_NAME%" Already GEt hosts.
)
PAUSE
GOTO MENU






:CUSTOM_DOMAIN
SET HOSTS_FILE=%WINDIR%\System32\drivers\etc\hosts
ECHO -------- Custom domain record. --------------------
SET /p IP_ADDRESS=Enter IP Address(Example:192.168.1.10):
SET /p DOMAIN_NAME=Enter DomainName(example:myflaskapp.local):
ECHO --------------------------------------------------------
FINDSTR /C:"%DOMAIN_NAME%" "%HOSTS_FILE%" > NUL
IF %ERRORLEVEL% NEQ 0 (
    ECHO %IP_ADDRESS% %DOMAIN_NAME% >> "%HOSTS_FILE%"
    ECHO Write "%IP_ADDRESS% %DOMAIN_NAME%" go to hosts.
) ELSE (
    ECHO Write "%DOMAIN_NAME%" Already GEt hosts.
)
PAUSE
GOTO MENU




:DELETE_ENTRY
SET HOSTS_FILE=%WINDIR%\System32\drivers\etc\hosts
ECHO ---------------- Deleting an entry from hosts. ------------------
REM Запрос доменного имени для удаления
SET /p DOMAIN_NAME=Enter the domain name you want to delete: 

REM Проверка существования записи
FINDSTR /C:"%DOMAIN_NAME%" "%HOSTS_FILE%" > NUL
IF %ERRORLEVEL% NEQ 0 (
    ECHO Write "%DOMAIN_NAME%" is not exists hosts.
) ELSE (
    REM Создание временного файла для записи
    SET TEMP_FILE=%TEMP%\hosts_temp.txt
    (
        REM Копирование всех строк, кроме удаляемой
        FOR /F "delims=" %%i IN ('type "%HOSTS_FILE%"') DO (
            SET LINE=%%i
            IF NOT "!LINE!"=="%DOMAIN_NAME%" (
                ECHO !LINE! >> "%TEMP_FILE%"
            )
        )
    )
    
    REM Замена оригинального файла hosts на временный файл
    MOVE /Y "%TEMP_FILE%" "%HOSTS_FILE%"
    ECHO Write "%DOMAIN_NAME%" sucsess delete hosts.
)
PAUSE
GOTO MENU


:OPEN_HOSTS
START "" "%SystemRoot%\System32\notepad.exe" "%HOSTS_FILE%"
PAUSE
GOTO MENU




:EXIT
ECHO Exit...
ENDLOCAL
EXIT