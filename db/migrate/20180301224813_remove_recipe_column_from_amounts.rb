class RemoveRecipeColumnFromAmounts < ActiveRecord::Migration[5.1]
  def change
    remove_column(:amounts, :recipe, :integer)
  end
end
