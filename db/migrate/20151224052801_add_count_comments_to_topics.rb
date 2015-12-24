class AddCountCommentsToTopics < ActiveRecord::Migration
  def change
  	add_column :topics, :comments_count,:integer, :default=>0
  	add_index :topics, :comments_count

    add_column :topics, :last_comment_time,:datetime
    add_index :topics, :last_comment_time
  end
end