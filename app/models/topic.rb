class Topic < ActiveRecord::Base

	validates_presence_of :name, :content
  belongs_to :user
  has_many :comments, :dependent=>:destroy
  has_many :topic_categoryships
  has_many :categories, :through => :topic_categoryships 
  
  def latest_comment_time
    #self.last_comment_time.to_s(:short)
    if last_comment_time
      self.last_comment_time.strftime("%Y-%m-%d %H:%M")
    else
      "N/A"
    end
  end  

end
