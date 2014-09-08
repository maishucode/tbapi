class AddUsersName < ActiveRecord::Migration
  def up
    add_column :users, :name, :string, :null=>false
    add_column :users, :utype, :string, :null=>false, :default=>"TB" #user type 
  end

  def down
    remove_column :users, :name
    remove_column :users, :utype
  end
end
