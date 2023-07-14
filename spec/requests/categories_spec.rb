# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { User.create(name: 'John Doe', email: 'john@example.com', password: 'password') }

  describe 'GET #index' do
    it 'renders the index template' do
      sign_in user
      get :index

      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    before { sign_in(user) }

    it 'assigns a new category to @category' do
      get :new

      expect(assigns(:category)).to be_a_new(Category)
    end

    it 'renders the new template' do
      get :new

      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    before { sign_in(user) }

    context 'with valid parameters' do
      it 'creates a new category' do
        expect do
          post :create, params: { category: { name: 'New Category' } }
        end.to change(Category, :count).by(1)
      end

      it 'assigns the newly created category to @category' do
        post :create, params: { category: { name: 'New Category' } }

        expect(assigns(:category)).to be_a(Category)
        expect(assigns(:category)).to be_persisted
      end

      it 'redirects to the categories index page' do
        post :create, params: { category: { name: 'New Category' } }

        expect(response).to redirect_to(categories_path)
      end

      it 'sets a flash notice' do
        post :create, params: { category: { name: 'New Category' } }

        expect(flash[:notice]).to eq('Category created successfully.')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new category' do
        expect do
          post :create, params: { category: { name: '' } }
        end.not_to change(Category, :count)
      end

      it 'assigns a new unsaved category to @category' do
        post :create, params: { category: { name: '' } }

        expect(assigns(:category)).to be_a_new(Category)
        expect(assigns(:category)).not_to be_persisted
      end

      it 'renders the new template' do
        post :create, params: { category: { name: '' } }

        expect(response).to render_template(:new)
      end
    end
  end
end
