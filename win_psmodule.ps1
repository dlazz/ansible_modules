#!powershell
# This file is part of Ansible
#
# Copyright 2016, Daniele Lazzari <lazzari@mailup.com>
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

# win_psmodule (Powershell Module Additons/Removal)


$params = Parse-Args $args;
$name = Get-AnsibleParam $params "name" -failifempty $true;
$state = Get-AnsibleParam $params "state" -ValidateSet "present","absent" -default "present";
$result = New-Object PSObject @{"changed" = $false; "output" = ""};

Function Install-PsModule{
    param(
      [Parameter(Mandatory=$true)]
      [string]$Name
    )
    if (Get-Module -Listavailable -Name $Name){
        $result.output = "Module already present"
    }
    else {
      try{
        Install-Module -Name $name
        $result.output = "Module installed"
        $result.changed = $True
      }
      catch{
        $ErrorMessage = $_.Exception.Message
        Fail-Json $result $ErrorMessage
      }
    }
}

Function Remove-PsModule{
    param(
      [Parameter(Mandatory=$true)]
      [string]$Name
    )
    if (Get-Module -Listavailable -Name $Name){
      try{
        Remove-Module -Name $Name
        $result.changed = $True
        $result.output = "Module removed"

      }
      catch{
        $ErrorMessage = $_.Exception.Message
        Fail-Json $result $ErrorMessage
      }

    }
    else{
      $result.output = "Module not present"
    }
}

if ($state = "present"){
    Install-PsModule -Name $name
}
else{
  Remove-PsModule -Name $name
}


Exit-Json $result
