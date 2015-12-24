class Topic < ActiveRecord::Base
	validates_presence_of :name
  belongs_to :user
  has_many :comments, :dependent=>:destroy
  has_many :topic_categoryships
  has_many :categories, :through => :topic_categoryships 
  # def search_keyword
	 #  if params[:keyword]
	 #    @topics = Topic.where( [ "name like ?", "%#{params[:keyword]}%" ] )
	 #  else
	 #    @topics = Topic.all
	 #  end
  #   @topics = @topics.page(params[:page]).per(5)
  # end
end
