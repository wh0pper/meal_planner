require("bundler/setup")
require("pry")
# require 'fatsecret-api'

Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }



get('/') do
  @recipes = Recipe.all
  @tags = Tag.all
  @ingredients = Ingredient.all
  # food = FatSecret.search('milk')
  # results = FatSecret.food(800)
  erb:index
end

post('/') do
  new_recipe = Recipe.create({:recipe => params['recipe'], :instructions => ""})
  @recipes = Recipe.all
  @ingredients = Ingredient.all
  erb:index
end

get('/recipe/:id') do
  @recipe = Recipe.find(params['id'].to_i)
  @ingredients = @recipe.ingredients
  @tags = @recipe.tags
  instructions = @recipe.instructions
  @instructions_arr = instructions.split(",")
  @rating = @recipe.rating
  @rating_display = @rating.to_s + " stars"
  @all_tags = Tag.all
  erb:recipe
end


post('/recipe/:id/new_ingredient') do
  @recipe = Recipe.find(params['id'].to_i)
  existing_ingredients = @recipe.ingredients
  new_ingredient = Ingredient.new({:ingredient => params['ingredient']})
  unless new_ingredient.save
    new_ingredient = Ingredient.find_by({:ingredient => params['ingredient']})
  end
  if !existing_ingredients.include?(new_ingredient)
    @recipe.ingredients.push(new_ingredient)
    amount = Amount.find_by({:ingredient_id => new_ingredient.id})
    amount.update({:amount => '0'})
  else
    @ingredient_error = "Ingredient already in recipe"
  end
  instructions = @recipe.instructions
  @instructions_arr = instructions.split(",")
  @tags = @recipe.tags
  @ingredients = @recipe.ingredients
  @all_tags = Tag.all
  erb:recipe
end

post('/recipe/:id/new_instruction') do
  @recipe = Recipe.find(params['id'].to_i)
  instructions = @recipe.instructions
  @tags = @recipe.tags
  @ingredients = @recipe.ingredients
  new_instruction = params['instruction']
  instructions += new_instruction + ","
  @recipe.update({:instructions => instructions})
  @instructions_arr = instructions.split(",")
  @all_tags = Tag.all
  erb:recipe
end


post('/recipe/:id/add_tag') do
  @recipe = Recipe.find(params['id'].to_i)
  if !params['tag'].empty?
    new_tag = Tag.create({:tag => params['tag']})
  elsif params['tags']
    new_tag = Tag.find(params['tags'])
  end
  @recipe.tags.push(new_tag)
  @tags = @recipe.tags
  @ingredients = @recipe.ingredients
  instructions = @recipe.instructions
  @instructions_arr = instructions.split(",")
  @all_tags = Tag.all
  erb:recipe
end

delete('/recipe/:id/delete_ingredient') do
  @recipe = Recipe.find(params['id'].to_i)
  ingredient_delete = Ingredient.find(params['ingredient_to_delete'].to_i)
  ingredient_delete.destroy
  @ingredients = @recipe.ingredients
  instructions = @recipe.instructions
  @instructions_arr = instructions.split(",")
  @all_tags = Tag.all
  erb:recipe
end

delete('/recipe/:id/delete_instruction') do
  index_delete = params['instruction_to_delete']
  @recipe = Recipe.find(params[:id].to_i)
  instructions = @recipe.instructions
  @instructions_arr = instructions.split(",")
  @instructions_arr.delete_at(index_delete.to_i)
  new_instructions = @instructions_arr.join(',')
  @recipe.update({:instructions => new_instructions})
  @ingredients = @recipe.ingredients
  @all_tags = Tag.all
  erb:recipe
end

delete('/delete_recipe') do
  recipe_delete = Recipe.find(params['recipe_to_delete'].to_i)
  ingredients_delete =recipe_delete.ingredients
  ingredients_delete.each  do |ingredient|
    ingredient.destroy
  end
  recipe_delete.amounts.destroy_all
  recipe_delete.destroy
  @recipes = Recipe.all
  @tags = Tag.all
  @ingredients = Ingredient.all
  erb:index
end

get('/tag/:id') do
  @tag = Tag.find(params['id'].to_i)
  @recipes = @tag.recipes
  erb:search
end

post('/recipe_finder') do
  @ingredient = Ingredient.find(params['ingredient'].to_i)
  @recipes = @ingredient.recipes
  erb:search
end

get('/nutrition/:id') do
  @recipe = Recipe.find(params['id'].to_i)
  @amounts = @recipe.amounts
  @ingredients = @recipe.ingredients
  erb:nutrition
end

post('/recipe/:id/update_amount') do
  new_amount = params['amount']
  @recipe = Recipe.find(params['id'].to_i)
  ingredient = Ingredient.find(params['ingredient_to_update'].to_i)
  @recipe.amounts.where({:ingredient_id => ingredient.id, :recipe_id => @recipe.id}).update({:amount => new_amount})

  @tags = @recipe.tags
  instructions = @recipe.instructions
  @instructions_arr = instructions.split(",")
  @amounts = @recipe.amounts
  @all_tags = Tag.all
  erb:recipe
end

post('/recipe/:id/rating') do
  @recipe = Recipe.find(params['id'].to_i)
  @recipe.update({:rating => params['rating'].to_i})
  if @recipe.rating
    @rating = @recipe.rating
    @rating_display = @rating.to_s + " stars"
  else
    @rating_display = "not yet rated"
  end
  @ingredients = @recipe.ingredients
  @tags = @recipe.tags
  instructions = @recipe.instructions
  @instructions_arr = instructions.split(",")
  @all_tags = Tag.all
  erb:recipe
end
