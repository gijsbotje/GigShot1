class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :images
  has_many :albums

  has_attached_file :avatar, styles: { medium: "300x300#", thumb: "100x100#", large: "500x500>" }, default_url: "/images/:style/missing.png"
    has_attached_file :banner, styles: {large: "500x500>" }, default_url: "/images/:style/missing.png"

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
end
