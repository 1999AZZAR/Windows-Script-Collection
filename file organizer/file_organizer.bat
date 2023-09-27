@echo off
setlocal enabledelayedexpansion

REM Get the folder where this script is located as the source directory
for %%I in ("%~dp0.") do set "sourceDirectory=%%~fI"

REM Define the active and archive directories
set "activeDirectory=C:\Destination\Active"
set "archiveDirectory=C:\Destination\Archive"

REM Set the threshold for file age in days (default is 45 days)
set "daysThreshold=45"

REM Get the current date in a format that can be used for comparison
for /f "tokens=1-3 delims=/ " %%a in ('echo %date%') do (
    set "currentDate=%%c-%%a-%%b"
)

REM Loop through files in the source directory
for %%f in ("%sourceDirectory%\*.*") do (
    REM Get the file extension (including the dot)
    set "fileExtension=%%~xf"

    REM Determine the file type category using the Assoc command
    for /f "tokens=2 delims==" %%i in ('assoc !fileExtension!') do (
        set "fileCategory=%%i"
    )

    REM Check if the file type category is recognized, if not, move to "Other"
    if not defined fileCategory (
        set "fileCategory=Other"
    )

    REM Construct the destination directory path based on the category
    set "destinationDirectory=!activeDirectory!\!fileCategory!"

    REM Check file age and move to archive if older than the threshold
    set "moveToArchive=false"
    set "ageInDays="
    for /f "usebackq tokens=1,2 delims==" %%a in (`wmic os get LocalDateTime /value`) do (
        if "%%a"=="LocalDateTime" set "fileDate=%%b"
    )
    set "fileDate=!fileDate:~0,8!"
    set /a "ageInDays=(!currentDate:~0,4!-!fileDate:~0,4!)*365+(!currentDate:~4,2!-!fileDate:~4,2!)*30+!currentDate:~6,2!-!fileDate:~6,2!"
    
    if !ageInDays! gtr %daysThreshold% (
        set "destinationDirectory=!archiveDirectory!\!fileCategory!"
        set "moveToArchive=true"
    )

    REM Create the destination directory if it doesn't exist
    if not exist "!destinationDirectory!" (
        mkdir "!destinationDirectory!"
    )

    REM Move the file to the appropriate directory
    move "%%f" "!destinationDirectory!"

    REM Optionally, log the file movement
    echo Moved "%%f" to "!destinationDirectory!" at !date! !time!

    REM Optionally, display a completion message
    if !moveToArchive! (
        echo File archived: "%%f"
    ) else (
        echo File organized: "%%f"
    )
)

REM Add more conditions and actions as needed

REM Display a completion message
echo File organization complete.
pause
