class TopicsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]
  before_action :set_topic, :only =>[:show, :about_user,:collect,:destroy_collect]
  before_action :set_my_topic, :only =>[:edit, :destroy, :update]
  
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

  def collect
    @user=current_user
    if current_user.collected_topics.find_by_id(@topic.id)
      redirect_to topics_path(:page => params[:page])
      flash[:alert]="您已收藏過該文章"
    else  
      @collectionship=Collectionship.new(:user_id=>@user.id,:topic_id=>@topic.id)
      @collectionship.save
      redirect_to topics_path(:page => params[:page])
    end  
  end  

  def destroy_collect
    @user=current_user
    @collectionship=Collectionship.find_by_topic_id(@topic.id)
    @collectionship.destroy

    flash[:alert] = "取消收藏"
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