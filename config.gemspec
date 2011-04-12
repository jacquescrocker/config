Gem::Specification.new do |s|
  s.name             = "config"
  s.version          = "0.3.0"
  s.date             = Date.today.to_s
  s.authors          = ["Jacques Crocker", "Fred Wu"]
  s.email            = ["railsjedi@gmail.com", "ifredwu@gmail.com"]
  s.summary          = "Provides a Settings helper for that reads from config/settings.yml"
  s.description      = "Easy to use Settings helper that loads its data in from config/settings.yml. Handles adding multiple sources, and easy reloading."
  s.homepage         = "http://github.com/railsjedi/rails_config"
  s.extra_rdoc_files = ["README.md"]
  s.rdoc_options     = ["--charset=UTF-8"]
  s.require_paths    = ["lib"]
  s.files            = `git ls-files`.split("\n")
  s.test_files       = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables      = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

  s.add_runtime_dependency "map"
  s.add_development_dependency "rspec", "~> 2.0"
end

