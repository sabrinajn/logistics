class CreateTables < ActiveRecord::Migration
  def up
    create_table "maps", :force => true do |t|
      t.string   "name"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "routes", :force => true do |t|
      t.string   "source"
      t.string   "target"
      t.integer  "distance"
      t.integer  "map_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end

  def down
    drop_table :maps
    drop_table :routes
  end
end

