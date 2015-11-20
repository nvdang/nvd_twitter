class Profile < ActiveRecord::Base
  belongs_to :user
  validates_associated :user
  has_attached_file :avatar
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  validates :tel, presence: true, numericality: true, length: {minimum: 10, maximum: 15}
  validates :address, presence: true
end
