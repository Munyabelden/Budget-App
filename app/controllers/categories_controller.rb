# app/controllers/categories_controller.rb
class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = Category.includes(:entities)
  end

  def show
    @category = Category.find(params[:id])
    @transactions = @category.entities.order(created_at: :desc)
    @total_amount = @category.entities.sum(:amount)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.user = current_user

    if @category.save
      redirect_to categories_path, notice: "Category created successfully."
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
