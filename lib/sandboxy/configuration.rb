module Sandboxy

    class << self
        attr_accessor :configuration
    end

    def self.configure
        self.configuration ||= Configuration.new
        yield configuration
    end

    class Configuration

        attr_accessor :environment
        attr_accessor :retain_environment

        def initialize
            @environment = 'live'
            @retain_environment = false
        end

        def sandbox?
            self.environment == 'sandbox' ? true : false
        end

        def live?
            !self.sandbox?
        end

    end
end
