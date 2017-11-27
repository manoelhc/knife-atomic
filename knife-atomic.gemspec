# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "knife-atomic/version"

Gem::Specification.new do |s|
  s.name        = "knife-atomic"
  s.version     = Knife::Atomic::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Manoel Carvalho"]
  s.email       = ["manoelhc@gmail.com"]
  s.homepage    = "https://github.com/manoelhc/knife-atomic"
  s.summary     = "knife-atomic: get the cookbook installed versions of your environment"
  s.description = "Chef knife plugin to retrieve settings with the cookbook versions fixed"
  s.license     = "MIT"
  s.rubyforge_project = "knife-atomic"
  s.files         = `find ./ -type f | egrep -v '\.(gem|git)' | sed 's,./,,'`.split("\n")
  s.require_paths = ["lib"]
end
