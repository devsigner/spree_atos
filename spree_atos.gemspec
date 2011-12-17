# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "spree_atos/version"

Gem::Specification.new do |s|
  s.name        = "spree_atos"
  s.version     = SpreeAtos::VERSION
  s.authors     = ["Samuel Lebeau"]
  s.email       = ["samuel.lebeau@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Atos Worldline payment integration for Spree}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]
  s.has_rdoc      = false

  # specify any dependencies here; for example:
  s.add_dependency('spree_core')
  s.add_dependency('payme', '~> 0.8')
  # s.add_development_dependency "rspec"
end
