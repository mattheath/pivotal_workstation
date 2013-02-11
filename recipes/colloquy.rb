remote_file "#{Chef::Config[:file_cache_path]}/colloquy.zip" do
  source node["colloquy_download_uri"]
  owner WS_USER
  checksum node["colloquy_sha"]
  not_if { File.exists?("#{Chef::Config[:file_cache_path]}/colloquy.zip") }
end

execute "unzip colloquy" do
  command "unzip #{Chef::Config[:file_cache_path]}/colloquy.zip -d #{Chef::Config[:file_cache_path]}/"
  user WS_USER
  not_if { File.exists?("#{Chef::Config[:file_cache_path]}/Colloquy.app") }
end

execute "copy colloquy to /Applications" do
  command "mv #{Chef::Config[:file_cache_path]}/Colloquy.app #{Regexp.escape(node["colloquy_app_path"])}"
  user WS_USER
  group "admin"
  not_if { File.exists?(node["colloquy_app_path"]) }
end

ruby_block "test to see if colloquy.app was installed" do
  block do
    raise "colloquy.app was not installed" unless File.exists?(node["colloquy_app_path"])
  end
end
