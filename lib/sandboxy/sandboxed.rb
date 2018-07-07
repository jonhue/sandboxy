# frozen_string_literal: true

module Sandboxy
  module Sandboxed
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def sandboxy
        has_one :sandbox, as: :sandboxed, dependent: :destroy
        before_create :set_environment
        include Sandboxy::Sandboxed::SandboxyInstanceMethods

        default_scope { environment_scoped(Sandboxy.environment) }
        scope :desandbox, -> { unscope(:joins, :where).all }

        class << self
          include Sandboxy::Sandboxed::SandboxyClassMethods
        end
      end
    end

    module SandboxyClassMethods
      def method_missing(method, *args)
        if method.to_s[/(.+)_environment/]
          environment($1)
        elsif method.to_s[/(.+)_environment_scoped/]
          environment_scoped($1)
        else
          super
        end
      end

      def respond_to_missing?(method, include_private = false)
        super ||
          method.to_s[/(.+)_environment/] ||
          method.to_s[/(.+)_environment_scoped/]
      end

      def environment(value)
        unscope(:joins, :where).environment_scoped value
      end

      def environment_scoped(value)
        case value
        when Sandboxy.configuration.default
          left_outer_joins(:sandbox).where(sandboxy: { environment: nil })
        else
          left_outer_joins(:sandbox).where(sandboxy: { environment: value })
        end
      end
    end

    module SandboxyInstanceMethods
      def method_missing(method, *args)
        if method.to_s[/move_environment_(.+)/]
          move_environment($1)
        elsif method.to_s[/(.+)_environment?/]
          environment?($1)
        else
          super
        end
      end

      def respond_to_missing?(method, include_private = false)
        super ||
          method.to_s[/move_environment_(.+)/] ||
          method.to_s[/(.+)_environment?/]
      end

      def move_environment(environment)
        case environment
        when Sandboxy.configuration.default
          move_to_default_environment
        else
          move_to_custom_environment(environment)
        end
      end

      def environment?(value)
        environment == value
      end

      def environment
        return Sandboxy.configuration.default if sandbox.nil?
        sandbox.environment
      end

      private

      def set_environment
        return if Sandboxy.environment == Sandboxy.configuration.default
        sandbox = build_sandbox
        sandbox.environment = Sandboxy.environment
      end

      def move_to_default_environment
        Sandbox.where(sandboxed_id: id, sandboxed_type: self.class.name)
               .destroy_all
        self.sandbox = nil
        save!
      end

      def move_to_custom_environment(environment)
        sandbox ||= build_sandbox
        sandbox.environment = environment
        sandbox.save!
      end
    end
  end
end
