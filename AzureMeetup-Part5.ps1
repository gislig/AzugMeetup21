# Script created by Gí­sli Guðmundsson
# For Azug Meetup Iceland - 19.02.2021

Import-Module Az.KeyVault


# Create a new vault
#New-AzKeyVault -Name "AzugMeetupVault" -ResourceGroupName "AzugMeetup" -Location "North Europe"

# Create a secret password
$secretvalue = ConvertTo-SecureString "AzugMeetupSecretPassword" -AsPlainText -Force

# Save the password to the vault
$secret = Set-AzKeyVaultSecret -VaultName "AzugMeetupVault" -Name "AzugPassword" -SecretValue $secretvalue

# Get the secret from the vault
$secret = Get-AzKeyVaultSecret -VaultName "AzugMeetupVault" -Name "AzugPassword"

# Convert the secret to readable string
function Convert-Secret($secret){
    $ssPtr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secret.SecretValue)
    try {
       $secretValueText = [System.Runtime.InteropServices.Marshal]::PtrToStringBSTR($ssPtr)
    } finally {
       [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($ssPtr)
    }
    return $secretValueText
}

Convert-Secret -secret $secret