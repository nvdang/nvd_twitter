class Profile < ActiveRecord::Base
  belongs_to :user
  validates_associated :user
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/default.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  #validates :sex, inclusion: %w(male female)
  validates :tel, presence: true, numericality: true, length: {minimum: 10, maximum: 15}
  validates :address, presence: true
end
