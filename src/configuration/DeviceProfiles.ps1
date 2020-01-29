########################################################
##
## DeviceProfiles.ps1
## Management interface to IQuipsys Positron
## DeviceProfiles commands
##
#######################################################


function Get-IqsBaseDeviceProfiles
{
<#
.SYNOPSIS

Gets all base device profiles

.DESCRIPTION

Gets all base device profiles

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.EXAMPLE

Get-IqsBaseDeviceProfiles -OrgId 1

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/devices/profiles/base" -f $OrgId

        $result = Invoke-PipFacade -Connection $Connection -Method "Get" -Route $route

        Write-Output $result
    }
    end {}
}

function Get-IqsDeviceProfiles
{
<#
.SYNOPSIS

Gets page with device profiles by specified criteria

.DESCRIPTION

Gets a page with device profiles that satisfy specified criteria

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Filter

A filter with search criteria (default: no filter)

.PARAMETER Skip

A number of records to skip (default: 0)

.PARAMETER Take

A number of records to return (default: 100)

.PARAMETER Total

A include total count (default: false)

.EXAMPLE

Get-IqsDeviceProfiles -OrgId 1 -Filter @{ search="234" } -Take 10

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$false, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Filter = @{},
        [Parameter(Mandatory=$false, Position = 2, ValueFromPipelineByPropertyName=$true)]
        [int] $Skip = 0,
        [Parameter(Mandatory=$false, Position = 3, ValueFromPipelineByPropertyName=$true)]
        [int] $Take = 100,
        [Parameter(Mandatory=$false, Position = 4, ValueFromPipelineByPropertyName=$true)]
        [bool] $Total
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/devices/profiles" -f $OrgId

        $params = $Filter +
        @{ 
            skip = $Skip;
            take = $Take
            total = $Total
        }

        $result = Invoke-PipFacade -Connection $Connection -Method "Get" -Route $route -Params $params

        Write-Output $result.Data
    }
    end {}
}


function Get-IqsDeviceProfile
{
<#
.SYNOPSIS

Gets device profile by id

.DESCRIPTION

Gets device profile by its unique id

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Id

A device id

.EXAMPLE

Get-IqsDeviceProfile -OrgId 1 -Id 123

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
        $route = "/api/v1/organizations/{0}/devices/profiles/{1}" -f $OrgId, $Id

        $result = Invoke-PipFacade -Connection $Connection -Method "Get" -Route $route
        
        Write-Output $result
    }
    end {}
}


function New-IqsDeviceProfile
{
<#
.SYNOPSIS

Creates a new device profile

.DESCRIPTION

Creates a new device profile

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Profile

A device profile with the following structure:
- id: string
- org_id: string
- name: string
- base_profile_id: string
- parameters: SensorParameter[]
- events: SensorEvent[]
- commands: ActuatorComman[]

.EXAMPLE

New-IqsDeviceProfile -OrgId 1 -Profile @{ org_id="1"; base_profile_id="smartphone"; name="test" }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Profile
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/devices/profiles" -f $OrgId

        $result = Invoke-PipFacade -Connection $Connection -Method "Post" -Route $route -Request $Profile
        
        Write-Output $result
    }
    end {}
}


function Update-IqsDeviceProfile
{
<#
.SYNOPSIS

Updates a device profile

.DESCRIPTION

Updates a device profile

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Profile

A device profile with the following structure:
- id: string
- org_id: string
- base_profile_id: string
- parameters: SensorParameter[]
- events: SensorEvent[]
- commands: ActuatorComman[]

.EXAMPLE

Update-IqsDeviceProfile -OrgId 1 -Profile @{ id="123"; org_id="1"; base_profile_id="smartphone"; name="test1"; parameters=@{type="gas_level"; min_value=0; max_value=100} }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Profile
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/devices/profiles/{1}" -f $OrgId, $Profile.id

        $result = Invoke-PipFacade -Connection $Connection -Method "Put" -Route $route -Request $Profile
        
        Write-Output $result
    }
    end {}
}


function Remove-IqsDeviceProfile
{
<#
.SYNOPSIS

Removes device profile by id

.DESCRIPTION

Removes device profile by its unique id

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Id

A device id

.EXAMPLE

Remove-IqsDeviceProfile -OrgId 1 -Id 123

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
        $route = "/api/v1/organizations/{0}/devices/profiles/{1}" -f $OrgId, $Id

        $result = Invoke-PipFacade -Connection $Connection -Method "Delete" -Route $route
        
        Write-Output $result
    }
    end {}
}
