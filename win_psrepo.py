#!/usr/bin/python
# -*- coding: utf-8 -*-

# (c) 2016, Jon Hawkesworth (@jhawkesworth) <figs@unity.demon.co.uk>
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
module: win_psrepo
version_added: "0.1"
short_description: register or remove a powershell trusted repository
description:
    - Register or remove powershell trusted repository. It can be usedo to add private repo to
      install custom powershell module installation. Powershell 5.0 is needed
options:
  name:
    description:
      - Arbitrary name of the repository.
    required: true
    default: none
  url:
    description:
      - url of the repository
    required: false if state is absent
    default: none
  state:
    description:
      - present or absent
    required: false
    default: present


EXAMPLES = '''
  # Add a new Ps Repo
- win_psrepo:
    name: WinRepo
    url: https://name_of_repo.com/name/of/repo
    state: present

  # Remove Ps repo
- win_psrepo:
    name: WinRepo
    state: absent
