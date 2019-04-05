class User < ApplicationRecord
  has_many :tweets
  has_many :follows
  validates :name, :description, presence: true
end
