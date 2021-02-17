# Script created by Gísli Guðmundsson
# For Azug Meetup Iceland - 19.02.2021


function ReplaceLetters($letter){
    return $letter -replace "í","i"` -replace "ö","o"` -replace "á","a"` -replace "ó","o"` -replace "æ","ae"` -replace "ý","y"` -replace "þ","th"` -replace "ú","u"` -replace "ð","d"
}

function GeneratePasswordFromNames(){
    $OutFile = "nafnalisti.csv"
    if((Test-Path $OutFile) -eq $null){
        $NamesCSV = "http://opingogn.is/dataset/acdcc1d5-a407-48d2-9530-2a8d626dccc7/resource/27dc8c43-247e-4797-a603-87853637e038/download/nafnalisti.csv"
        Invoke-WebRequest $NamesCSV -OutFile $OutFile
    }
    $NamesList = Import-Csv $OutFile -Delimiter "," -Encoding utf8 | Select Nafn | ForEach-Object { ReplaceLetters -letter ($_.Nafn).ToLower() }
    $NumberOfNames = 3
    $password = [string]::Join(".",(Get-Random -InputObject $NamesList -Count $NumberOfNames))
    return $password
}

GeneratePasswordFromNames
