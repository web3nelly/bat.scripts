@echo off
setlocal enabledelayedexpansion

rem Prompt the user for the source drive
set /p "sourceDrive=Enter the source drive (e.g., C:): "

rem Prompt the user for the destination drive
set /p "destinationDrive=Enter the destination drive (e.g., X:): "

rem Check if the source drive exists
if not exist "%sourceDrive%\" (
    echo Source drive does not exist.
    pause
    exit /b 1
)

rem Check if the destination drive exists
if not exist "%destinationDrive%\" (
    echo Destination drive does not exist.
    pause
    exit /b 1
)

rem Loop through user profiles
for /d %%A in ("%sourceDrive%\Users\*") do (
    set "userFolder=%%~nxA"
    set "sourceFolder=%%A"
    set "destinationFolder=!destinationDrive!\Users\!userFolder!"

    rem Check if the source folder exists
    if exist "!sourceFolder!" (
        echo Copying files for user: !userFolder!
        
        rem Create the destination folder if it doesn't exist
        if not exist "!destinationFolder!" (
            mkdir "!destinationFolder!"
        )

        rem Copy the user's files (excluding some system folders)
        robocopy "!sourceFolder!" "!destinationFolder!" /mir /xd "AppData" "Cookies" "Local Settings" /xf "ntuser.*" /r:0 /w:0
    ) else (
        echo User folder not found: !userFolder!
    )
)

echo Copy operation completed.
pause
