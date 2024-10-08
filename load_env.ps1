# Load the .env file into environment variables
Get-Content .env | ForEach-Object {
    if ($_ -match '^\s*#') { return } # Ignore comments
    if ($_ -match '^\s*$') { return } # Ignore empty lines
    $parts = $_ -split '=', 2
    [System.Environment]::SetEnvironmentVariable($parts[0], $parts[1])
}
