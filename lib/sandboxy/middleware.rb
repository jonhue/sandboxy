# frozen_string_literal: true

module Sandboxy
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(_env)
      require 'sandboxy'

      previous_environment = Sandboxy.environment
      $sandboxy = nil

      return unless Sandboxy.environment != previous_environment

      puts "Sandboxy: Moved to #{Sandboxy.configuration.default} environment"
    end
  end
end
