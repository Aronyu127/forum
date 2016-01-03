class TopicCommentsController < ApplicationController
  
  before_action :authenticate_user!, :except => [:create, :update, :destroy]  
  before_action :set_topic
  before_action :set_comments

  def new
    @comment = Comment.new    
  end

  def create
    #@comment = @topic.comments.new(topic_comments_params)
  	@comment = Comment.new(topic_comments_params)
    @comment.topic = @topic
  	@comment.user = current_user

  	if @comment.save

      flash[:notice]="回復成功"
  	  redirect_to topic_path(@topic)    
  	else 
  	  render "topics/show"
  	end
  end	

  def update
    @comment = current_user.comments.find(params[:id])
    if @comment.update(topic_comments_params)
      flash[:notice]="修改成功" 
      redirect_to topic_path(@topic)
    else
      render "topics/show"
    end 
  end  

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy

    flash[:alert]="刪除回覆"

    redirect_to topic_path(@topic)
  end

  protected

  def set_topic
  	@topic = Topic.find(params[:topic_id])
  end	

  def topic_comments_params
	  params.require(:comment).permit(:content,:topic_id,:user_id) 
	end

  def set_comments
    @comments=@topic.comments
  end
end
