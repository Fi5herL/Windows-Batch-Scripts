@echo off
set "source=%cd%"
set "destination=%cd%"

set /p "extractFiles=Do you want to extract all files? (Y/N): "
if /i "%extractFiles%"=="Y" (
    if exist "C:\Program Files\7-Zip\7z.exe" (
        for /R "%source%" %%F in (*.zip) do (
            "C:\Program Files\7-Zip\7z.exe" x "%%F" -o"%destination%" -y
        )
        echo All files have been extracted.
    ) else (
        echo 7-Zip software not found. Please install 7-Zip or update the software path.
    )
) else (
    echo Files have not been extracted.
)

set /p "moveFiles=Do you want to move all folder files? (Y/N): "
if /i "%moveFiles%"=="Y" (
    for /R "%source%" %%F in (*) do (
        for %%P in ("%%F\..") do (
            if /i not "%%~nxP"=="_V" (
                move "%%F" "%destination%"
                echo Moved file: "%%F"
            )
        )
    )
    echo All files have been moved.
) else (
    echo Files have not been moved.
)

set /p "deleteEmptyFolders=Do you want to delete empty folders? (Y/N): "
if /i "%deleteEmptyFolders%"=="Y" (
    for /f "delims=" %%D in ('dir /s /b /ad "%source%" ^| findstr /v "_V" ^| sort /r') do (
        rd "%%D" 2>nul
        echo Deleted folder: "%%D"
    )
    echo Empty folders have been deleted.
) else (
    echo Empty folders have not been deleted.
)