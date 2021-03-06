# Omigod-Check
While recently [reading](https://www.bleepingcomputer.com/news/microsoft/microsoft-fixes-critical-bugs-in-secretly-installed-azure-linux-app/) about a critical bug in Azure Linux VMs, I wondered if we were susceptible. This script can be run to see which VMs are potentially vulnerable.


From the article:
>To make things worse, there is no auto-update mechanism Microsoft can use to update the vulnerable agents on all Azure Linux machines, which means that customers have to upgrade it manually to secure endpoints from any incoming attacks using OMIGOD exploits.
>
>To manually update the OMI agent, you have to:
>
>Add the MSRepo to your system. Based on the Linux OS that you are using, refer to this link to install the MSRepo to your system: [Linux Software Repository for Microsoft Products | Microsoft Docs](https://docs.microsoft.com/en-us/windows-server/administration/Linux-Package-Repository-for-Microsoft-Software)
>
>You can then use your platform's package tool to upgrade OMI (for example, `sudo apt-get install omi` or `sudo yum install omi`).


Below is a list of the CVEs:

* [CVE-2021-38647](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2021-38647) – Unauthenticated RCE as root (Severity: 9.8/10)
* [CVE-2021-38648](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2021-38648) – Privilege Escalation vulnerability (Severity: 7.8/10)
* [CVE-2021-38645](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2021-38645) – Privilege Escalation vulnerability (Severity: 7.8/10)
* [CVE-2021-38649](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2021-38649) – Privilege Escalation vulnerability (Severity: 7.0/10)

## Using
Just run the PowerShell script from an Azure PowerShell Cloud Shell.

`$> ./omigod-check.ps1`

Example output:
``` PowerShell
myvm001, QBE-NA-Subscription, 12345678-abcd-12ab-ab12-123a456b789c
myvm002, QBE-NA-Subscription, 12345678-abcd-12ab-ab12-123a456b789c
myvm003, QBE-NA-Subscription, 12345678-abcd-12ab-ab12-123a456b789c
myvm004, QBE-NA-Subscription, 12345678-abcd-12ab-ab12-123a456b789c
myvm005, QBE-NA-Subscription, 12345678-abcd-12ab-ab12-123a456b789c
```

If you want to target specific subscriptions, pass the `-Subscriptions` flag with a path to a JSON file containing the subscriptions like this:
``` PowerShell
$> ./omigod-check.ps1 -Subscriptions subscriptions.json
myvm001, QBE-NA-Subscription, 12345678-abcd-12ab-ab12-123a456b789c
myvm002, QBE-NA-Subscription, 12345678-abcd-12ab-ab12-123a456b789c
myvm003, QBE-EO-Subscription, c987b654a321-21ba-ba21-dcba-87654321
myvm004, QBE-EO-Subscription, c987b654a321-21ba-ba21-dcba-87654321
myvm005, QBE-EO-Subscription, c987b654a321-21ba-ba21-dcba-87654321
```

Where `subscriptions.json` looks like this:
```JSON
[
    {
      "name": "QBE-NA-Subscription",
      "id": "12345678-abcd-12ab-ab12-123a456b789c"  ,
      "location": "centralus"
    },
    {
      "name": "QBE-EO-Subscription",
      "id": "c987b654a321-21ba-ba21-dcba-87654321"  ,
      "location": "uksouth"
    }
]
```