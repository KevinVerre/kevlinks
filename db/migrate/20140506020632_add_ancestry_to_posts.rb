class AddAncestryToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :ancestry, :string
    add_index :posts, :ancestry
  end
end
