require 'mixlib/shellout'
# require 'json'

module Atom
  module ApmHelpers
    def installed_packages
      # TODO: memoize this
      # TODO: handle failure case where apm isn't installed
      # user_pkgs = Mixlib::ShellOut.new('apm list --installed --json')
      # user_pkgs.run_command
      # JSON.parse(user_pkgs.stdout)

      user_pkgs = Mixlib::ShellOut.new('apm list --installed --bare')
      user_pkgs.run_command
      user_pkgs.stdout.split(/\R/).map { |pkg| pkg.split('@') }.to_h
    end

    def package_installed?
      # installed_packages['user'].find { |pkg| pkg['name'] == name }
      pkgs = installed_packages
      pkgs.key?(new_resource.name)
    end

    def apm_install_cmd
      atom_pkg = new_resource.name
      atom_pkg << "@#{new_resource.version}" if new_resource.version

      "apm install #{atom_pkg} --no-color --production"
    end
  end
end
