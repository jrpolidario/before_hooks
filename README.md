# BeforeHooks

[![Build Status](https://travis-ci.org/jrpolidario/before_hooks.svg?branch=master)](https://travis-ci.org/jrpolidario/before_hooks)

Raises error if method already defined to designated `include`, `extend`, or `prepend` base Module/Class.
Prevents "silent-failures" and indirect bugs caused by overriding functionality (inter-gems-wide), of which you have no control of.
Take note though that this does not let a module/class to be non-overridable.
It only promotes and delegates responsibility to the developer to ensure that he/she does not unnecessarily cause "hidden" bugs.

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

SomeModule#before_included
SomeClass
[SomeClass, BeforeHooks, Object, PP::ObjectMixin, Kernel, BasicObject]
SomeModule#included
SomeClass
[SomeClass, SomeModule, BeforeHooks, Object, PP::ObjectMixin, Kernel, BasicObject]

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

SomeModule#before_extended
SomeClass
[#<Class:SomeClass>,
 BeforeHooks::ClassMethods,
 #<Class:Object>,
 #<Class:BasicObject>,
 Class,
 Module,
 BeforeHooks,
 Object,
 PP::ObjectMixin,
 Kernel,
 BasicObject]
SomeModule#extended
SomeClass
[#<Class:SomeClass>,
 SomeModule,
 BeforeHooks::ClassMethods,
 #<Class:Object>,
 #<Class:BasicObject>,
 Class,
 Module,
 BeforeHooks,
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

SomeModule#before_prepended
SomeClass
[SomeClass, BeforeHooks, Object, PP::ObjectMixin, Kernel, BasicObject]
SomeModule#prepended
SomeClass
[SomeModule, SomeClass, BeforeHooks, Object, PP::ObjectMixin, Kernel, BasicObject]

=end
```

## TODOs
* Need help or further research on how to support and implement `before_inherited`, `before_method_added`, and `before_method_removed`, because "prepend" trick doesn't readily work with them.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jrpolidario/before_hooks. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the BeforeHooks project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/jrpolidario/before_hooks/blob/master/CODE_OF_CONDUCT.md).
