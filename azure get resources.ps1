$subscriptions = Get-AzSubscription
#$subscriptionsID = ($subscriptions).id
$virtMach = "Microsoft.Compute/virtualMachines"
$server = "Microsoft.Sql/servers"
$cluster = "Microsoft.ContainerService/managedClusters"
foreach ($subscription in $subscriptions){
$context = Set-AzContext $subscription.Id
$label = $subscription.Name
switch($subscription.TenantId){
"TenantID1"{$Tenant = "Tenant1"}
"TenantID2"{$Tenant = "Tenant2"}
"TenantID3"{$Tenant = "Tenant3"}
}
#$Tenant = (Get-AzTenant -TenantId $subscription.TenantId).name
$AzResources= Get-AzResource -DefaultProfile $context | `
Where-Object {($_.Type -eq $virtMach -or $_.Type -eq $server -or $_.Type -eq $cluster )} |`
 select-object Name,ResourceGroupName,Location,Type
$AzResources | Add-Member -NotePropertyName VMsize -NotePropertyValue ""
$AzResources | Add-Member -NotePropertyName OSType -NotePropertyValue ""
$myVM = $AzResources | Where-Object {$_.Type -eq "Microsoft.Compute/virtualMachines"} 
foreach ($Vm in $myVM.name){
$VMData = Get-AzVM -Name $Vm
$vm2 = $AzResources | Where-Object {$_.Name -eq $Vm} 
$vm2.VMSize = $VMData.HardwareProfile.VmSize
$vm2.OSType = $VMData.StorageProfile.OsDisk.OsType
#$Vm2  | Add-Member -NotePropertyName VMSize -NotePropertyValue $VMData.HardwareProfile.VmSize
#$AzResources
}
$AzResources | Add-Member -NotePropertyName subscriptionID -NotePropertyValue $subscription.Id
$AzResources | Add-Member -NotePropertyName TenantName -NotePropertyValue $Tenant
$pathname = $label+"-"+$Tenant
$AzResources|Export-Csv -path C:\$pathname.csv
} 