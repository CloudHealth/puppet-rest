# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require File.dirname(__FILE__) + '/lib/puppetdb-rest/version'

Gem::Specification.new do |s|
  s.name        = 'puppetdb-rest'
  s.version     = PuppetDbRestClient::VERSION
  s.date        = '2013-10-08'
  s.summary     = 'PuppetDB REST API Client'
  s.description = 'Interact with the PuppetDB REST Api'
  s.authors     = ['Steve Frank']
  s.email       = %w(steve@cloudhealthtech.com)
  s.homepage    = 'https://github.com/CloudHealth/puppetdb-rest'

  s.files       = `git ls-files`.split("\n")

  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

  s.require_paths = %w(lib)

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'

  s.add_dependency 'faraday', '~> 0.8.8'
  s.add_dependency 'multi_json', '~> 1.3.6'

end
