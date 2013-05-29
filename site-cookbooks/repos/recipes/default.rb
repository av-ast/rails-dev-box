apt_repository "multimedia" do
  uri "http://www.deb-multimedia.org"
  distribution "squeeze"
  components ["main", "non-free"]
end

package "deb-multimedia-keyring" do
  action :install
  options "--force-yes"
end

execute "aptupdate" do
  command "apt-get update"
  action :run
end
