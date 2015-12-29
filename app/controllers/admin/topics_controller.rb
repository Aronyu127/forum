class Admin::TopicsController < ApplicationController

	before_action :authenticate_user!

	before_action :check_admin

    layout "admin"

  before_action :authenticate_user!, :except => [:index,:show]
  before_action :set_topic, :only =>[:edit,:destroy,:show,:update,:about_user]
  before_action :set_user, :only =>[:center_user,:edit_about_user,:update_about_user]
  # before_action :authenticate_admin, :only =>
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
    t=@topic
    t.viewer+=1
    t.save
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
    @topic=current_user.topics.new(topic_params)
    
    if @topic.save
      redirect_to topics_path
      flash[:notice]="發表成功"
    else 
      render :action => :new
      flash[:alert]="文章主題與內容皆不可留白"
    end    
  end

  def edit
  end 


  def update
     @topic=Topic.find(params[:id])

    
    if @topic.update(topic_params)
     flash[:notice]="修改成功"
     redirect_to topics_path(:page => params[:page])
    else 
      render :action => :edit  
      flash[:alert]="文章主題與內容皆不可留白"
    end 
  end   

  def destroy    
    if @topic.destroy
      flash[:alert]="刪除文章"
      redirect_to topics_path(:page => params[:page])
    end
  end
     
  def about_user
    @user=@topic.user
  end

  def center_user
  end

  def edit_about_user 
  end  

  def update_about_user 
    if @user.update(user_params)
      redirect_to center_user_topics_path
      flash[:notice]="更改成功"
    else 
      redirect_to edit_about_user_topic_path(@user)
      flash[:alert]="更改失敗"
    end     
  end

 
  

  def authenticate_admin
    unless current_user.admin?
      flash[:alert]="你沒有管理者權限"
      redirect_to topics_path
    end  
  end

  private

    def topic_params
      params.require(:topic).permit(:name,:content,:comments_count,:about,:category_ids=>[]) 
    end

    def user_params
      params.require(:user).permit(:about)
    end

    def set_topic
     @topic=Topic.find(params[:id])
     
    end 

    def set_user
     @user=current_user  
    end 

    def check_admin 
    	unless current_user.role=="admin"
        redirect_to root_path
    	end	
    end
end