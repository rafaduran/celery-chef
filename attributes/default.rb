# Attributes for celery
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

# General settings
default[:celery][:log_level] = "INFO"
default[:celery][:nodes] = ["celery"]
default[:celery][:celeryconfig] = false
default[:celery][:options] = []
default[:celery][:virtualenv] = false

# User/group settings
default[:celery][:create_user] = true
default[:celery][:user] = "celery"
default[:celery][:group] = "celery"

# Path settings
default[:celery][:run_dir] = "/var/run/celeryd"
default[:celery][:log_dir] = "/var/log/celeryd"
default[:celery][:work_dir] = false

# Template settings
default[:celery][:template_name] = "default.erb"
default[:celery][:template_cookbook] = "celery"

# Django settings
default[:celery][:django] = false
default[:celery][:dj_manage] = "manage.py"
default[:celery][:dj_settings] = "settings"

# default[:celery][:concurrency] = 2
# default[:celery][:workers] = node[:cpu][:total]
# default[:celery][:events] = true
# default[:celery][:beat] = false
# default[:celery][:pool] = "processes"
