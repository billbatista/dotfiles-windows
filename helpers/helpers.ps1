function Test-Answer {

    param (
        [string] $Answer,
        [string] $Expected
    )

    if ($Answer.ToLower() -eq $Expected.ToLower() -or $Answer -eq "") {
        return $true
    } else {
        return $false
    }
}