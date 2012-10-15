Documentation
=============

This repository contains a general vagrant configuration for developing web applications using PHP and Zend Framework.

The package installs the following:
- ubuntu
- apache2 
- php 5.3 with xdebug
- mysql
- apt
- imagemagick
- git
- phpmyadmin
- webgrind

Configuration
=============

Before going ahead and installing all packages there are a few configuration items that you should be aware of.

First of all you should edit the Vagrantfile to set up any virtual hosts you need. 
By default this file defines 2 virtual hosts:

```
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
```

The first one is your main application and it is pointing to the `www/` folder within your project.
The second one is used for debugging your code with XDEBUG.

Make sure you add these domain names to your hosts file using the following line:

```
127.0.0.1 				www.zf2app.dev debug.zf2app.dev
```
    
You can create any number of virtual hosts by editing this Vagrantfile.

Apart from this you can also change the root mysql password, the loaded apache2 modules and any other setting from the used cookbooks.

Installation
============

In order to use this package you need to install [Vagrant](http://vagrantup.com/)and have a basic knowledge on how to use it.

Usage:

```
$ git clone https://github.com/ZendExperts/vagrant-base-lamp.git project
$ cd project
$ git submodule init
$ git submodule update
$ vagrant up
```

After the last command completes you should be able to access your application using the virtual hosts you defined(see configuration above) using port 8080: `http://www.zf2app.dev:8080/` and `http://debug.zf2app.dev:8080/`.

Credits
=======

The cookbooks have been taken from [Opscode Public Cookbooks](https://github.com/opscode-cookbooks/) and some code was used from [Yann Mainier](https://github.com/ymainier)'s vagrant-lamp repository to help with the debugging.
A few files were changed to better fit the development environment and a cookbook was added to put everything together.

Please use it any way you want and add any changes that can make this vagrant configuration perfect from developing custom PHP/Zend applications.