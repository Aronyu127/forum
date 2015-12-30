class UsersController < ApplicationController
  
  before_action :set_user, :only=>[:center,:update,:edit]


  def show
    @user = User.find(params[:id])
  end

  def center
  end

  def edit
  end  
  
	def update 
    if @user.update(user_params)
      redirect_to center_user_path
      flash[:notice]="更改成功"
    else 
      redirect_to edit_user_path(@user)
      flash[:alert]="更改失敗"
    end     
  end


  private
	  def set_user
	   @user = current_user  
	  end 

	  def user_params
    params.require(:user).permit(:about)
  end

end

