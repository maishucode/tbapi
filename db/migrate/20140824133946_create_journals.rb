class CreateJournals < ActiveRecord::Migration
  def change
    create_table :journals do |t|
      t.integer :user_id, :null=>false
      t.string :title, :null=>false
      t.text :note
      t.timestamp :start_time, :null=>false
      t.timestamp :end_time
      t.boolean :is_current, :null=>false, :default=>true

      t.timestamps
    end
  end
end
