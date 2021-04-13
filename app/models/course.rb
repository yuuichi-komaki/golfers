class Course < ApplicationRecord
  include JpPrefecture
  jp_prefecture :prefecture_code

 def prefecture_name
  JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
 end

 def prefecture_name=(prefecture_name)
  self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
 end
 
 has_many :posts, dependent: :destroy
 
end
