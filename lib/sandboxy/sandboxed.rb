module Sandboxy
    module Sandboxed

        def self.included base
            base.extend ClassMethods
        end

        module ClassMethods

            def sandboxy
                has_one :sandbox, as: :sandboxed, dependent: :destroy
                before_create :set_environment
                include Sandboxy::Sandboxed::InstanceMethods

                default_scope { self.environment_scoped(Sandboxy.environment) }
                scope :desandbox, -> { unscope(:joins, :where).all }

                def method_missing m, *args
                    if m.to_s[/(.+)_environment/]
                        self.environment $1
                    elsif m.to_s[/(.+)_environment_scoped/]
                        self.environment_scoped $1
                    else
                        super
                    end
                end

                def respond_to? m, include_private = false
                    super || m.to_s[/(.+)_environment/] || m.to_s[/(.+)_environment_scoped/]
                end

                def environment value
                    unscope(:joins, :where).environment_scoped value
                end

                def environment_scoped value
                    case value
                    when Sandboxy.configuration.default
                        left_outer_joins(:sandbox).where sandboxy: { environment: nil }
                    else
                        left_outer_joins(:sandbox).where sandboxy: { environment: value }
                    end
                end
            end

        end

        module InstanceMethods

            def method_missing m, *args
                if m.to_s[/move_environment_(.+)/]
                    self.move_environment $1
                elsif m.to_s[/(.+)_environment?/]
                    self.environment? $1
                else
                    super
                end
            end

            def respond_to? m, include_private = false
                super || m.to_s[/move_environment_(.+)/] || m.to_s[/(.+)_environment?/]
            end

            def move_environment value
                case value
                when Sandboxy.configuration.default
                    Sandbox.where(sandboxed_id: self.id, sandboxed_type: self.class.name).destroy_all
                    self.sandbox = nil
                    self.save!
                else
                    unless self.sandbox.nil?
                        self.sandbox.update_attributes environment: value
                    else
                        sandbox = self.build_sandbox
                        sandbox.environment = value
                        sandbox.save!
                    end
                end
            end

            def environment? value
                self.environment == value
            end

            def environment
                return Sandboxy.configuration.default if self.sandbox.nil?
                self.sandbox.environment
            end

            private

            def set_environment
                unless Sandboxy.environment == Sandboxy.configuration.default
                    sandbox = self.build_sandbox
                    sandbox.environment = Sandboxy.environment
                end
            end

        end

    end
end
