# frozen_string_literal: true

class Entity < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'author_id'
  belongs_to :group, class_name: 'Group', foreign_key: 'group_id'
  has_many :groups

  validates :name, presence: true
end
