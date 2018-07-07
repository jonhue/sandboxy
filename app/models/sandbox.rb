# frozen_string_literal: true

class Sandbox < ApplicationRecord
  self.table_name = 'sandboxy'

  belongs_to :sandboxed, polymorphic: true
end
