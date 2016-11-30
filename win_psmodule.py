#!/usr/bin/python
# -*- coding: utf-8 -*-

# (c) 2016, Daniele Lazzari (@jhawkesworth) <lazzari@mailup.com>
#
# This file is part of Ansible
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

# this is a windows documentation stub.  actual code lives in the .ps1
# file of the same name

DOCUMENTATION = '''
---
module: win_psmodule
version_added: "2.3"
short_description: Install or remove a powershell module from a trusted repository
description:
    - Install or remove a powershell module from a trusted repository. Powershell 5.0 is needed
options:
  name:
    description:
      - Module Name
    required: true
    default: none
  state:
    description:
      - present or absent
    required: false
    default: present
'''

EXAMPLES = '''
  # Add a powershell module

- win_psmodule:
    name: MyCustomModule
    state: present

  # Remove powershell Module

- win_psmodule:
    name: MyCustomModule
    state: absent
'''
RETURN = '''
'''
