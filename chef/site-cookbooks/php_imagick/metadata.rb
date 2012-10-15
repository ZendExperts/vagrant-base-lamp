maintainer        "ZendExperts"
maintainer_email  "cosmin@zendexperts.com"
license           "Apache 2.0"
description       "Installs and maintains php imagick module"
version           "1.0"

depends "build-essential"

%w{ debian ubuntu centos redhat fedora scientific amazon }.each do |os|
  supports os
end

recipe "php_imagick", "Install the php5-imagick package"