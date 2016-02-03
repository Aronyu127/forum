class User < ActiveRecord::Base

  ROLE_ADMIN = "admin"

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :omniauthable, :omniauth_providers => [:facebook]
  
  has_many :topics  
  has_many :comments

  has_many :collectionships, :dependent=>:destroy
  has_many :collected_topics, :through=>:collectionships, :source=>:topic

  has_many :likes
  has_many :liked_topics, :through => :likes, :source => :topic
 
  has_many :subscriptions
  has_many :subscribed_topics, :through => :subscriptions, :source => :topic

  has_many :websites
  
  def short_name
    self.email.split("@").first
  end       
  
  def admin?
  	self.role == ROLE_ADMIN
  end	

  def self.from_omniauth(auth)
    # Case 1: Find existing user by facebook uid
    user = User.find_by_fb_uid( auth.uid )
    if user
       user.fb_token = auth.credentials.token
       #user.fb_raw_data = auth
       user.save!
      return user
    end

    # Case 2: Find existing user by email
    existing_user = User.find_by_email( auth.info.email )
    if existing_user
      existing_user.fb_uid = auth.uid
      existing_user.fb_token = auth.credentials.token
      #existing_user.fb_raw_data = auth
      existing_user.save!
      return existing_user
    end

    # Case 3: Create new password
    user = User.new
    user.fb_uid = auth.uid
    user.fb_token = auth.credentials.token
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    #user.fb_raw_data = auth
    user.save!
    return user
  end


end
