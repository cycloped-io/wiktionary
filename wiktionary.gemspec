Gem::Specification.new do |s|
  s.name = "wiktionary"
  s.version = "0.1.1"
  s.date = "#{Time.now.strftime("%Y-%m-%d")}"
  s.required_ruby_version = '>= 2.0.0'
  s.authors = ['Krzysztof Wróbel','Aleksander Smywiński-Pohl']
  s.email   = ["djstrong@gmail.com","apohllo@o2.pl"]
  s.homepage    = "http://github.com/cycloped-io/wiktionary"
  s.summary = "Word morphology and conversion based on Wiktionary"
  s.description = "English words morphological description and basic conversion rules based on the English Wiktionary."
  s.license = "http://opensource.org/licenses/MIT"

  s.rubyforge_project = "wiktionary"
  s.rdoc_options = ["--main", "Readme.md"]

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = "lib"

  s.add_dependency("unicode_utils")

  s.add_development_dependency("rspec", [">= 3.2.0","< 4.0.0"])
  s.add_development_dependency("rake", [">= 10.4.0","< 11.0.0"])
end

