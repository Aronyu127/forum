class Category < ActiveRecord::Base

	 validates_presence_of :name
	 
	 has_many :topic_categoryships
	 has_many :topics, :through => :topic_categoryships 
end
