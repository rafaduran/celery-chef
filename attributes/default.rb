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

# Generic settings
default[:celery][:log_dir] = "/var/log/celery"
default[:celery][:workers] = 1
default[:celery][:events] = true
default[:celery][:beat] = true
default[:celery][:create_user] = false
default[:celery][:user] = "celery"
default[:celery][:group] = "celery"
default[:celery][:virtualenv] = false
