# frozen_string_literal: true

class SharedSandbox < ApplicationRecord
  self.abstract_class = true
  sandboxy
end
