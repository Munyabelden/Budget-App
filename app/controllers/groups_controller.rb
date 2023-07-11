# frozen_string_literal: true

class GoupsController < ApplicationController
  def index
    @user = current_user
    @category = Group.includes(@user.id).find - by(name).order(created_at.desc)
  end
end
