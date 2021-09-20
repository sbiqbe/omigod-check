$subs = Get-AzSubscription
foreach($sub in $subs) {
    Set-AzContext -SubscriptionId $sub.Id
    $RGs = Get-AzResourceGroup
    foreach ($rg in $RGs) {
        $VMs = Get-AzVM -ResourceGroup $rg.ResourceGroupName
        foreach ($vm in $VMs) {
            $exts = (Get-AzVM -ResourceGroupName $rg.ResourceGroupName -Name $vm.Name).Extensions
            foreach ($ext in $exts) {
                if ($ext.VirtualMachineExtensionType -eq "OmsAgentForLinux") {
                    Write-Output "$($vm.Name), $($sub.name), $($sub.Id)"
                }
            }
        }
    }
}