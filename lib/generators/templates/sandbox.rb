class Sandbox < ActiveRecord::Base

    extend Sandboxy::SandboxScopes

    self.table_name = 'sandboxy'

    belongs_to :sandboxed, polymorphic: true

end
