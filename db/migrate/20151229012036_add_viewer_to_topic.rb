class AddViewerToTopic < ActiveRecord::Migration
  def change
  	add_column :topics, :viewer, :integer, :default=>0,:index =>true
  end
end
