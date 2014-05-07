class AddPtypeToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :ptype, :string
  end
end
