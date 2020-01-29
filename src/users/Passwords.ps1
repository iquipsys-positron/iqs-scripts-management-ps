########################################################
##
## Passwords.ps1
## Management interface to IQuipsys Positron
## Password management commands
##
#######################################################

function Set-IqsPassword
{
<#
.SYNOPSIS

Get user roles

.DESCRIPTION

Gets all assigned roles to a user by its id

.PARAMETER Connection

A connection object

.PARAMETER OldPassword

An old password

.PARAMETER NewPassword

A new password

.EXAMPLE

Set-IqsPassword -Id 123

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OldPassword,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipelineByPropertyName=$true)]
        [string] $NewPassword
    )
    begin {}
    process 
    {
        Set-PipPassword -Connection $Connection -Method "Post" -Uri "/api/v1/passwords/{0}/change" -OldPassword $OldPassword -NewPassword $NewPassword
    }
    end {}
}


function Request-IqsPassword
{
<#
.SYNOPSIS

Requests password recovery email

.DESCRIPTION

Requests a password recovery email. The email is set to the account primary email with reset code

.PARAMETER Connection

A connection object

.PARAMETER Login

User login

.EXAMPLE

Request-IqsPassword -Login test@somewhere.com

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $Login
    )
    begin {}
    process 
    {
        Request-PipPassword -Connection $Connection -Method "Post" -Uri "/api/v1/passwords/recover" -Login $Login
    }
    end {}
}


function Reset-IqsPassword
{
<#
.SYNOPSIS

Resets user password

.DESCRIPTION

Resets user password using reset code sent by email

.PARAMETER Connection

A connection object

.PARAMETER Login

User login

.PARAMETER Code

Reset code

.PARAMETER Password

A new password

.EXAMPLE

Reset-IqsPassword -Login test@somewhere.com -Code 1245 -Password pass123

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $Login,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipelineByPropertyName=$true)]
        [string] $Code,
        [Parameter(Mandatory=$true, Position = 2, ValueFromPipelineByPropertyName=$true)]
        [string] $Password
    )
    begin {}
    process 
    {
        Reset-PipPassword -Connection $Connection -Method "Post" -Uri "/api/v1/passwords/reset" -Login $Login -Code $Code -Password $Password
    }
    end {}
}