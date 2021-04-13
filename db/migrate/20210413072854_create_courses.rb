class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :name
      t.integer :postcode
      t.integer :prefecture_code
      t.string :address_city
      t.string :address_street
      
      t.timestamps
    end
  end
end
