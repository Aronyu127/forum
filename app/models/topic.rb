class Topic < ActiveRecord::Base
	validates_presence_of :name
  belongs_to :user
  has_many :comments, :dependent=>:destroy
  has_many :topic_categoryships
  has_many :categories, :through => :topic_categoryships 
  
  def latest_comment_time
    self.last_comment_time.to_s.split("U").first
  end  
end
