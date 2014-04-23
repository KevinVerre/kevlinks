class CreateFolders < ActiveRecord::Migration
  def change
    create_table :folders do |t|
      t.references :post, index: true

      t.timestamps
    end
  end
end
