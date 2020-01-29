########################################################
##
## Statistics.ps1
## Management interface to IQuipsys Positron
## Statistics commands
##
#######################################################

function Get-IqsStatGroups
{
<#
.SYNOPSIS

Get groups from statistics

.DESCRIPTION

Gets a page of groups from statistics

.PARAMETER Connection

A connection object

.PARAMETER Skip

A number of records to skip (default: 0)

.PARAMETER Take

A number of records to return (default: 100)

.PARAMETER Total

A include total count (default: false)

.EXAMPLE

Get-IqsStatGroups

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$false, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [int] $Skip = 0,
        [Parameter(Mandatory=$false, Position = 1, ValueFromPipelineByPropertyName=$true)]
        [int] $Take = 100
    )
    begin {}
    process 
    {
        Get-PipStatGroups -Connection $Connection -Method "Get" -Uri "/api/v1/statistics/groups" -Skip $Skip -Take $Take
    }
    end {}
}


function Get-IqsStatCounters
{
<#
.SYNOPSIS

Get counters from statistics

.DESCRIPTION

Gets a page of counters from statistics that satisfy specified criteria

.PARAMETER Connection

A connection object

.PARAMETER Filter

A filter with search criteria (default: no filter)

.PARAMETER Skip

A number of records to skip (default: 0)

.PARAMETER Take

A number of records to return (default: 100)

.EXAMPLE

Get-IqsStatCounters

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$false, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Filter = @{},
        [Parameter(Mandatory=$false, Position = 1, ValueFromPipelineByPropertyName=$true)]
        [int] $Skip = 0,
        [Parameter(Mandatory=$false, Position = 2, ValueFromPipelineByPropertyName=$true)]
        [int] $Take = 100
    )
    begin {}
    process 
    {
        Get-PipStatCounters -Connection $Connection -Method "Get" -Uri "/api/v1/statistics/counters" -Filter $Filter -Skip $Skip -Take $Take
    }
    end {}
}


function Read-IqsStatCounter
{
<#
.SYNOPSIS

Gets set of counters values for specified time range

.DESCRIPTION

Gets value set for a counter or group of counterts at specified time horizon from/to time range

.PARAMETER Connection

A connection object

.PARAMETER Group

A counter group

.PARAMETER Counter

A counter name

.PARAMETER Type

A counter type - (0: Total, 1: Year, 2: Month, 3: Day, 4: Hour) (default: Total)

.PARAMETER From

A start of the time range

.PARAMETER To

An end of the time range

.EXAMPLE

Read-IqsStatCounter -Group test -Counter calls -Type "Hour" -From ([DateTime]::UtcNow.AddDays(-7)) -To ([DateTime]::UtcNow)

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $Group,
        [Parameter(Mandatory=$false, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $Counter,
        [Parameter(Mandatory=$false, Position = 2, ValueFromPipelineByPropertyName=$true)]
        [ValidateSet(0, 1, 2, 3, 4)]
        [int] $Type = 0,
        [Parameter(Mandatory=$false, Position = 3, ValueFromPipelineByPropertyName=$true)]
        [object] $From = [DateTime]::UtcNow.AddHours(-1),
        [Parameter(Mandatory=$false, Position = 4, ValueFromPipelineByPropertyName=$true)]
        [object] $To = [DateTime]::UtcNow
    )
    begin {}
    process 
    {
        Read-PipStatCounter -Connection $Connection -Method "Get" -Uri "/api/v1/statistics/{0}" -Group $Group -Counter $Counter -Type $Type -From $From -To $To
    }
    end {}
}


function Add-IqsStatCounter
{
<#
.SYNOPSIS

Increments statistics counter by provided value

.DESCRIPTION

Increments statistics counter by value, updates totals at all different time horizons

.PARAMETER Connection

A connection object

.PARAMETER Group

A counter group

.PARAMETER Counter

A counter name

.PARAMETER Time

An increment time (Default: current time)

.PARAMETER Timezone

A timezone to calculate stats (Default: UTC)

.PARAMETER Value

An increment value (Default: 1)

.EXAMPLE

Add-IqsStatCounter -Group test -Counter calls -Value 1

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $Group,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $Counter,
        [Parameter(Mandatory=$false, Position = 1, ValueFromPipelineByPropertyName=$true)]
        [DateTime] $Time = $null,
        [Parameter(Mandatory=$false, Position = 2, ValueFromPipelineByPropertyName=$true)]
        [string] $Timezone = $null,
        [Parameter(Mandatory=$false, Position = 3, ValueFromPipelineByPropertyName=$true)]
        [long] $Value = 1
    )
    begin {}
    process 
    {
        Add-PipStatCounter -Connection $Connection -Method "Post" -Uri "/api/v1/statistics/{0}/{1}" -Group $Group -Counter $Counter -Time $Time -Timezone $Timezone -Value $Value
    }
    end {}
}


