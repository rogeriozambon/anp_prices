# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "anp_prices/version"

Gem::Specification.new do |s|
  s.name        = "anp_prices"
  s.version     = ANP::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Rogério Zambon"]
  s.email       = ["rogeriozambon@gmail.com"]
  s.homepage    = "http://github.com/rogeriozambon/anp_prices"
  s.summary     = "Get fuel prices of the ANP - Agência Nacional do Petróleo, Gás Natural e Biocombustíveis."
  s.description = s.summary

  s.files         = `git ls-files`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency "rest-client", ">= 1.6.7"
  s.add_dependency "nokogiri", ">= 1.5.6"

  s.add_development_dependency "rake"
  s.add_development_dependency "fakeweb", ">= 1.3"
  s.add_development_dependency "rspec"
end
