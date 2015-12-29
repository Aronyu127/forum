class Admin::CategoriesController < ApplicationController
  before_action :set_category, :only=>[:update,:destroy,]

  def index 
  	@categories=Category.all
    if params[:categories]
      @category=Category.find(params[:categories])
    else
      @category=Category.new
    end  
  end	
  
  def create
    @category=Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path
      flash[:notice]="新增成功" 
    else
      redirect_to admin_categories_path
      flash[:alert]="新增失敗"   
    end
  end 	
   
  def update
    if @category.update(category_params)
      redirect_to admin_categories_path
      flash[:notice]="新增成功"
    else
      edirect_to admin_categories_path
      flash[:alert]="新增失敗" 
    end    
  end	

  def destroy
    @category.destroy
    redirect_to admin_categories_path
    flash[:alert]="刪除成功"
  end	

  private

    def category_params
      params.require(:category).permit(:id, :name) 
    end

    def set_category
      @category= Category.find(params[:id])
    end 
end
