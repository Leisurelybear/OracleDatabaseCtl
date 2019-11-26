@echo off 

::sc query OracleServiceORCL | find /i "STATE"
set state=" on"
for /F %%i in ('sc query OracleServiceORCL ^| find /i "STOPPED"') do ( 
	if %%i==STATE set state="off"
)

echo ##################################
echo ##### OracleDB_STATE : %state% #####
echo ##################################

echo Press any keys to START or STOP OracleDB Service!
echo Click "X" to cancel. 
pause > nul
::pause
sc config OracleServiceORCL start=demand
sc config OracleOraDb11g_home1TNSListener start=demand
sc config OracleMTSRecoveryService start=demand
sc config OracleJobSchedulerORCL start=demand
sc config OracleDBConsoleorcl start=demand
sc config OracleVssWriterORCL start=demand
if %state%=="off" goto start
if %state%==" on" goto stop
echo Error command! Please retry!
choice /t 1 /d y /n >nul
choice /t 1 /d y /n >nul
exit

:start
echo Starting Oracle DB...
choice /t 1 /d y /n >nul
sc start OracleServiceORCL
sc start OracleOraDb11g_home1TNSListener
sc start OracleMTSRecoveryService
sc start OracleJobSchedulerORCL
sc start OracleDBConsoleorcl
sc start OracleVssWriterORCL
echo "Service Oracle DB is started!"
choice /t 1 /d y /n >nul
choice /t 1 /d y /n >nul
exit

:stop
echo Stopping Oracle DB...
choice /t 1 /d y /n >nul
sc stop OracleServiceORCL
sc stop OracleOraDb11g_home1TNSListener
sc stop OracleMTSRecoveryService
sc stop OracleJobSchedulerORCL
sc stop OracleDBConsoleorcl
sc stop OracleVssWriterORCL
echo "Service Oracle DB is stopped."
choice /t 1 /d y /n >nul
choice /t 1 /d y /n >nul
exit
