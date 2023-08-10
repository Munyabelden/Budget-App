class EntitiesController < ApplicationController
  before_action :authenticate_user!

  def index
    @category = Category.find(params[:category_id])
    @entities = @category.entities.order(created_at: :desc)
    @total_amount = @category.entities.sum(:amount)
  end

  def show
    @entity = Entity.find(params[:id])
  end

  def new
    @category = Category.find(params[:category_id])
    @entity = @category.entities.new
  end

  def create
    @category = Category.find(params[:category_id])
    @entity = @category.entities.new(entity_params)
    @entity.user = current_user

    @entity.categories = Category.where(id: params[:entity][:category_ids])

    if @entity.save
      redirect_to category_entities_path(@category), notice: 'Entity created successfully.'
    else
      render :new
    end
  end

  private

  def entity_params
    params.require(:entity).permit(:name, :amount, category_ids: [])
  end
end
