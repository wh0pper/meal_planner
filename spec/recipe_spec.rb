require 'spec_helper'

describe('Recipe') do
  it("recipe creation") do
    recipe = Recipe.create({:recipe => "Pasta", :instructions => "Boil"})
    expect(Recipe.all).to(eq([recipe]))
  end

  it("recipe ingredient relationship") do
    recipe = Recipe.create({:recipe => "Pasta", :instructions => "Boil"})
    ingredient = Ingredient.create({:ingredient => "noodles"})
    recipe.ingredients_recipes.push(ingredient)
    expect(recipe.ingredients_recipes).to(eq([ingredient]))
  end

  it("recipe tag relationship") do
    recipe = Recipe.create({:recipe => "Pasta", :instructions => "Boil"})
    tag = Tag.create({:tag => "starchy"})
    recipe.tags.push(tag)
    expect(recipe.tags).to(eq([tag]))
  end
end
