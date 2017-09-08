Gem::Specification.new do |s|
  s.name = 'csslite'
  s.version = '0.1.2'
  s.summary = 'An experimental gem to parse CSS and propagate the style ' + 
      'attributes for the associated nodes using the selectors'
  s.authors = ['James Robertson']
  s.files = Dir['lib/csslite.rb']
  s.signing_key = '../privatekeys/csslite.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@jamesrobertson.eu'
  s.homepage = 'https://github.com/jrobertson/csslite'
end
