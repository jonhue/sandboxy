module Sandboxy
    module Sandboxed

        def self.included base
            base.extend ClassMethods
        end

        module ClassMethods

            def sandboxy
                has_one :sandbox, as: :sandboxed, dependent: :destroy
                include Sandboxy::Sandboxed::InstanceMethods

                scope :live, -> { left_outer_joins(:sandbox).where(sandbox: { id: nil }) }
                scope :sandboxed, -> { left_outer_joins(:sandbox).where.not(sandbox: { id: nil }) }
                default_scope where(
                    case $sandbox
                    when true then { sandboxed }
                    when false then { live }
                    end
                )

                before_save :make_sandboxed
            end

        end

        module InstanceMethods

            def make_sandboxed
                self.build_sandbox if $sandbox == true && self.sendbox.present? == false
            end

            def make_live
                self.sandbox.destroy
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
