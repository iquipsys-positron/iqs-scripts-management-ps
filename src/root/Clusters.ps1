########################################################
##
## Clusters.ps1
## Management interface to IQuipsys Positron
## Clusters commands
##
#######################################################


function Get-IqsClusters
{
<#
.SYNOPSIS

Gets page with clusters by specified criteria

.DESCRIPTION

Gets a page with clusters that satisfy specified criteria

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

Get-IqsClusters -Filter @{ active=$true } -Take 10

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
        [int] $Take = 100,
        [Parameter(Mandatory=$false, Position = 3, ValueFromPipelineByPropertyName=$true)]
        [bool] $Total
    )
    begin {}
    process 
    {
        $route = "/api/v1/clusters"

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


function Get-IqsCluster
{
<#
.SYNOPSIS

Gets cluster by id

.DESCRIPTION

Gets cluster by its unique id

.PARAMETER Connection

A connection object

.PARAMETER Id

A cluster id

.EXAMPLE

Get-IqsCluster -Id 123

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $Id
    )
    begin {}
    process 
    {
        $route = "/api/v1/clusters/{0}" -f $Id

        $result = Invoke-PipFacade -Connection $Connection -Method "Get" -Route $route
        
        Write-Output $result
    }
    end {}
}

function Get-IqsClusterByOrganization
{
<#
.SYNOPSIS

Gets cluster by organization id

.DESCRIPTION

Gets cluster by organization unique id

.PARAMETER Connection

A connection object

.PARAMETER Id

A organization id

.EXAMPLE

Get-IqsClusterByOrganization -Id 123

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId
    )
    begin {}
    process 
    {
        $route = "/api/v1/clusters/organization/{0}" -f $OrgId

        $result = Invoke-PipFacade -Connection $Connection -Method "Get" -Route $route
        
        Write-Output $result
    }
    end {}
}

function New-IqsCluster
{
<#
.SYNOPSIS

Creates a new cluster

.DESCRIPTION

Creates a new cluster

.PARAMETER Connection

A connection object

.PARAMETER Cluster

A cluster with the following structure:
- id: string;
- name: string;
- type: string - root or organizations
- active: boolean
- master_nodes?: string[]
- slave_nodes?: string[]
- api_host?: string
- service_ports: object[]
- maintenance?: boolean
- version?: string
- update_time?: Date
- max_organizations_count?: number
- organizations_count?: number
- open?: boolean
- active_organizations?: string[]
- inactive_organizations?: string[]

.EXAMPLE

New-IqsCluster -Cluster @{ name="Test cluster"; type="organizations"; active=$true; max_organizations_count=2; organizations_count=1; }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Cluster
    )
    begin {}
    process 
    {
        $route = "/api/v1/clusters"

        $result = Invoke-PipFacade -Connection $Connection -Method "Post" -Route $route -Request $Cluster
        
        Write-Output $result
    }
    end {}
}


function Update-IqsCluster
{
<#
.SYNOPSIS

Creates a new cluster

.DESCRIPTION

Creates a new cluster

.PARAMETER Connection

A connection object

.PARAMETER Cluster

A cluster with the following structure:
- id: string;
- name: string;
- type: string - root or organizations
- active: boolean
- master_nodes?: string[]
- slave_nodes?: string[]
- api_host?: string
- service_ports: object[]
- maintenance?: boolean
- version?: string
- update_time?: Date
- max_organizations_count?: number
- organizations_count?: number
- open?: boolean
- active_organizations?: string[]
- inactive_organizations?: string[]

.EXAMPLE

Update-IqsCluster -Cluster @{ name="Test cluster"; type="organizations"; active=$true; max_organizations_count=2; organizations_count=1; }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Cluster
    )
    begin {}
    process 
    {
        $route = "/api/v1/clusters/{0}" -f $Cluster.id

        $result = Invoke-PipFacade -Connection $Connection -Method "Put" -Route $route -Request $Cluster
        
        Write-Output $result
    }
    end {}
}


function Remove-IqsCluster
{
<#
.SYNOPSIS

Removes cluster by id

.DESCRIPTION

Removes cluster by its unique id

.PARAMETER Connection

A connection object

.PARAMETER Id

A cluster id

.EXAMPLE

Remove-IqsCluster -Id 123

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $Id
    )
    begin {}
    process 
    {
        $route = "/api/v1/clusters/{0}" -f $Id

        $result = Invoke-PipFacade -Connection $Connection -Method "Delete" -Route $route
        
        Write-Output $result
    }
    end {}
}

function Add-IqsOrganizationToCluster
{
<#
.SYNOPSIS

Adds organization to open cluster 

.DESCRIPTION

Adds organization by id to open and active cluster 

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.EXAMPLE

Add-IqsOrganizationToCluster -OrgId 123

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId
    )
    begin {}
    process 
    {
        $route = "/api/v1/clusters/add_organization/{0}" -f $OrgId

        $result = Invoke-PipFacade -Connection $Connection -Method "Post" -Route $route
        
        Write-Output $result
    }
    end {}
}

function Remove-IqsOrganizationFromCluster
{
<#
.SYNOPSIS

Removes organization from cluster 

.DESCRIPTION

Removes organization by id from cluster 

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.EXAMPLE

Remove-IqsOrganizationFromCluster -OrgId 123

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId
    )
    begin {}
    process 
    {
        $route = "/api/v1/clusters/remove_organization/{0}" -f $OrgId

        $result = Invoke-PipFacade -Connection $Connection -Method "Post" -Route $route -Request @{org_id=$OrgId}
        
        Write-Output $result
    }
    end {}
}