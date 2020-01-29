########################################################
##
## DeviceConfigs.ps1
## Management interface to IQuipsys Positron
## DeviceConfigs commands
##
#######################################################


function Get-IqsDeviceConfig
{
<#
.SYNOPSIS

Gets device config by id

.DESCRIPTION

Gets device config by its unique id

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Id

A device id

.EXAMPLE

Get-IqsDeviceConfig -OrgId 1 -Id 123

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $Id
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/devices/configs/{1}" -f $OrgId, $Id

        $result = Invoke-PipFacade -Connection $Connection -Method "Get" -Route $route
        
        Write-Output $result
    }
    end {}
}

function Set-IqsDeviceConfig
{
<#
.SYNOPSIS

Sets a device config

.DESCRIPTION

Sets a device config

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Config

A device config with the following structure:
- id: string
- org_id: string
- sent_time: Date
- receive_time: Date
- params: ConfigParameterValue[]

.EXAMPLE

Set-IqsDeviceConfig -OrgId 1 -Config @{ id="123"; org_id="1"; params=@( @{id=1; val=111} ) }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Config
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/devices/configs/{1}" -f $OrgId, $Config.id

        $result = Invoke-PipFacade -Connection $Connection -Method "Post" -Route $route -Request $Config
        
        Write-Output $result
    }
    end {}
}


function Remove-IqsDeviceConfig
{
<#
.SYNOPSIS

Removes device config by id

.DESCRIPTION

Removes device config by its unique id

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Id

A device id

.EXAMPLE

Remove-IqsDeviceConfig -OrgId 1 -Id 123

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $Id
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/devices/configs/{1}" -f $OrgId, $Id

        $result = Invoke-PipFacade -Connection $Connection -Method "Delete" -Route $route
        
        Write-Output $result
    }
    end {}
}

function Request-IqsDeviceConfig
{
<#
.SYNOPSIS

Requests device config by id to be retrieved from physical device

.DESCRIPTION

Requests device config by its unique id

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Id

A device id

.EXAMPLE

Request-IqsDeviceConfig -OrgId 1 -Id 123

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $Id
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/devices/configs/{1}/request" -f $OrgId, $Id

        $result = Invoke-PipFacade -Connection $Connection -Method "Post" -Route $route
        
        Write-Output $result
    }
    end {}
}

function Send-IqsDeviceConfig
{
<#
.SYNOPSIS

Saves a device config and sends it to physical device 

.DESCRIPTION

Sends a device config

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Config

A device config with the following structure:
- id: string
- org_id: string
- sent_time: Date
- receive_time: Date
- params: ConfigParameterValue[]

.EXAMPLE

Send-IqsDeviceConfig -OrgId 1 -Config @{ id="123"; org_id="1"; params=@( @{id=1; val=111} ) }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Config
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/devices/configs/{1}/send" -f $OrgId, $Config.id

        $result = Invoke-PipFacade -Connection $Connection -Method "Post" -Route $route -Request $Config
        
        Write-Output $result
    }
    end {}
}

function Receive-IqsDeviceConfig
{
<#
.SYNOPSIS

Saves a device config received from physical device

.DESCRIPTION

Receives a device config

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Config

A device config with the following structure:
- id: string
- org_id: string
- sent_time: Date
- receive_time: Date
- params: ConfigParameterValue[]

.EXAMPLE

Receive-IqsDeviceConfig -OrgId 1 -Config @{ id="123"; org_id="1"; params=@( @{id=1; val=111} ) }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Config
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/devices/configs/{1}/receive" -f $OrgId, $Config.id

        $result = Invoke-PipFacade -Connection $Connection -Method "Post" -Route $route -Request $Config
        
        Write-Output $result
    }
    end {}
}
