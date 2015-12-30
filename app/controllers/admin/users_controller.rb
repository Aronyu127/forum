class Admin::UsersController < ApplicationController
  
  layout "admin"
  
  before_action :authenticate_user!
  before_action :set_user, :only=>[:edit,:update]

  def edit
  end 

	def update
    if params[:role]=="admin"||params[:role]==nil    
      @user.update(user_params)
      redirect_to admin_categories_path
      flash[:notice]="更改成功"
    else 
      redirect_to admin_categories_path
      flash[:alert]="此權限不存在"  
    end
  end

  private

  def set_user
    @user=User.find(params[:id])
  end  

  def user_params
    params.require(:user).permit(:role) 
  end
end
