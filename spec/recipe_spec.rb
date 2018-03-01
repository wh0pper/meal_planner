require 'spec_helper'

describe('Recipe') do
  it("recipe creation") do
    recipe = Recipe.create({:recipe => "Pasta", :instructions => "Boil"})
    expect(Recipe.all).to(eq([recipe]))
  end

  it("recipe ingredient relationship") do
    recipe = Recipe.create({:recipe => "Pasta", :instructions => "Boil"})
    ingredient = Ingredient.create({:ingredient => "noodles"})
    recipe.ingredients.push(ingredient)
    expect(recipe.ingredients.first).to(eq(ingredient))
  end

  it("recipe tag relationship") do
    recipe = Recipe.create({:recipe => "Pasta", :instructions => "Boil"})
    tag = Tag.create({:tag => "starchy"})
    recipe.tags.push(tag)
    expect(recipe.tags).to(eq([tag]))
  end

  it("finds a recipe by an ingredient") do
  recipe = Recipe.create({:recipe => "Pasta", :instructions => "Boil"})
  ingredient = Ingredient.create({:ingredient => "noodles"})
  recipe.ingredients.push(ingredient)
  expect(ingredient.recipes.first).to(eq(recipe))
  end

  it("determines if a recipe already exists in the recipe") do
    recipe = Recipe.create({:recipe => "Pasta", :instructions => "Boil"})
    ingredient = Ingredient.create({:ingredient => "noodles"})
    recipe.ingredients.push(ingredient)
    ingredient2 = Ingredient.new({:ingredient => "noodles"})
    expect(ingredient2.save).to(eq(false))
  end

  it("if ingredient already exists in the database, but not in the recipe, pull the ingredient and add to recipe") do
    ingredient = Ingredient.create({:ingredient => "noodles"})
    recipe = Recipe.create({:recipe => "Pasta", :instructions => "Boil"})

    recipe.ingredients.push(ingredient)
    ingredient2 = Ingredient.new({:ingredient => "noodles"})
    expect(ingredient2.save).to(eq(false))
  end
end


describe(Recipe) do
  it { should have_many(:ingredients) }
end

describe(Recipe) do
  it { should validate_presence_of(:recipe) }
end
