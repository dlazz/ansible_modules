#!powershell
# This file is part of Ansible
#
# Copyright 2015, Daniele Lazzri <lazzari@mailup.com>
#
# Ansible is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Ansible is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Ansible.  If not, see <http://www.gnu.org/licenses/>.

# WANT_JSON
# POWERSHELL_COMMON

# win_psrepo module (File/Resources Permission Additions/Removal)

$params = Parse-Args $args;

$name = Get-AnsibleParam $params "name" -failifempty $true;
$url = Get-AnsibleParam $params "url";
$state = Get-AnsibleParam $params "state" -ValidateSet "present","absent"  -default "present";
$result = New-Object PSObject @{"changed" = $false; "output" = ""};


Function Install-Repository{
    Param(
    [Parameter(Mandatory=$True)]
    [string]$name,
    [Parameter(Mandatory=$True)]
    [string]$url
    )
    $Repo = (Get-PSRepository).SourceLocation
    if (!($url)){
        $result.output = "The repository url is needed"
        Fail-Json $result
    }
    if ($Repo -notcontains $url){
      if (!(Get-PackageProvider -Name NuGet|out-null)){
        try{
          Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force|out-null
        }
        catch{
          $result.output= "Problems adding package provider. $($ErrorMessage)"
          $ErrorMessage = $_.Exception.Message
          Fail-Json $result $ErrorMessage
        }
      }
       try{
           Register-PSRepository -Name $name -PublishLocation $url -SourceLocation $url -InstallationPolicy Trusted
           $result.changed= $true
           $result.output= "Repository added"
           }
       catch{
           $ErrorMessage = $_.Exception.Message
           $result.output= "Problems adding repository. $($ErrorMessage)"
           Fail-Json $result $ErrorMessage
            }
    }
    else {
        $result.output= "Repository already present"
    }
}

Function Remove-Repository{
    Param(
    [Parameter(Mandatory=$True)]
    [string]$Name
    )

    $Repo = (Get-PSRepository).SourceLocation

    if ($Repo -contains $name){
        try{
            Unregister-PSRepository -Name $name
            $result.changed = $true
            $result.output= "Repository removed"
        }
        catch{
            $ErrorMessage = $_.Exception.Message
            $result.output= "Problems removing repository. $($ErrorMessage)"
            Fail-Json $result $ErrorMessage

        }
    }
    else{
        $result.output= "Repository not present"
    }
}

if ($state = "present"){
    Install-Repository -Name $name -Url $url

}
else{
    Remove-Repository -Name $name
}

Exit-Json $result
