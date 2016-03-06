# encoding: utf-8

require "./lib/LazGem/version"

Gem::Specification.new do |s|
  s.name        = "LazGem"
  s.version     = ::LazGem::Client::VERSION
  s.summary     = "Ruby client for Lazurite 920MHz module"
  s.description = "Lazurite Ruby Driver Interface"
  s.authors     = ["Naotaka Saito, Eiichi Saito"]
  s.email       = ["lazurite@adm.lapis-semi.com"]
  s.homepage    = "http://github.com/LAPIS-Lazurite/LazGem"
  s.licenses    = ["MIT"]

  s.files = Dir[
                "LICENSE",
                "README.md",
                "lib/**/*.rb",
                "*.gemspec",
               ]
end
