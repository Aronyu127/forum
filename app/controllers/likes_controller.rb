class LikesController < ApplicationController

	before_action :set_topic
  before_action :authenticate_user!, :except => [:index, :show]

  # like
  def create
     Like.create!( :topic => @topic, :user => current_user )
    # respond_to do |format|
    #   format.html{ redirect_to :back}
    #   format.js # create.js.erb
    # end  
  end

  # unlike
  def destroy
    like = current_user.likes.find( params[:id] )
    like.destroy

    # respond_to do |format|
    #   format.html{ redirect_to :back}
    #   format.js
    # end  
  end

  private

  

end
