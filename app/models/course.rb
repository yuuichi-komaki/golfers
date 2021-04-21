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

 def avg_score_percentage
   unless self.posts.empty?
     posts.average(:rate).round(1).to_f*100/5
   else
     0.0
   end
 end 
end
