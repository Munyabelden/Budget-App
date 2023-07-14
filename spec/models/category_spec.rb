# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:user) { User.create(name: 'John Doe', email: 'john@example.com', password: 'password') }

  it 'is valid with valid attributes' do
    category = Category.new(name: 'Example Category')
    category.user = user
    expect(category).to be_valid
  end

  it 'is not valid without a name' do
    category = Category.new
    category.user = user
    expect(category).not_to be_valid
  end

  it 'belongs to a user' do
    category = Category.new(name: 'Example Category')
    category.user = user
    expect(category.user).to eq(user)
  end

  it 'has and belongs to many entities' do
    category = Category.new(name: 'Example Category')
    category.user = user
    expect(category.entities).to be_empty
  end
end
