class Post < ApplicationRecord
  belongs_to :user
  belongs_to :course
  has_many :post_images, dependent: :destroy
  accepts_attachments_for :post_images, attachment: :image
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  validates :title, presence: true
  validates :body, presence: true
end
