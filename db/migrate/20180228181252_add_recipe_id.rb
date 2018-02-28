class AddRecipeId < ActiveRecord::Migration[5.1]
  def change
    add_column(:ingredients_recipes, :recipe_id, :integer)
  end
end
