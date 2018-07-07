# frozen_string_literal: true

class User < SharedSandbox
  validates_presence_of :name
end
