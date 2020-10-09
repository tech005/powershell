<#
    This function takes in a list of variables that is copied via the azure devops portal variables
    and takes every second item an assigns it to itself in a way that can be used within a poweshell
    task for a deployment pipeline. It assigns all variables to be used with powershell scripts
    on a deployment group.

    !!NOTE!! Add an extra line at beginning of input file
#>
param (
    $infile = "$env:HOMEPATH\Desktop\variables.txt",
    $outfile = "$env:HOMEPATH\Desktop\variablesConverted.txt"    
)
# parts to add to string to format variable understood by devops pipeline
$start = '$('
$end = ')'

# getting every second line to ignore values
$plainvars = Get-Content -Path $infile | Where-Object { $i % 2 -eq 0; $i++ }

# formatting the desired line output
$reformattedVars = foreach($var in $plainvars){
    "$var = $start$var$end"
}

# writing to file
$reformattedVars | Out-File -FilePath $outfile
