class RenameRecipesIngredients < ActiveRecord::Migration[5.1]
  def change
    rename_table :ingredients_recipes, :amounts
  end
end
