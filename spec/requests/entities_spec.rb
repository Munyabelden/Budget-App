# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EntitiesController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { User.create(name: 'John Doe', email: 'john@example.com', password: 'password') }
  let(:category) { Category.create(name: 'Category', user:) }
  let(:entity) { Entity.create(name: 'Entity', amount: 100, category:) }
  let(:entity1) { Entity.create(name: 'Entity 1', amount: 200, category:) }

  before { sign_in user }

  describe 'GET #index' do
    it 'assigns the requested category to @category' do
      get :index, params: { category_id: category.id }

      expect(assigns(:category)).to eq(category)
    end

    it 'assigns the total amount to @total_amount' do
      Entity.create(name: 'Entity 1', amount: 0)
      Entity.create(name: 'Entity 2', amount: 0)

      get :index, params: { category_id: category.id }

      expect(assigns(:total_amount)).to eq(0)
    end

    it 'renders the index template' do
      get :index, params: { category_id: category.id }

      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    it 'assigns a new entity to @entity' do
      get :new, params: { category_id: category.id }

      expect(assigns(:entity)).to be_a_new(Entity)
    end

    it 'renders the new template' do
      get :new, params: { category_id: category.id }

      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new entity' do
        expect do
          post :create, params: { category_id: category.id, entity: { name: 'New Entity', amount: 100 } }
        end.to change(Entity, :count).by(1)
      end

      it 'assigns the newly created entity to @entity' do
        post :create, params: { category_id: category.id, entity: { name: 'New Entity', amount: 100 } }

        expect(assigns(:entity)).to be_a(Entity)
        expect(assigns(:entity)).to be_persisted
      end

      it 'redirects to the entities index page' do
        post :create, params: { category_id: category.id, entity: { name: 'New Entity', amount: 100 } }

        expect(response).to redirect_to(category_entities_path(category))
      end

      it 'sets a flash notice' do
        post :create, params: { category_id: category.id, entity: { name: 'New Entity', amount: 100 } }

        expect(flash[:notice]).to eq('Entity created successfully.')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new entity' do
        expect do
          post :create, params: { category_id: category.id, entity: { name: '', amount: 100 } }
        end.not_to change(Entity, :count)
      end

      it 'assigns a new unsaved entity to @entity' do
        post :create, params: { category_id: category.id, entity: { name: '', amount: 100 } }

        expect(assigns(:entity)).to be_a_new(Entity)
        expect(assigns(:entity)).not_to be_persisted
      end

      it 'renders the new template' do
        post :create, params: { category_id: category.id, entity: { name: '', amount: 100 } }

        expect(response).to render_template(:new)
      end
    end
  end
end
