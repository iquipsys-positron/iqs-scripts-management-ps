########################################################
##
## Attendance.ps1
## Management interface to IQuipsys Positron
## Attendance commands
##
#######################################################


function Get-IqsAttendances
{
<#
.SYNOPSIS

Gets page with attendances by specified criteria

.DESCRIPTION

Gets a page with attendances that satisfy specified criteria

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

Get-IqsAttendances -OrgId 1 -Filter @{ from_time="2017-01-01T00:00:00Z" } -Take 10

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
        $route = "/api/v1/organizations/{0}/attendance" -f $OrgId

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


function Get-IqsAttendancesWithinTime
{
<#
.SYNOPSIS

Gets attendances within specified time interval

.DESCRIPTION

Gets attendances within specified time interval

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER FromTime

Start of the time interval

.PARAMETER ToTime

End of the time interval

.EXAMPLE

Get-IqsAttendancesWithinTime -OrgId 1 -FromTime="2017-01-01T00:00:00Z" -ToTime="2017-01-02T00:00:00Z" 

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$false, Position = 1, ValueFromPipelineByPropertyName=$true)]
        [datetime] $FromTime,
        [Parameter(Mandatory=$false, Position = 2, ValueFromPipelineByPropertyName=$true)]
        [datetime] $ToTime
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/attendance/within_time" -f $OrgId

        $params = $Filter +
        @{ 
            from_time = $FromTime;
            to_time = $ToTime
        }

        $result = Invoke-PipFacade -Connection $Connection -Method "Get" -Route $route -Params $params

        Write-Output $result
    }
    end {}
}


function Add-IqsAttendance
{
<#
.SYNOPSIS

Adds attendace to organization attendaces

.DESCRIPTION

Adds attendance to organization attendances

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Attendance

An attendance with the following structure:
- org_id: string
- object_id: string
- start_time: Date
- end_time: Date

.EXAMPLE

Add-IqsAttendance -OrgId 1 -Attendance @{ org_id="1"; object_id="1"; start_time=$(Get-Date) }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Attendance
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/attendance" -f $OrgId

        $result = Invoke-PipFacade -Connection $Connection -Method "Post" -Route $route -Request $Attendance
        
        Write-Output $result
    }
    end {}
}

function Add-IqsAttendances
{
<#
.SYNOPSIS

Adds multiple attendances

.DESCRIPTION

Adds several attendances to organization attendances

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Attendances

An attendance with the following structure:
- org_id: string
- object_id: string
- start_time: Date
- end_time: Date

.EXAMPLE

Add-IqsAttendance -OrgId 1 -Attendances @( @{ org_id="1"; object_id="1"; start_time=$(Get-Date) }, ... )

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object[]] $Attendances
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/attendance/batch" -f $OrgId

        $result = Invoke-PipFacade -Connection $Connection -Method "Post" -Route $route -Request $Attendances
        
        Write-Output $result
    }
    end {}
}

function Remove-IqsAttendances
{
<#
.SYNOPSIS

Removes attendances by filter

.DESCRIPTION

Removes attendances that match specified filter

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Filter

A filter with search criteria (default: no filter)

.EXAMPLE

Remove-IqsAttendance -OrgId 1 -Filter @{ from_time=${Get-Date} }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$false, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Filter = @{}
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/attendance" -f $OrgId

        $result = Invoke-PipFacade -Connection $Connection -Method "Delete" -Route $route -Params $Filter
        
        Write-Output $result
    }
    end {}
}