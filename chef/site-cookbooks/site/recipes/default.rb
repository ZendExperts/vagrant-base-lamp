#
# Cookbook Name:: site
# Recipe:: default
#
include_recipe "apt"
include_recipe "apache2"
include_recipe "mysql::server"
include_recipe "imagemagick"
include_recipe "php"
include_recipe "php::module_gd"
include_recipe "php::module_curl"
include_recipe "php::module_mysql"
include_recipe "php_imagick"
include_recipe "git"


# Some neat package (subversion is needed for "subversion" chef ressource)
%w{ debconf php5-xdebug subversion }.each do |a_package|
  package a_package
end

# get phpmyadmin conf
cookbook_file "/tmp/phpmyadmin.deb.conf" do
  source "phpmyadmin.deb.conf"
end
bash "debconf_for_phpmyadmin" do
  code "debconf-set-selections /tmp/phpmyadmin.deb.conf"
end
package "phpmyadmin"

# Configure the development site
node[:sites].each do |site|
    web_app site[:name] do
      template "sites.conf.erb"
      server_name site[:server_name]
      server_aliases site[:server_aliases]
      docroot site[:docroot]
    end  

    # Add site info in /etc/hosts
    bash "info_in_etc_hosts" do
      code "echo 127.0.0.1 #{site[:server_name]} #{site[:server_aliases]} >> /etc/hosts"
    end

end

# Retrieve webgrind for xdebug trace analysis
subversion "Webgrind" do
  repository "http://webgrind.googlecode.com/svn/trunk/"
  revision "HEAD"
  destination "/var/www/webgrind"
  action :sync
end

# Add an admin user to mysql
execute "add-admin-user" do
  command "/usr/bin/mysql -u root -p#{node[:mysql][:server_root_password]} -e \"" +
      "CREATE USER 'myadmin'@'localhost' IDENTIFIED BY 'myadmin';" +
      "GRANT ALL PRIVILEGES ON *.* TO 'myadmin'@'localhost' WITH GRANT OPTION;" +
      "CREATE USER 'myadmin'@'%' IDENTIFIED BY 'myadmin';" +
      "GRANT ALL PRIVILEGES ON *.* TO 'myadmin'@'%' WITH GRANT OPTION;\" " +
      "mysql"
  action :run
  only_if { `/usr/bin/mysql -u root -p#{node[:mysql][:server_root_password]} -D mysql -r -N -e \"SELECT COUNT(*) FROM user where user='myadmin' and host='localhost'"`.to_i == 0 }
  ignore_failure true
end
