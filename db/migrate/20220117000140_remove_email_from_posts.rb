class RemoveEmailFromPosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :email, :string
  end
end
