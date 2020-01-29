########################################################
##
## Invitations.ps1
## Management interface to IQuipsys Positron
## Invitations commands
##
#######################################################


function Get-IqsInvitations
{
<#
.SYNOPSIS

Gets page with invitations by specified criteria

.DESCRIPTION

Gets a page with invitations that satisfy specified criteria

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

Get-IqsInvitations -OrgId 1 -Filter @{ search="gate" } -Take 10

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
        $route = "/api/v1/organizations/{0}/invitations" -f $OrgId

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


function Get-IqsInvitation
{
<#
.SYNOPSIS

Gets invitation by id

.DESCRIPTION

Gets invitation by its unique id

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Id

A invitation id

.EXAMPLE

Get-IqsInvitation -OrgId 1 -Id 123

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
        $route = "/api/v1/organizations/{0}/invitations/{1}" -f $OrgId, $Id

        $result = Invoke-PipFacade -Connection $Connection -Method "Get" -Route $route
        
        Write-Output $result
    }
    end {}
}


function Send-IqsInvitation
{
<#
.SYNOPSIS

Sends a new invitation

.DESCRIPTION

Sends a new invitation to a person who is not registered yet (action="activate"),
to organization admin to approve invitation (action="approve") or notify existing user
that he is invited by admin to work with organization (action="notify")

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Invitation

A invitation with the following structure:
- id: string
- action: string
- org_id: string
- organization_name: string
- invitee_name: string
- invitee_email: string
- expire_time: Date

.EXAMPLE

Send-IqsInvitation -OrgId 1 -Invitation @{ action="activate"; org_id="1"; organization_name="Test organization"; invitee_email="test@somewhere.com" }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Invitation
    )
    begin {}
    process 
    {
        if ($Invitation['action'] -eq 'notify') {
            $route = "/api/v1/organizations/{0}/invitations/notify" -f $OrgId
        } else {
            $route = "/api/v1/organizations/{0}/invitations" -f $OrgId
        }

        $result = Invoke-PipFacade -Connection $Connection -Method "Post" -Route $route -Request $Invitation
        
        Write-Output $result
    }
    end {}
}


function Remove-IqsInvitation
{
<#
.SYNOPSIS

Removes invitation by id

.DESCRIPTION

Removes invitation by its unique id

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Id

A invitation id

.EXAMPLE

Remove-IqsInvitation -OrgId 1 -Id 123

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
        $route = "/api/v1/organizations/{0}/invitations/{1}" -f $OrgId, $Id

        $result = Invoke-PipFacade -Connection $Connection -Method "Delete" -Route $route
        
        Write-Output $result
    }
    end {}
}

function Approve-IqsInvitation
{
<#
.SYNOPSIS

Approves invitation request by id

.DESCRIPTION

Approves invitation request by its unique id

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Id

A invitation id

.PARAMETER Role

.EXAMPLE

Approve-IqsInvitation -OrgId 1 -Id 123 -Role 'admin'

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $Id,
        [Parameter(Mandatory=$false, Position = 2, ValueFromPipelineByPropertyName=$true)]
        [string] $Role
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/invitations/{1}/approve" -f $OrgId, $Id

        $params = @{ 
            role = $Role
        }
        
        $result = Invoke-PipFacade -Connection $Connection -Method "Post" -Route $route -Params $params
        
        Write-Output $result
    }
    end {}
}

function Deny-IqsInvitation
{
<#
.SYNOPSIS

Denies invitation by id

.DESCRIPTION

Denies invitation by its unique id

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Id

A invitation id

.EXAMPLE

Deny-IqsInvitation -OrgId 1 -Id 123

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
        $route = "/api/v1/organizations/{0}/invitations/{1}/deny" -f $OrgId, $Id

        $result = Invoke-PipFacade -Connection $Connection -Method "Post" -Route $route
        
        Write-Output $result
    }
    end {}
}