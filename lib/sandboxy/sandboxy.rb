module Sandboxy
    module Sandboxy

        def self.included base
            base.extend ClassMethods
        end

        module ClassMethods
            def sandboxy
                default_scope -> { where(sandbox: true) } if $sandbox == true
                default_scope -> { where(sandbox: false) } if $sandbox == false
                # Create new records with `sandbox: true` if the sandbox is currently enabled!
            end
        end

    end
end
