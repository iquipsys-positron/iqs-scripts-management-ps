########################################################
##
## Roles.ps1
## Management interface to IQuipsys Positron
## User roles commands
##
#######################################################

function Get-IqsRoles
{
<#
.SYNOPSIS

Get user roles

.DESCRIPTION

Gets all assigned roles to a user by its id

.PARAMETER Connection

A connection object

.EXAMPLE

Get-IqsRoles -Id 123

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
        Get-PipRoles -Connection $Connection -Method "Get" -Uri "/api/v1/roles/{0}" -Id $Id
    }
    end {}
}


function Grant-IqsRoles
{
<#
.SYNOPSIS

Grants user roles

.DESCRIPTION

Grants roles to a user

.PARAMETER Connection

A connection object

.EXAMPLE

Grant-IqsRoles -Id 123 -Roles admin

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $Id,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipelineByPropertyName=$true)]
        [string[]] $Roles
    )
    begin {}
    process 
    {
        Grant-PipRoles -Connection $Connection -Method "Post" -Uri "/api/v1/roles/{0}/grant" -Id $Id -Roles $Roles
    }
    end {}
}


function Revoke-IqsRoles
{
<#
.SYNOPSIS

Revokes user roles

.DESCRIPTION

Revokes roles from a user

.PARAMETER Connection

A connection object

.EXAMPLE

Revoke-IqsRoles -Id 123 -Roles admin

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $Id,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipelineByPropertyName=$true)]
        [string[]] $Roles
    )
    begin {}
    process 
    {
        Revoke-PipRoles -Connection $Connection -Method "Post" -Uri "/api/v1/roles/{0}/revoke" -Id $Id -Roles $Roles
    }
    end {}
}

function Grant-IqsOrganizationRole
{
<#
.SYNOPSIS

Grants user a organization role

.DESCRIPTION

Grants organization role to a user

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER UserId

A user id

.PARAMETER Role

A organization role: 'admin', 'manager' or 'user'

.EXAMPLE

Grant-IqsOrganizationRole -OrgId 1 -UserId 123 -Role admin

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $UserId,
        [Parameter(Mandatory=$true, Position = 2, ValueFromPipelineByPropertyName=$true)]
        [string] $Role
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/roles" -f $OrgId
        
        $params =
        @{ 
            user_id = $UserId;
            role = $Role
        }

        $result = Invoke-PipFacade -Connection $Connection -Method "Post" -Route $route -Params $params

        Write-Output $result
    }
    end {}
}


function Revoke-IqsOrganizationRole
{
<#
.SYNOPSIS

Revokes user a organization role

.DESCRIPTION

Revokes organization role from a user

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER UserId

A user id

.PARAMETER Role

A organization role: 'admin', 'manager' or 'user'

.EXAMPLE

Revoke-IqsOrganizationRole -OrgId 1 -UserId 123 -Role admin

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $UserId,
        [Parameter(Mandatory=$true, Position = 2, ValueFromPipelineByPropertyName=$true)]
        [string] $Role
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/roles" -f $OrgId
        
        $params =
        @{ 
            user_id = $UserId;
            role = $Role
        }

        $result = Invoke-PipFacade -Connection $Connection -Method "Delete" -Route $route -Params $params

        Write-Output $result
    }
    end {}
}

