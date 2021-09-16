$PrintWithTags = "true"

$subs = Get-AzSubscription
foreach($sub in $subs) {
    Write-Host -ForegroundColor "cyan" -Message "=== Checking VMs in $($sub.name) ==="
    Set-AzContext -SubscriptionId $sub.Id

    $RGs = Get-AzResourceGroup
    foreach ($rg in $RGs) {
        $VMs = Get-AzVM -ResourceGroup $rg.ResourceGroupName
        foreach ($vm in $VMs) {
            $exts = (Get-AzVM -ResourceGroupName $rg.ResourceGroupName -Name $vm.Name).Extensions
            foreach ($ext in $exts) {
                if ($ext.VirtualMachineExtensionType -eq "OmsAgentForLinux") {
                    Write-Host -ForegroundColor "Cyan" -Message "OmsAgent FOUND!! - $($vm.Name) with tags:"
                    if ($PrintWithTags) {
                        $tags = $vm.Tags
                        $tags.GetEnumerator() | ForEach-Object {
                            Write-Host -ForegroundColor "Cyan" -Message "$($_.key): $($_.value)"
                        }
                    }
                }
            }
        }
    }
}