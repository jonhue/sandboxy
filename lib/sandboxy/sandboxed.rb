module Sandboxy
    module Sandboxed

        def self.included base
            base.extend ClassMethods
        end

        module ClassMethods

            def sandboxy
                has_one :sandbox, as: :sandboxed, dependent: :destroy
                include Sandboxy::Sandboxed::InstanceMethods

                scope :live_scoped, -> { left_outer_joins(:sandbox).where(sandbox: { id: nil }) }
                scope :sandboxed_scoped, -> { left_outer_joins(:sandbox).where.not(sandbox: { id: nil }) }
                default_scope {
                    case $sandbox
                    when true then sandboxed_scoped
                    when false then live_scoped
                    end
                }
                scope :live, -> { unscope(:joins, :where).live_scoped }
                scope :sandboxed, -> { unscope(:joins, :where).sandboxed_scoped }
                scope :desandbox, -> { unscope(:joins, :where).all }

                # before_save :make_sandboxed # -> should be handled automatically through default_scope
            end

        end

        module InstanceMethods

            def make_sandboxed
                self.build_sandbox unless self.sandbox.present?
            end

            def make_live
                self.sandbox.destroy if self.sandbox.present?
            end

            def sandboxed?
                self.sandbox.present?
            end

            def live?
                !self.sandbox.present?
            end

        end

    end
end
