require 'config/options'
require 'config/sources/yaml_source'

require 'config/vendor/deep_merge' unless defined?(DeepMerge)


module Config
  # ensures the setup only gets run once
  @@_ran_once = false

  @@const_name = "Settings" unless defined? @@const_name
  def self.const_name
    @@const_name
  end

  def self.const_name=(obj)
    @@const_name = obj
  end

  def self.setup(*files)
    yield self if @@_ran_once == false and block_given?
    sources(*files)
    @@_ran_once = true
  end

  # Loads and sets the settings constant!
  def self.sources(*files)
    config = Options.from_files(*files)

    # setup constant
    Kernel.send(:remove_const, Config.const_name) if Kernel.const_defined?(Config.const_name)
    Kernel.const_set(Config.const_name, config)
  end

  def self.reload!
    Kernel.const_get(Config.const_name).reload!
  end
end
