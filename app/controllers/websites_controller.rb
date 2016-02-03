class WebsitesController < ApplicationController

	before_action :authenticate_user!

	def index
		if params[:url]
			@website = Website.find_by_url("#{params[:url]}")
			redirect_to @website.original_url
		else
		  @website = Website.new	
		  @websites = current_user.websites.all
		end  	

		
	end	

  def create
  	@user = current_user
  	@website = Website.new(:user_id=> @user.id,:original_url => params[:website][:original_url])
    @website.url = SecureRandom.hex(10)
    @website.save
    flash[:notice] = "創造成功"
    redirect_to :back
  end
end
