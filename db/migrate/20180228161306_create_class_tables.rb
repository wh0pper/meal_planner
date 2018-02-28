class CreateClassTables < ActiveRecord::Migration[5.1]
  def change
    create_table(:recipes) do |t|
      t.column(:recipe, :string)
      t.column(:instructions, :string)
      t.column(:nutrition, :string)
      t.column(:time, :string)
      t.column(:servings, :integer)
      t.column(:rating, :integer)
    end

    create_table(:ingredients) do |t|
      t.column(:ingredient, :string)
      t.column(:calories, :integer)
      t.column(:fat, :integer)
      t.column(:protein, :integer)
      t.column(:carbs, :integer)
    end

    create_table(:ingredients_recipes) do |t|
      t.column(:ingredient_id, :integer)
      t.column(:recipe, :integer)
      t.column(:amount, :string)
      t.column(:converted, :string)
    end

    create_table(:recipes_tags) do |t|
      t.column(:tag_id, :integer)
      t.column(:recipe_id, :integer)
    end

    create_table(:tags) do |t|
      t.column(:tag, :string)
    end
  end
end
