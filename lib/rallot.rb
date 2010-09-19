require 'rubygems'
require 'bundler/setup'

Dir["#{File.dirname(__FILE__)}/rallot/*.rb"].each {|file| require file }