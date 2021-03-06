module VShipping
  module Configuration
    extend ActiveSupport::Concern

    included do
      add_config :ahamove_api_key
      add_config :ahamove_config_path

      # set default values
      reset_config
    end

    module ClassMethods
      def add_config(name)
        class_eval <<-RUBY, __FILE__, __LINE__ + 1
          @#{name} = nil
          def self.#{name}(value=nil)
            @#{name} = value if value
            return @#{name} if self.object_id == #{self.object_id} || defined?(@#{name})
            name = superclass.#{name}
            return nil if name.nil? && !instance_variable_defined?(:@#{name})
            @#{name} = name && !name.is_a?(Module) && !name.is_a?(Symbol) && !name.is_a?(Numeric) && !name.is_a?(TrueClass) && !name.is_a?(FalseClass) ? name.dup : name
          end
          def self.#{name}=(value)
            @#{name} = value
          end
          def #{name}=(value)
            @#{name} = value
          end
          def #{name}
            value = @#{name} if instance_variable_defined?(:@#{name})
            value = self.class.#{name} unless instance_variable_defined?(:@#{name})
            if value.instance_of?(Proc)
              value.arity >= 1 ? value.call(self) : value.call
            else
              value
            end
          end
        RUBY
      end

      def add_deprecated_config(name)
        class_eval <<-RUBY, __FILE__, __LINE__ + 1
          def self.#{name}(value=nil)
            ActiveSupport::Deprecation.warn "##{name} is deprecated and has no effect"
          end
          def self.#{name}=(value)
            ActiveSupport::Deprecation.warn "##{name} is deprecated and has no effect"
          end
          def #{name}=(value)
            ActiveSupport::Deprecation.warn "##{name} is deprecated and has no effect"
          end
          def #{name}
            ActiveSupport::Deprecation.warn "##{name} is deprecated and has no effect"
          end
        RUBY
      end

      def configure
        yield self
      end

      ##
      # sets configuration back to default
      #
      def reset_config
        configure do |config|
          config.ahamove_api_key = nil
          config.ahamove_config_path = nil
        end
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end
  end
end