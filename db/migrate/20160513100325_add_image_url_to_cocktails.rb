class AddImageUrlToCocktails < ActiveRecord::Migration
  def change
    add_column :cocktails, :image_url, :string
  end
end
