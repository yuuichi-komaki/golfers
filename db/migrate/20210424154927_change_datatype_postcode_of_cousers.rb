class ChangeDatatypePostcodeOfCousers < ActiveRecord::Migration[5.2]
  def change
    change_column :courses, :postcode, :string
  end
end
