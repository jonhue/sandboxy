ActiveRecord::Schema.define version: 0 do

    create_table :sandboxy, force: true do |t|
        t.references :sandboxed, polymorphic: true, index: true
        t.string :environment, index: true
        t.datetime :created_at
        t.datetime :updated_at
    end

    create_table :users, force: true do |t|
        t.column :name, :string
    end

    create_table :somes, force: true do |t|
        t.column :name, :string
    end

end
