require 'sandboxy/version'

module ActsAsFavoritor

    autoload :Sandboxed, 'sandboxy/sandboxed'
    autoload :SandboxScopes, 'sandboxy/sandbox_scopes'

    require 'sandboxy/railtie'

end
