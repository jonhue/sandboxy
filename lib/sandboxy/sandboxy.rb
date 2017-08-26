module Sandboxy
    module Sandboxy

        def self.included base
            base.extend ClassMethods
        end

        module ClassMethods

            def sandboxy
                default_scope -> { where(sandbox: true) } if $sandbox == true
                default_scope -> { where(sandbox: false) } if $sandbox == false
                include Sandboxy::Sandboxy::Methods

                before_commit :add_to_sandbox
            end

        end

        module Methods

            def add_to_sandbox
                sandbox = true if $sandbox == true
            end

        end

    end
end
