$categoryName = "My custom counter set"
$categoryHelp = "A Performance object for testing"
$categoryType = [System.Diagnostics.PerformanceCounterCategoryType]::MultiInstance # 

$categoryExists = [System.Diagnostics.PerformanceCounterCategory]::Exists($categoryName)

If (-Not $categoryExists)
{
  $objCCDC = New-Object System.Diagnostics.CounterCreationDataCollection
  
  $objCCD1 = New-Object System.Diagnostics.CounterCreationData
  $objCCD1.CounterName = "My custom metric"
  $objCCD1.CounterType = "NumberOfItems32"
  $objCCD1.CounterHelp = "My custom metric"
  $objCCDC.Add($objCCD1) | Out-Null
  
  [System.Diagnostics.PerformanceCounterCategory]::Create($categoryName, $categoryHelp, $categoryType, $objCCDC) | Out-Null
}

## Create new instance 
$Counter1 = New-Object System.Diagnostics.PerformanceCounter($categoryName, "My custom metric", "My custom metic instance", $false)
# Set a value
$Counter1.RawValue = 1024

$Counter1.RawValue
$Counter1.Disposed


## check result 
Get-Counter -Counter "\My custom counter set(*)\My custom metric"

## clean-up 
[System.Diagnostics.PerformanceCounterCategory]::Delete("$categoryName")