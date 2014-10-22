#
# Cookbook Name:: coopr
# Recipe:: repo
#
# Copyright © 2013-2014 Cask Data, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

case node['platform_family']
when 'rhel'
  include_recipe 'yum'
  yum_repository 'cask' do
    description 'Cask YUM repository'
    url node['coopr']['repo']['url']
    gpgkey node['coopr']['repo']['key_url']
    gpgcheck false
    action :add
  end
when 'debian'
  include_recipe 'apt'
  apt_repository 'cask' do
    uri node['coopr']['repo']['url']
    distribution node['lsb']['codename']
    components node['coopr']['repo']['components']
    action :add
    arch 'amd64'
    trusted true
    key "#{node['coopr']['repo']['url']}/pubkey.gpg"
  end
end
