# Script created by Gí­sli Guðmundsson
# For Azug Meetup Iceland - 19.02.2021

# Here is the API key from the custom integration
$apiKey = Get-Content .\BearerKey.txt

# Define the header with the API key with Bearer authorization
$headers = @{"Authorization" = "Bearer " + $apiKey}

# Define the path where you can search for groups
$apiGetPath = "https://graph.facebook.com/v2.11/community/groups"
 
# Find the id of the Monitoring Group
$GroupName = "MonitoringGroup"
$GroupID = ((Invoke-RestMethod -Method Get -Uri $apiGetPath -Headers $headers).data | ? { $_.Name -eq $GroupName }).id

# Create the message
$Message = "Notification : $groupModified was modified, the user $userModified was added to the group."

# Build the post method link with the groupid and the message
$apiPostPath = "https://graph.facebook.com/$GroupID/feed?message=$Message"

# Send the message
Invoke-RestMethod -Method Post -Uri $apiPostPath -Headers $headers
