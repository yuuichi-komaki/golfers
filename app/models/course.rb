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
 
end
