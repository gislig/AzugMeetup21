# Script created by Gí­sli Guðmundsson
# For Azug Meetup Iceland - 19.02.2021

# Replace some of the characters in the word list
function FixWords($word){
    return $word -replace "'",""` -replace "&",""` -replace ",",""` -replace "-",""`
}

# Generates password from a wordlist
function GeneratePasswordFromWords(){
    $OutFile = "words.txt"
    $WordsTXT = "https://raw.githubusercontent.com/dwyl/english-words/master/words.txt"

    if((Test-Path $OutFile) -eq $null){
        Invoke-WebRequest $WordsTXT -OutFile $OutFile
    }

    if($WordList -eq $null){
        $WordList = Get-Content $OutFile | ForEach-Object { FixWords ($_).ToLower() }
    }

    $NumberOfWords = 3
    $password = [string]::Join(".",(Get-Random -InputObject $WordList -Count $NumberOfWords))
    return $password
}

GeneratePasswordFromWords