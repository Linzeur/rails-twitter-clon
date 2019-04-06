class User < ApplicationRecord
  has_many :tweets
  has_many :followers, class_name: 'Follow', :foreign_key => 'follower_id'
  has_many :follows, class_name: 'Follow', :foreign_key => 'followed_id'
  validates :name, :description, presence: true
  attr_accessor :counts
end
