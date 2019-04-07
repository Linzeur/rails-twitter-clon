class Tweet < ApplicationRecord
  belongs_to :user
  has_one :tweet
  has_many :tweets
  has_many :likes
  validates :content, presence: true
  attr_accessor :counts
end
