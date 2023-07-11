# frozen_string_literal: true

class Group < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'author_id'
  belongs_to :entities, class_name: 'Entity', foreign_key: 'entity_id'
  has_many :entities

  validates :name, presence: true
end
