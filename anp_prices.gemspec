# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.authors = ["Rogério Zambon"]
  s.date = "2013-01-12"
  s.description = "Get fuel prices of the ANP - Agência Nacional do Petróleo, Gás Natural e Biocombustíveis"
  s.email = "rogeriozambon@gmail.com"
  s.add_dependency "rest-client", ">= 1.6.7"
  s.add_dependency "nokogiri", ">= 1.5.6"
  s.files = [
    "lib/anp_prices.rb",
    "spec/anp_prices_spec.rb",
    "spec/fixture/anp_sao_paulo.html",
    "VERSION",
    "anp_prices.gemspec"
  ]
  s.homepage = "http://github.com/rogeriozambon/anp_prices"
  s.name = "anp_prices"
  s.require_paths = ["lib"]
  s.required_rubygems_version = Gem::Requirement.new(">= 1.8.23")
  s.summary = s.description
  s.version = "1.01"
end
