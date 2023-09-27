# Get the folder where this script is located as the source directory
$sourceDirectory = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition

# Define the active and archive directories
$activeDirectory = "C:\Destination\Active"
$archiveDirectory = "C:\Destination\Archive"

# Set the threshold for file age in days (default is 45 days)
$daysThreshold = 45

# Get the current date in a format that can be used for comparison
$currentDate = Get-Date -Format "yyyy-MM-dd"

# Loop through files in the source directory
Get-ChildItem -Path $sourceDirectory | ForEach-Object {
    # Get the file extension (including the dot)
    $fileExtension = $_.Extension

    # Determine the file type category using the Assoc command
    $fileCategory = [System.IO.Path]::GetExtension($_.FullName)

    # Check if the file type category is recognized, if not, move to "Other"
    if (-not $fileCategory) {
        $fileCategory = "Other"
    }

    # Construct the destination directory path based on the category
    $destinationDirectory = Join-Path -Path $activeDirectory -ChildPath $fileCategory

    # Check file age and move to archive if older than the threshold
    $moveToArchive = $false
    $fileDate = Get-Date $_.CreationTime -Format "yyyy-MM-dd"
    $ageInDays = (Get-Date $currentDate).Subtract([DateTime]::ParseExact($fileDate, "yyyy-MM-dd", $null)).Days

    if ($ageInDays -gt $daysThreshold) {
        $destinationDirectory = Join-Path -Path $archiveDirectory -ChildPath $fileCategory
        $moveToArchive = $true
    }

    # Create the destination directory if it doesn't exist
    if (-not (Test-Path -Path $destinationDirectory -PathType Container)) {
        New-Item -Path $destinationDirectory -ItemType Directory | Out-Null
    }

    # Move the file to the appropriate directory
    Move-Item -Path $_.FullName -Destination $destinationDirectory

    # Optionally, log the file movement
    Write-Output "Moved $($_.FullName) to $destinationDirectory at $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"

    # Optionally, display a completion message
    if ($moveToArchive) {
        Write-Output "File archived: $($_.FullName)"
    } else {
        Write-Output "File organized: $($_.FullName)"
    }
}

# Add more conditions and actions as needed

# Display a completion message
Write-Output "File organization complete."
