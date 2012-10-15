# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
    # All Vagrant configuration is done here. The most common configuration
    # options are documented and commented below. For a complete reference,
    # please see the online documentation at vagrantup.com.

    # Every Vagrant virtual environment requires a box to build off of.
    config.vm.box = "lucid64"

    # The url from where the 'config.vm.box' box will be fetched if it
    # doesn't already exist on the user's system.
    config.vm.box_url = "http://files.vagrantup.com/lucid64.box"

    config.vm.define :project do |project_config|
        project_config.vm.forward_port 80, 8080
        # config.vm.boot_mode = :gui
        # config.vm.share_folder "v-data", "/vagrant_data", "../data"

      
        project_config.vm.provision :chef_solo do |chef|
            chef.cookbooks_path = ["chef/cookbooks/", "chef/site-cookbooks/"]

            chef.run_list = ["recipe[site]"]
            chef.json = {
                sites:[
                    {
                        name: "zf2app",
                        docroot: "/vagrant/www/",
                        server_name: "www.zf2app.dev",
                        server_aliases: ["www.zf2app.dev"],
                    },{
                        name: "debug.zf2app",
                        docroot: "/var/www/webgrind/",
                        server_name: "debug.zf2app.dev",
                        server_aliases: ["debug.zf2app.dev"],
                    }
                ],
                apache:{
                    default_site_enabled: false,
                    default_modules:[
                        "status","alias","auth_basic","authn_file","authz_default","authz_groupfile","authz_host","authz_user","autoindex","dir", "env", "mime", "negotiation", "setenvif",
                        "rewrite", "php5", "headers", "include"]
                },
                mysql:{
                    server_root_password: 'root'
                }
            }
        end
    end
end
