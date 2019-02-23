require 'before_hooks/version'

module BeforeHooks
  # `base` is expected to be and should be an `Object`
  def self.prepended(base)
    base.singleton_class.send(:prepend, ClassMethods)
  end

  module ClassMethods
    def extend(*modules)
      modules.each do |_module|
        if _module.singleton_class.instance_methods.include? :before_extended
          _module.before_extended(self)
        end
      end

      super
    end

    def include(*modules)
      modules.each do |_module|
        if _module.singleton_class.instance_methods.include? :before_included
          _module.before_included(self)
        end
      end

      super
    end

    def prepend(*modules)
      modules.each do |_module|
        if _module.singleton_class.instance_methods.include? :before_prepended
          _module.before_prepended(self)
        end
      end

      super
    end
  end
end

Object.send(:prepend, BeforeHooks)
