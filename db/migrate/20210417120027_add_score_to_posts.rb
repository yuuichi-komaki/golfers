class AddScoreToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :score, :float
  end
end
