$subscriptions = Get-AzSubscription
#$subscriptionsID = ($subscriptions).id

foreach ($subscription in $subscriptions){
$context = Set-AzContext $subscription.Id
$label = $subscription.Name
switch($subscription.TenantId){
"TenantID1"{$Tenant = "tenameName1"}
"TenantID2"{$Tenant = "tenameName2"}
"TenantID2"{$Tenant = "tenameName3"}
}
#$Tenant = (Get-AzTenant -TenantId $subscription.TenantId).name
$myobject= Get-AzResource -DefaultProfile $context | select-object Name,ResourceGroupName,Location,Type 
$myobject | Add-Member -NotePropertyName subscriptionID -NotePropertyValue $subscription.Id
$myobject | Add-Member -NotePropertyName TenantName -NotePropertyValue $Tenant
$pathname = $label+"-"+$Tenant
$myobject|Export-Csv -path C:\Users\kokafor\Desktop\resources\$pathname.csv
} 