Gem::Specification.new do |s|
  s.name        = 'meglish'
  s.version     = '1.0.2'
  s.date        = '2016-11-12'
  s.summary     = "Meglish is a super framework to Calabash-Android"
  s.description = "Meglish find automatically your elements inside your Android Apps"
  s.authors     = ["Eduardo Gomes Heinen"]
  s.email       = 'eduardogheinen@gmail.com'
  s.files       = ["lib/meglish_core.rb", "lib/meglish_helper.rb", "lib/meglish_log.rb"]
  s.homepage    = 'http://rubygems.org/gems/meglish'
  s.license     = 'AGPL-3.0'
  s.add_runtime_dependency 'calabash-android', '~> 0.8.2', '>= 0.8.2'
end
