class Admin::CategoriesController < ApplicationController
  
  layout "admin"
  
  before_action :authenticate_user!
  before_action :set_category, :only=>[:update,:destroy]
  before_action :authenticate_admin

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
    if @category.topics.all==[] 
       @category.destroy
      redirect_to admin_categories_path
      flash[:alert]="刪除成功"
    else  
      redirect_to admin_categories_path
      flash[:alert]="無法刪除 該分類已存在文章"
    end  
  end	

  private

    def category_params
      params.require(:category).permit(:id, :name) 
    end

    def set_category
      @category= Category.find(params[:id])
    end 
end
