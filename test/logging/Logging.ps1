Import-Module iqs-scripts-management-ps

$conn =  Connect-IqsFacade  -Host '192.168.99.100' -Port 8080 -Login "iqs@admin.com" -Password "iqs2020#"

try 
{
    [Object[]]$activities = Read-IqsActivities
    Write-Host "Readed all activities"
    Write-Output $activities

    $env:TEST_PASSED = "true"
}
catch 
{
    $ErrorMessage = $_.Exception.Message
    Write-Host "Test failed with error: $ErrorMessage"
    exit 1
}