require("bundler/setup")
require("pry")
Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
  @recipes = Recipe.all
  @tags = Tag.all
  @ingredients = Ingredient.all
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
  erb:recipe
end


post('/recipe/:id/new_ingredient') do
  @recipe = Recipe.find(params['id'].to_i)
  new_ingredient = Ingredient.new({:ingredient => params['ingredient']})
  if new_ingredient.save
    @recipe.ingredients.push(new_ingredient)
  else
    @ingredient_error = "Ingredient already exists"  
  end
  instructions = @recipe.instructions
  @instructions_arr = instructions.split(",")
  @tags = @recipe.tags
  @ingredients = @recipe.ingredients
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
  erb:recipe
end


post('/recipe/:id/add_tag') do
  @recipe = Recipe.find(params['id'].to_i)
  new_tag = Tag.create({:tag => params['tag']})
  @recipe.tags.push(new_tag)
  @tags = @recipe.tags
  @ingredients = @recipe.ingredients
  instructions = @recipe.instructions
  @instructions_arr = instructions.split(",")
  erb:recipe
end

delete('/recipe/:id/delete_ingredient') do
  @recipe = Recipe.find(params['id'].to_i)
  ingredient_delete = Ingredient.find(params['ingredient_to_delete'].to_i)
  ingredient_delete.destroy
  @ingredients = @recipe.ingredients
  instructions = @recipe.instructions
  @instructions_arr = instructions.split(",")
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
  erb:recipe
end

delete('/delete_recipe') do
  recipe_delete = Recipe.find(params['recipe_to_delete'].to_i)
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
