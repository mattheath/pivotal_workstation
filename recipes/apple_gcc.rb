include_recipe "pivotal_workstation::homebrew"

execute "tap the dupes repo" do
  command "brew tap homebrew/dupes"
  not_if { system("brew tap | grep 'dupes' > /dev/null 2>&1") }
end

brew_install "apple-gcc42"
