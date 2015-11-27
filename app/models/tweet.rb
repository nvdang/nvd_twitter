class Tweet < ActiveRecord::Base
  attr_accessor :picture_file_name
  belongs_to :user
  validates_associated :user
  has_many :comments
  mount_uploader :picture, PictureUploader
  validates :text, presence: true, length: {maximum: 140}
  
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
          user_id: user.id)
  end
  
end
