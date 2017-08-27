class SandboxyMigration < ActiveRecord::Migration[5.1]
    def self.up
        create_table :sandboxy, force: true do |t|
            t.references :sandboxed, polymorphic: true, null: false
            t.timestamps
        end

        add_index :sandboxy, ['sandboxed_id', 'sandboxed_type'], name: 'sandboxy_sandboxed'
    end

    def self.down
        drop_table :sandboxy
    end
end
