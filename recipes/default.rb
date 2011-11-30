#
# Cookbook Name:: celery
# Recipe:: default
#
# Copyright 2011, Rafael Durán Castañeda
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "python"

python_pip "celery" do
  virtualenv node[:celery][:virtualenv] if node[:celery][:virtualenv]
  action :install
end

if node["celery"]["create_user"]
  include_recipe "celery::user"
end

directory "#{node[:celery][:log_dir]}" do
  owner "#{node[:celery][:user]}"
  owner "#{node[:celery][:group]}"
  mode 0755
  action :create
end

cookbook_file "/etc/init.d/celery" do
    source "etc/init.d/celery"
    owner "root"
    group "root"
    mode 0750
end

template "/etc/init/celery.conf" do
    source "etc/init/celery.conf.erb"
    owner "root"
    group "root"
    mode 0750
    notifies :restart, "service[celery]"
end

service "celery" do
    provider Chef::Provider::Service::Upstart
    enabled true
    running true
    supports :restart => true, :reload => true, :status => true
    action [:enable, :start]
end
