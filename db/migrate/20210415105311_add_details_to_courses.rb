class AddDetailsToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :latitude, :float
    add_column :courses, :longitude, :float
  end
end
