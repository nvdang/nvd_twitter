class Tweet < ActiveRecord::Base
  belongs_to :user
  validates_associated :user
  has_many :comments
end
