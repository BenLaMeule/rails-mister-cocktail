class AddNoteToCocktails < ActiveRecord::Migration
  def change
    add_column :cocktails, :note, :string
  end
end
