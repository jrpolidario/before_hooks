
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'before_hooks/version'

Gem::Specification.new do |spec|
  spec.name          = 'before_hooks'
  spec.version       = BeforeHooks::VERSION
  spec.authors       = ['Jules Roman Polidario']
  spec.email         = ['jrpolidario@gmail.com']

  spec.summary       = 'Adds `before_extended`, `before_included`, and `before_prepended` methods hooks which would be called before the standard `extended`, `included`, and `prepended` Ruby hooks, respectively.'
  spec.description   = 'Adds `before_extended`, `before_included`, and `before_prepended` methods hooks which would be called before the standard `extended`, `included`, and `prepended` Ruby hooks, respectively. Especially useful when you require to "do" something just before the module gets `extended` or `included` to a module/class. In particular, in my specific case, I needed to "do" something if a specific method already exists in the `base` class.'
  spec.homepage      = 'https://github.com/jrpolidario/before_hooks'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '~> 2.0'

  spec.add_development_dependency 'byebug', '~> 9.0'
  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rspec', '~> 3.7.0'
  spec.add_development_dependency 'rake', '~> 10.0'
end
