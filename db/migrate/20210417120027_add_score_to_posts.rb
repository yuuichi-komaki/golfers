class AddScoreToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :rate, :float, default: 0
  end
end
