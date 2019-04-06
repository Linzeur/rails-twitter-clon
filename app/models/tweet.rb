class Tweet < ApplicationRecord
  belongs_to :user
  has_one :tweet
  has_many :likes # metodos para  desde un tweett accesar los elementos del like.
end
