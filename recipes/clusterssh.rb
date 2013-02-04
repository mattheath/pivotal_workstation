include_recipe "pivotal_workstation::homebrew"

if node["platform"] != "mac_os_x"
  package "clusterssh"
else
  brew_install "csshx"
end

