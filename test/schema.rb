ActiveRecord::Schema.define version: 0 do

    create_table :sandboxy, force: true do |t|
        t.integer :sandboxed_id, null: false
        t.string :sandboxed_type, null: false
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
