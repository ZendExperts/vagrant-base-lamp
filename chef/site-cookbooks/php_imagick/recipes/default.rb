#
# Author::  Cosmin Harangus (<cosmin@zendexperts.com>)
# Cookbook Name:: php
# Recipe:: default
#
# Copyright 2012, ZendExperts
#

pkg = value_for_platform(
  %w(centos redhat scientific fedora) => {
    %w(5.0 5.1 5.2 5.3 5.4 5.5 5.6 5.7 5.8) => "php53-imagick",
    "default" => "php-imagick"
  },
  "default" => "php5-imagick"
)

package pkg do
  action :install
end
