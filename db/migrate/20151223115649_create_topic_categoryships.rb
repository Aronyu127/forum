class CreateTopicCategoryships < ActiveRecord::Migration
  def change
    create_table :topic_categoryships do |t|
      t.integer :topic_id
      t.integer :category_id
      t.timestamps null: false
    end
    add_index :topic_categoryships,:topic_id
    add_index :topic_categoryships,:category_id
  end
end
