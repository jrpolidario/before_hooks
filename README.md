# BeforeHooks

[![Build Status](https://travis-ci.org/jrpolidario/before_hooks.svg?branch=master)](https://travis-ci.org/jrpolidario/before_hooks)

Adds `before_extended`, `before_included`, and `before_prepended` methods hooks which would be called before the standard `extended`, `included`, and `prepended` Ruby hooks, respectively.

Especially useful when you require to "do" something just before the module gets `extended`, `included`, or `prepended` to a module/class. In particular, in my specific case, I needed to "do" something first if a specific method already exists in the base class before being extended, of which then I'd use `before_extended`.

## Dependencies

* **Ruby ~> 2.0**

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'before_hooks', '~> 0.1'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install before_hooks

## Usage

### `before_included` Example

```ruby
require 'bundler/setup'
require 'before_hooks'

module SomeModule
  # not required to be defined
  def self.before_included(base)
    pp 'SomeModule#before_included'
    pp base
    pp base.ancestors
  end

  # not required to be defined:
  def self.included(base)
    pp 'SomeModule#included'
    pp base
    pp base.ancestors
  end
end

class SomeClass
  include SomeModule
end

# upon code execution, will print...

=begin

"SomeModule#before_included"
SomeClass
[SomeClass, Object, PP::ObjectMixin, Kernel, BasicObject]
"SomeModule#included"
SomeClass
[SomeClass, SomeModule, Object, PP::ObjectMixin, Kernel, BasicObject]

=end
```

### `before_extended` Example

```ruby
require 'bundler/setup'
require 'before_hooks'

module SomeModule
  # not required to be defined
  def self.before_extended(base)
    pp 'SomeModule#before_extended'
    pp base
    pp base.singleton_class.ancestors
  end

  # not required to be defined:
  def self.extended(base)
    pp 'SomeModule#extended'
    pp base
    pp base.singleton_class.ancestors
  end
end

class SomeClass
  extend SomeModule
end

# upon code execution, will print...

=begin

"SomeModule#before_extended"
SomeClass
[#<Class:SomeClass>,
 #<Class:Object>,
 #<Class:BasicObject>,
 Class,
 BeforeHooks,
 Module,
 Object,
 PP::ObjectMixin,
 Kernel,
 BasicObject]
"SomeModule#extended"
SomeClass
[#<Class:SomeClass>,
 SomeModule,
 #<Class:Object>,
 #<Class:BasicObject>,
 Class,
 BeforeHooks,
 Module,
 Object,
 PP::ObjectMixin,
 Kernel,
 BasicObject]

=end
```

### `before_prepended` Example

```ruby
require 'bundler/setup'
require 'before_hooks'

module SomeModule
  # not required to be defined
  def self.before_prepended(base)
    pp 'SomeModule#before_prepended'
    pp base
    pp base.ancestors
  end

  # not required to be defined:
  def self.prepended(base)
    pp 'SomeModule#prepended'
    pp base
    pp base.ancestors
  end
end

class SomeClass
  prepend SomeModule
end

# upon code execution, will print...

=begin

"SomeModule#before_prepended"
SomeClass
[SomeClass, Object, PP::ObjectMixin, Kernel, BasicObject]
"SomeModule#prepended"
SomeClass
[SomeModule, SomeClass, Object, PP::ObjectMixin, Kernel, BasicObject]

=end
```

## TODOs
* Need help or further research on how to support and implement `before_inherited`, `before_method_added`, and `before_method_removed`, because "prepend" trick doesn't readily work with them.
* Thanks to [@Valaramech](https://www.reddit.com/r/ruby/comments/atwg8g/just_published_a_small_gem_before_hooks/eh3uyhw/) for suggesting to support "block" DSL, and is now a TODO.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jrpolidario/before_hooks. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Special Thanks

* [@jb3689](https://www.reddit.com/r/ruby/comments/atwg8g/just_published_a_small_gem_before_hooks/ehc7851/) for suggesting to use "dynamic-matching" `.respond_to? :some_method` instead of `.singleton_class.instance_methods.include? :some_method`

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the BeforeHooks project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/jrpolidario/before_hooks/blob/master/CODE_OF_CONDUCT.md).


## Changelog

* 0.1.4
    * Now using "dynamic-matching" `.respond_to? :some_method` instead of `.singleton_class.instance_methods.include? :some_method`; thanks to [@jb3689](https://www.reddit.com/r/ruby/comments/atwg8g/just_published_a_small_gem_before_hooks/ehc7851/)
* 0.1.3
    * Initial release
