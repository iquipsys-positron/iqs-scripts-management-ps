########################################################
##
## RestGateway.ps1
## Management interface to IQuipsys Positron
## REST gateway commands
##
#######################################################

function Send-IqsStatusUpdate
{
<#
.SYNOPSIS

Sends status update message

.DESCRIPTION

Sends device status update through REST gateway. The device shall be registered at least for one organization

.PARAMETER Connection

A connection object

.PARAMETER Message

A status update message

.EXAMPLE

Send-IqsStatusUpdate -Message @{ device_udi="+15202250000"; lat=32.01; lng=-110.22; alt=720; angle=45; speed=30; quality=2; pressed=false }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Message
    )
    begin {}
    process 
    {
        $route = "/api/v1/gateway/update_status"

        $null = Invoke-PipFacade -Connection $Connection -Method "POST" -Route $route -Request $Message
    }
    end {}
}
