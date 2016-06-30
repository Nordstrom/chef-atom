
action_class do
  include Atom::ApmHelpers
end

property :name, String
property :version, String

load_current_value do
  # name = installed_package[:name]
  # version = installed_package[:version]
end

action :install do
  execute apm_install_cmd
end

action :upgrade do

end

action :remove do

end
