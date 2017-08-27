require 'rails/generators'
require 'rails/generators/migration'

class SandboxyGenerator < Rails::Generators::Base

    include Rails::Generators::Migration

    source_root File.join File.dirname(__FILE__), 'templates'
    desc 'Install sandboxy'
    class_option :default, desc: 'Set to default environment. Accepts either `live` or `sandbox`.', type: :boolean, default: false, aliases: '-d'
    class_option :retain_environment, desc: "Whether your app should retain it's environment at runtime on new requests.", type: :boolean, default: false, aliases: '-re'

    def self.next_migration_number dirname
        if ActiveRecord::Base.timestamped_migrations
            Time.now.utc.strftime '%Y%m%d%H%M%S'
        else
            "%.3d" % (current_migration_number(dirname) + 1)
        end
    end

    def create_migration_file
        migration_template 'migration.rb.erb', 'db/migrate/sandboxy_migration.rb', migration_version: migration_version
    end

    def create_configuration
        template 'configuration.yml.erb', 'config/sandboxy.yml'
    end

    def create_model
        template 'model.rb', 'app/models/sandbox.rb'
    end

    def show_readme
        readme 'README.md'
    end

    private

    def migration_version
        if Rails.version >= '5.0.0'
            "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
        end
    end

end
