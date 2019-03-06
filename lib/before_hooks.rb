require 'before_hooks/version'

module BeforeHooks
  def extend(*modules)
    modules.each do |_module|
      if _module.respond_to? :before_extended
        _module.before_extended(self)
      end
    end

    super
  end

  def include(*modules)
    modules.each do |_module|
      if _module.respond_to? :before_included
        _module.before_included(self)
      end
    end

    super
  end

  def prepend(*modules)
    modules.each do |_module|
      if _module.respond_to? :before_prepended
        _module.before_prepended(self)
      end
    end

    super
  end

  # # TODO: add a `before_method_added` and `before_method_reoved`; not yet working; couldn't yet think of a solution
  # def method_added(method_name)
  #   puts 'METHOD ADDED!'
  #   puts singleton_class.instance_methods.include? :before_method_added
  #   if singleton_class.instance_methods.include? :before_method_added
  #     before_method_added(args)
  #   end
  #
  #   super
  # end
  #
  # def method_removed(*args)
  #   if singleton_class.instance_methods.include? :before_method_removed
  #     before_method_removed(args)
  #   end
  #
  #   super
  # end
end

Module.send(:prepend, BeforeHooks)
