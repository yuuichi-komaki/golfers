class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :profile_image
  validates :name, presence: true
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
    user.password = SecureRandom.urlsafe_base64
    user.name = "ゲストユーザー"
    end
  end
end
