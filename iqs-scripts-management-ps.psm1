########################################################
##
## iqs-scripts-management-ps.ps1
## Management interface to IQuipsys Positron
## Powershell module entry
##
#######################################################

$path = $PSScriptRoot
if ($path -eq "") { $path = "." }

. "$($path)/src/infrastructure/Logging.ps1"
. "$($path)/src/infrastructure/Counters.ps1"
. "$($path)/src/infrastructure/Settings.ps1"
. "$($path)/src/infrastructure/Statistics.ps1"
. "$($path)/src/infrastructure/SystemEvents.ps1"
. "$($path)/src/infrastructure/Blobs.ps1"

. "$($path)/src/users/Sessions.ps1"
. "$($path)/src/users/Accounts.ps1"
. "$($path)/src/users/Activities.ps1"
. "$($path)/src/users/Roles.ps1"
. "$($path)/src/users/Connections.ps1"
. "$($path)/src/users/Passwords.ps1"
. "$($path)/src/users/EmailSettings.ps1"
. "$($path)/src/users/Email.ps1"
. "$($path)/src/users/SmsSettings.ps1"
. "$($path)/src/users/Sms.ps1"

. "$($path)/src/support/Feedbacks.ps1"
. "$($path)/src/support/Announcements.ps1"

. "$($path)/src/ecommerce/CreditCards.ps1"

. "$($path)/src/content/Applications.ps1"
. "$($path)/src/content/Guides.ps1"
. "$($path)/src/content/HelpTopics.ps1"
. "$($path)/src/content/HelpArticles.ps1"
. "$($path)/src/content/Tips.ps1"
. "$($path)/src/content/ImageSets.ps1"
. "$($path)/src/content/MessageTemplates.ps1"
. "$($path)/src/content/Dashboards.ps1"

. "$($path)/src/root/Clusters.ps1"
. "$($path)/src/root/Agreements.ps1"

. "$($path)/src/configuration/Organizations.ps1"
. "$($path)/src/configuration/Locations.ps1"
. "$($path)/src/configuration/ObjectGroups.ps1"
. "$($path)/src/configuration/ControlObjects.ps1"
. "$($path)/src/configuration/Gateways.ps1"
. "$($path)/src/configuration/DataProfiles.ps1"
. "$($path)/src/configuration/DeviceProfiles.ps1"
. "$($path)/src/configuration/DeviceConfigs.ps1"
. "$($path)/src/configuration/Devices.ps1"
. "$($path)/src/configuration/EventTemplates.ps1"
. "$($path)/src/configuration/Resolutions.ps1"
. "$($path)/src/configuration/Zones.ps1"
. "$($path)/src/configuration/Beacons.ps1"
. "$($path)/src/configuration/EventRules.ps1"
. "$($path)/src/configuration/Shifts.ps1"
. "$($path)/src/configuration/EmergencyPlans.ps1"
. "$($path)/src/configuration/Invitations.ps1"

. "$($path)/src/realtime/CurrentObjectStates.ps1"
. "$($path)/src/realtime/CurrentDeviceStates.ps1"
. "$($path)/src/realtime/CurrentObjectRoutes.ps1"
. "$($path)/src/realtime/Incidents.ps1"
. "$($path)/src/realtime/Rosters.ps1"
. "$($path)/src/realtime/Signals.ps1"
. "$($path)/src/realtime/Corrections.ps1"
. "$($path)/src/realtime/RestGateway.ps1"

. "$($path)/src/historical/OperationalEvents.ps1"
. "$($path)/src/historical/ObjectData.ps1"
. "$($path)/src/historical/ObjectPositions.ps1"
. "$($path)/src/historical/ObjectStates.ps1"
. "$($path)/src/historical/ObjectRoutes.ps1"
. "$($path)/src/historical/Attendance.ps1"
