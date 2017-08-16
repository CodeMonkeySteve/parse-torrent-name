Gem::Specification.new do |s|
  s.specification_version = 3

  s.name = 'parse-torrent-name'
  s.version = '0.5.4'
  s.date = '2017-08-15'

  s.summary = "Parses torrent name of a movie or TV show."
  s.description = "Extensible inline language for describing Ruby objects, powering schema-programming awesomeness."
  s.homepage = 'https://github.com/CodeMonkeySteve/parse-torrent-name'
  s.email = 'steve@finagle.org'
  s.authors = ["Steve Sloan"]

  s.files = [
    'LICENSE',
    'README.md',
  ] + Dir['lib/**/*']
  s.test_files = Dir['spec/**/*']
  s.extra_rdoc_files = ['README.md']

  s.add_development_dependency 'rspec'
end

