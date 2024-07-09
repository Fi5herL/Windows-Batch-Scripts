@echo off
setlocal enabledelayedexpansion

set "source=%cd%"
set "dateString=%date:/=-%"
set "timeString=%time::=-%"
set "versionFolder=%source%\_V%dateString%_%timeString%"

echo Enter version comment:
set /p "comment="

rem Check if _log.txt already exists
set "versionRecord=%source%\_log.txt"
echo Version Folder: _V%dateString%_%timeString% >> "%versionRecord%"
echo Comment: %comment% >> "%versionRecord%"
echo ------ >> "%versionRecord%"

rem Create version folder
md "%versionFolder%"

rem Backup files and folders
rem /xf _* 參數指定要排除以 "" 開頭的檔案，/xd _* 參數指定要排除以 "" 開頭的資料夾。
rem robocopy "%source%" "%versionFolder%" /s /xf _V* /xd _V*
robocopy "%source%" "%versionFolder%" /s /xd _V*

echo Copy completed.

echo Backup completed.
pause
