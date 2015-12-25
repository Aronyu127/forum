class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  ROLE_ADMIN="admin"
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
   has_many :topics  
   has_many :comments
  def short_name
    self.email.split("@").first
  end       
  
  def admin?
  	self.role==ROLE_ADMIN
  end	

end
