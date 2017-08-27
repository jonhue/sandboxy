module Sandboxy

    def self.environment
        config = get_config
        if config&.key(:environment)
            config[:environment]
        else
            'live'
        end
    end

    def self.sandbox?
        Sandboxy.environment == 'sandbox' ? true : false
    end

    def self.live?
        !Sandboxy.sandbox?
    end

    def self.retain_environment
        config = get_config
        if config&.key(:retain_environment)
            config[:retain_environment]
        else
            false
        end
    end


    private


    def self.get_config
        require 'yaml'

        begin
            config = YAML.load_file 'config/sandboxy.yml'
        rescue Exception
        end

        return config if config
    end

end
