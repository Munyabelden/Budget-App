# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @categories = @user.categories.includes(:entities)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.user = current_user

    if @category.save
      redirect_to categories_path, notice: 'Category created successfully.'
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
