#
# Cookbook Name:: celery
# Recipe:: default
#
# Copyright 2012, Rafael Durán Castañeda
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

require 'chef/mixin/command'
require 'chef/mixin/language'
include Chef::Mixin::Command

action :enable do
  options_file = "/etc/default/#{@celeryd.service_name}"
  daemon_script = "/etc/init.d/#{@celeryd.service_name}"

  unless @celeryd.enabled
    template "/etc/init.d/#{@celeryd.service_name}" do
      cookbook "celery"
      source "celeryd.erb"
      owner  "root"
      group  "root"
      mode   "0755"
      variables(
        :options_file => options_file,
        :daemon_script => daemon_script
      )
    end

    template "/etc/default/#{@celeryd.service_name}" do
      source node["celery"]["template_name"]
      cookbook node["celery"]["template_cookbook"]
      owner "root"
      group "root"
    end

    service "#{@celeryd.service_name}" do
      action [:enable]
    end
  end
end

action :disable do
  if @celeryd.enabled
    service  "/etc/init.d/#{@celeryd.service_name}" do
      action[:disable]
    end

    file "/etc/init.d/#{@celeryd.service_name}" do
      action :delete
    end

    file "/etc/default/#{@celeryd.service_name}" do
      action :delete
    end
  end
end

action :start do
  unless @celeryd.running
    execute "/etc/init.d/#{@celeryd.service_name} start"
  end
end

action :stop do
  if @celeryd.running
    execute "/etc/init.d/#{@celeryd.service_name} stop"
  end
end

action :restart do
  unless @celeryd.running
    execute "/etc/init.d/#{@celeryd.service_name} restart"
  end
end

def load_current_resource
  @celeryd = Chef::Resource::CeleryService.new(new_resource.name)
  @celeryd.service_name("celeryd-#{new_resource.name}")

  Chef::Log.debug("Checking status of service celeryd-#{new_resource.name}")

  begin
    if !@celeryd.enabled
      nil
    elsif run_command_with_systems_locale(
      :command => "/etc/init.d/#{@celeryd.service_name} status") == 0
      @celeryd.running(true)
    end
  rescue Chef::Exceptions::Exec
    @celeryd.running(false)
    nil
  end

  if ::File.exists?("/etc/init.d/#{@celeryd.service_name}") &&
     ::File.exists?("/etc/default/#{@celeryd.service_name}")
    @celeryd.enabled(true)
  else
    @celeryd.enabled(false)
  end
end
