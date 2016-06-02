require 'mixlib/shellout'
require 'json'

property :name, String
property :version, String

load_current_value do
  name = installed_package[:name]
  version = installed_package[:version]
end

action :install do
  execute apm_install_cmd
end

action :upgrade do

end

action :remove do
  
end

private

def installed_packages
  # TODO: memoize this
  # TODO: handle failure case where apm isn't installed
  list = Mixlib::ShellOut.new('apm list --installed --json')
  list.run_command
  JSON.parse(list.stdout)
end

def installed_package
  installed_packages['user'].find { |pkg| pkg['name'] == name }
end

def apm_install_cmd
  atom_pkg = name
  atom_pkg << "@#{version}" if version

  "apm install #{atom_pkg} --no-color --production"
end
