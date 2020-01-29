########################################################
##
## Activities.ps1
## Management interface to IQuipsys Positron
## User activities commands
##
#######################################################

function Read-IqsActivities
{
<#
.SYNOPSIS

Reads user activities

.DESCRIPTION

Gets a page of user activities that satisfy specified criteria

.PARAMETER Connection

A connection object

.PARAMETER Filter

A filter with search criteria (default: no filter)

.PARAMETER Skip

A number of records to skip (default: 0)

.PARAMETER Take

A number of records to return (default: 100)

.PARAMETER Total

A include total count (default: false)

.EXAMPLE

Get-IqsActivities -Filter @{ type="signin" }

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
        Read-PipActivities -Connection $Connection -Method "Get" -Uri "/api/v1/activities" -Filter $Filter -Skip $Skip -Take $Take
    }
    end {}
}


function Write-IqsActivity
{
<#
.SYNOPSIS

Writes user activity

.DESCRIPTION

Writes a single user activity

.PARAMETER Connection

A connection object

.PARAMETER Activity

An event to be written:
- id: string
- time: Date
- type: string
- party: ReferenceV1
    id: string
    type: string
    name: string
- ref_item: ReferenceV1
    id: string
    type: string
    name: string
- ref_parents: ReferenceV1[]
    id: string
    type: string
    name: string
- ref_party: ReferenceV1
    id: string
    type: string
    name: string
- details: any

.EXAMPLE

Write-IqsActivity -Activity @{ type="signin"; time=@(Get-Date); party=@{ id="1"; name="Test user" } }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Activity
    )
    begin {}
    process 
    {
        Write-PipActivity -Connection $Connection -Method "Post" -Uri "/api/v1/activities" -Activity $Activity
    }
    end {}
}
