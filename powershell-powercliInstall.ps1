function installPowerCLI (){
    if (($PSversiontable.psversion.major -ge 5) -and (Get-Module -name VMware.VimAutomation.Core).Version.Major -lt 6)  {
        Try {
                Install-PackageProvider -Name Nuget -force -ErrorAction 0
        }Catch {
                Write-Output 'Not able to install Nuget as package provider.'
        }
        if (get-packageprovider -name Nuget) {
            Try {
                set-psrepository -name PSGallery -InstallationPolicy trusted -ErrorAction 0
                Write-Output 'Trusting PSGallery has repository'
            }Catch {
                    Write-Output 'Not able to set psgallery as a trusted repository.'
            }
        }
        if (Get-PSRepository -name 'PSGallery') {
            Try {
                Install-module -name 'vmware.powercli' -ErrorAction 0
                Write-Output 'Installing vmware.powercli'
            } Catch {
                Write-Output 'could not install powercli'
            }
        }
        Try {
            (Get-Module -name VMware.VimAutomation.Core -EA 0).Version
        }Catch{

        }
        if ((Get-PowerCLIVersion).major -ge '6') {
            Write-Output 'POsh equals 5, powerli is 6'
        }else {
            Write-Output 'Powercli did not update'
        }
    }else {
        Write-output "POSH is not set to v5."
    }# """
}
function installPowerShell() {
    if (($PSVersionTable).major -lt 5){
        Try {
            choco install Powershell -y -ErrorAction 0
        }
        Catch {
            Write-Output 'Powershell v5 did not get installed'
        }
    } else {
        Write-Output 'Powershell is v5 or higher.'
    }
}

function restartComputer() {
    if (($PSVersionTable).Major -lt 5) {
        Restart-computer -force
    } 
}


#Tested below
function installChocolatey(){
    Try {
        Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) -ErrorAction 0
    }Catch{
        Write-Output "Failed to install Chocolatey"
        continue;
    }
}