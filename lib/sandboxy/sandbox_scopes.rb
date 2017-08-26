module Sandboxy
    module SandboxScopes

        def live
            left_outer_joins(:sandbox).where sandbox: { id: nil }
        end

        def sandboxed
            left_outer_joins(:sandbox).where.not sandbox: { id: nil }
        end

    end
end
