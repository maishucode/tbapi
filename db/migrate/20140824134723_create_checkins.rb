class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.integer :journal_id, :null=>false
      t.string :title, :null=>false
      t.text :note
      t.timestamp :checkin_time, :null=>false
      t.string :longitude
      t.string :latitude
      t.string :poi

      t.timestamps
    end
  end
end
