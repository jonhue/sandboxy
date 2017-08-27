class Sandbox < ActiveRecord::Base

    self.table_name = 'sandboxy'

    belongs_to :sandboxed, polymorphic: true

end
