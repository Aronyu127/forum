class AddAboutToUser < ActiveRecord::Migration
  def change
  	add_column :users, :about, :text
  	add_index :users, :about
  end
end
