class Collectionship < ActiveRecord::Base
	belongs_to :topic
	belongs_to :user
end
