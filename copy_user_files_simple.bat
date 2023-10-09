@echo off
setlocal enabledelayedexpansion

rem Set the source and destination drives
set "sourceDrive=C:"
set "destinationDrive=X:"

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
