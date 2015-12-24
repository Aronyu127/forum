class Category < ActiveRecord::Base
	 has_many :topic_categoryships
	 has_many :topics, :through => :topic_categoryships 
end
