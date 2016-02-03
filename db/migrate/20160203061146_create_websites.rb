class CreateWebsites < ActiveRecord::Migration
  def change
    create_table :websites do |t|
    	t.integer :user_id
    	t.string :original_url
    	t.string :url
    	t.integer :usertime
      t.timestamps null: false
    end
  end
end
