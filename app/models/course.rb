class Course < ApplicationRecord
  include JpPrefecture
  jp_prefecture :prefecture_code

 def prefecture_name
  JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
 end

 def prefecture_name=(prefecture_name)
  self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
 end

 def address
   [self.prefecture_name,self.address_city,self.address_street].compact.join()
 end

 geocoded_by :address
 after_validation :geocode

 has_many :posts, dependent: :destroy

  def avg_score
    unless self.posts.empty?
      posts.average(:rate).round(1)
    else
      0.0
    end
  end
validates :name, presence: true, uniqueness: { scope: :postcode, message: "このコース名は既に登録されている可能性があります" }
validates :postcode, presence: true, format: {with: /\A\d{7}\z/, message: "半角数字７桁・ハイフンなしで入力お願いします" }
validates :prefecture_code, presence: true
validates :address_city, presence: true
validates :address_street, presence: true
end
