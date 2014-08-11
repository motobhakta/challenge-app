class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
    	t.string "username", :limit => 50, :null => false
      t.string "password_digest"
		  t.column "first_name", :string, :limit => 25
		  t.string "last_name", :limit => 50
		  t.string "email", :default => '', :null => false
      t.string "user_type", :default => 'user', :null => false
      t.boolean "active", :default => true, :null => false
		  t.timestamps
    end
    add_index('users','username',:unique => true)
    add_index('users','user_type')
    add_index('users','active')
  end
  
  def down
	drop_table :users
  end
end
