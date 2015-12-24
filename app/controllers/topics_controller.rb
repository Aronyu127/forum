class TopicsController < ApplicationController
  before_action :authenticate_user!, :except => [:index,:show]
  before_action :set_topic, :only =>[:edit,:destroy,:show,:update]

  def index
     
    if params[:order]=="latest"
      sort_by = "last_comment_time DESC"
    elsif params[:order]=="hot"
      sort_by = "comments_count DESC"
    else
      sort_by="created_at"
    end 
   
    if params[:keyword]
      @topics = Topic.where( [ "name like ?", "%#{params[:keyword]}%" ] )
      @topics=@topics.order(sort_by).page(params[:page]).per(8)
    elsif params[:category]    
      name=params[:category]
      c=Category.find_by_name("#{name}")
      @topics=c.topics.order(sort_by).page(params[:page]).per(8)
      
    else  
      @topics = Topic.all
      @topics=@topics.order(sort_by).page(params[:page]).per(8)
    end
  end	
  
  def show
     if params[:comment_id]
      @comment=Comment.find(params[:comment_id])
     else
      @comment=Comment.new
     end 
     @comments=@topic.comments
  end	
  def new
  	 @topic=Topic.new
  end

  def create
     @topic=Topic.new(topic_params)
     @topic.user = current_user
     if @topic.save
      redirect_to topics_path
       flash[:notice]="發表成功"
     else render :action => :new
     end    
  end

  def edit
  end	

  def update
     if @topic.update(topic_params)
      flash[:notice]="修改成功"
      redirect_to topics_path(:page => params[:page])
     else render :action => :edit
     end	
  end	

  def destroy
  	 
     @topic.destroy
     flash[:alert]="刪除文章"

     redirect_to topics_path(:page => params[:page])
  end	
	private

	def topic_params
	params.require(:topic).permit(:name,:content,:comments_count,:category_ids=>[]) 
	end

	def set_topic
     @topic=Topic.find(params[:id])
     
	end	

end