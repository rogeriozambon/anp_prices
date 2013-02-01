# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = "anp_prices"
  s.authors = ["Rogério Zambon"]
  s.email = ["rogeriozambon@gmail.com"]
  s.date = "2013-02-01"
  s.description = "Get fuel prices of the ANP - Agência Nacional do Petróleo, Gás Natural e Biocombustíveis"
  s.homepage = "http://github.com/rogeriozambon/anp_prices"

  s.add_dependency "rest-client", ">= 1.6.7"
  s.add_dependency "nokogiri", ">= 1.5.6"
  s.add_development_dependency "fakeweb", ">= 1.3"

  s.files = `git ls-files`.split("\n")
  s.require_paths = ["lib"]

  s.required_rubygems_version = Gem::Requirement.new(">= 1.8.23")
  s.summary = s.description

  s.version = "1.02"
end
