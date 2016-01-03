class Topic < ActiveRecord::Base

	validates_presence_of :name, :content
  belongs_to :user
  has_many :comments, :dependent=>:destroy
  has_many :topic_categoryships
  has_many :categories, :through => :topic_categoryships 

  has_many :collectionships, :dependent=>:destroy
  has_many :collected_users, :through=>:collectionships, :source=>:user
  
  has_many :likes
  has_many :liked_users, :through => :likes, :source => :user

  has_many :subscriptions
  has_many :subscribed_users, :through => :subscriptions, :source => :user
  
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  def find_my_like(u)
     if u
       self.likes.where( :user_id => u.id ).first
     else
       nil
     end
  end
 
  def latest_comment_time
    #self.last_comment_time.to_s(:short)
    if last_comment_time
      self.last_comment_time.strftime("%Y-%m-%d %H:%M")
    else
      "N/A"
    end
  end  

end
