# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |s|
  s.name        = 'v_shipping'
  s.version     = '0.0.1'
  s.date        = '2020-12-24'
  s.summary     = "VN Shipping!"
  s.description = "VN Shipping Gem"
  s.authors     = ["John Nguyễn"]
  s.email       = 'tainv.it93@gmail.com'
  s.files = Dir["{lib}/**/*"]
  s.rdoc_options = ["--main"]
  s.require_paths = ["lib"]
  s.homepage    =
    'https://rubygems.org/gems/v_shipping'
  s.license       = 'MIT'
end