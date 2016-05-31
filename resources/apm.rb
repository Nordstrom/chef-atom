property :package_name, String
property :version, String

load_current_value do
  # package_name = foo
end

action :install do
  execute apm_install_cmd
end

action :upgrade
action :remove

private

def apm_install_cmd
  atom_pkg = package_name
  atom_pkg << "@#{version}" if version

  "apm install#{atom_pkg} --no-color --production"
end