function Read-IqsOrganizationStatCounter
{
<#
.SYNOPSIS

Gets set of counters values for specified time range on specified organization

.DESCRIPTION

Gets value set for a counter on organization of counterts at specified time horizon from/to time range

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A counter organization id

.PARAMETER Name

A counter name

.PARAMETER Type

A counter type - (0: Total, 1: Year, 2: Month, 3: Day, 4: Hour) (default: Total)

.PARAMETER From

A start of the time range

.PARAMETER To

An end of the time range

.EXAMPLE

Read-IqsOrganizationStatCounter -OrgId "123" -Name "params.321.all.online" -Type 4 -From "2019-01-02T21:00:00.000Z" -To "2019-01-03T20:59:00.000Z" -Timezone "Europe/Moscow"

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$false, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $Name,
        [Parameter(Mandatory=$false, Position = 2, ValueFromPipelineByPropertyName=$true)]
        [ValidateSet(0, 1, 2, 3, 4)]
        [int] $Type = 0,
        [Parameter(Mandatory=$false, Position = 3, ValueFromPipelineByPropertyName=$true)]
        [object] $From = [DateTime]::UtcNow.AddHours(-1),
        [Parameter(Mandatory=$false, Position = 4, ValueFromPipelineByPropertyName=$true)]
        [object] $To = [DateTime]::UtcNow,
        [Parameter(Mandatory=$false, Position = 5, ValueFromPipelineByPropertyName=$true)]
        [object] $Timezone = "Europe/Moscow"
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/statistics/{1}" -f $OrgId, $Name

        $params = @{
            type = $Type
            from_time = $From
            to_time = $To
            timezone = $Timezone
        }

        $result = Invoke-PipFacade -Connection $Connection -Method "Get" -Route $route -Params $params
        
        Write-Output $result
    }
    end {}
}


function Add-IqsOrganizationStatCounter
{
<#
.SYNOPSIS

Increments statistics counter by provided value

.DESCRIPTION

Increments statistics counter by value, updates totals at all different time horizons

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A counter organization id

.PARAMETER Name

A counter name

.PARAMETER Time

An increment time (Default: current time)

.PARAMETER Timezone

A timezone to calculate stats (Default: UTC)

.PARAMETER Value

An increment value (Default: 1)

.EXAMPLE

Add-IqsStatCounter -OrgId "123" -Name "params.321.all.speed" -Value 1

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $Name,
        [Parameter(Mandatory=$false, Position = 1, ValueFromPipelineByPropertyName=$true)]
        [DateTime] $Time = $null,
        [Parameter(Mandatory=$false, Position = 2, ValueFromPipelineByPropertyName=$true)]
        [string] $Timezone = $null,
        [Parameter(Mandatory=$false, Position = 3, ValueFromPipelineByPropertyName=$true)]
        [long] $Value = 1
    )
    begin {}
    process 
    {
        Add-PipStatCounter -Connection $Connection -Method "Post" -Uri "/api/v1/organizations/{0}/statistics/{1}" -Group $OrgId -Counter $Name -Time $Time -Timezone $Timezone -Value $Value
    }
    end {}
}