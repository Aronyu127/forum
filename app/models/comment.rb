class Comment < ActiveRecord::Base
	belongs_to :user 
	belongs_to :topic, touch: :last_comment_time
end
