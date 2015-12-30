class TopicsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]
  before_action :set_topic, :only =>[:show, :about_user]
  before_action :set_my_topic, :only =>[:edit, :destroy, :update]
  
  before_action :set_user, :only =>[:center_user, :edit_about_user, :update_about_user]

  def index
     
    if params[:order]=="latest"
      sort_by = "last_comment_time DESC"
    elsif params[:order]=="hot"
      sort_by = "comments_count DESC"
    elsif params[:order]=="viewer"
      sort_by = "viewer DESC"  
    else
      sort_by="created_at"
    end 
   
    if params[:keyword]
      @topics = Topic.where( [ "name like ?", "%#{params[:keyword]}%" ] )
    elsif params[:category]   
      c = Category.find_by_name( params[:category] )
      @topics = c.topics
    else  
      @topics = Topic.all
    end

    @topics = @topics.order(sort_by).page(params[:page]).per(8)
  end	
  
  def show
    @topic.viewer+=1
    @topic.save

    if params[:comment_id]
      @comment = @topic.comments.find(params[:comment_id])
    else
      @comment = Comment.new
    end 

    @comments = @topic.comments
  end	

  def new
  	@topic = Topic.new
  end

  def create
    @topic = current_user.topics.new(topic_params)
    
    if @topic.save      
      flash[:notice]="發表成功"
      redirect_to topics_path
    else 
      render :action => :new      
    end    
  end

  def edit
  end	

  def update
    if @topic.update(topic_params)
     flash[:notice] = "修改成功"
     redirect_to topics_path(:page => params[:page])
    else 
      render :action => :edit  
    end 
  end 	

  def destroy
    @topic.destroy

    flash[:alert] = "刪除文章"
    redirect_to topics_path(:page => params[:page])
  end
     

	private

  def topic_params
    params.require(:topic).permit(:name,:content,:comments_count,:about,:category_ids=>[]) 
  end


  def set_topic
   @topic = Topic.find(params[:id])
  end	

  def set_my_topic
    @topic = current_user.topics.find(params[:id])
  end

  

 end