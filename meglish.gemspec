Gem::Specification.new do |s|
  s.name        = 'meglish'
  s.version     = '1.0.22'
  s.date        = '2017-09-20'
  s.summary     = "Meglish is a super framework to Calabash-Android"
  s.description = "Meglish find automatically your elements inside your Android Apps"
  s.authors     = ["Eduardo Gomes Heinen"]
  s.email       = 'eduardogheinen@gmail.com'
  s.files       = ["lib/meglish.rb", "lib/meglish-log.rb"]
  s.homepage    = 'http://rubygems.org/gems/meglish'
  s.license     = 'AGPL-3.0'
  s.add_runtime_dependency 'calabash-android', '~> 0.9.0'
end
