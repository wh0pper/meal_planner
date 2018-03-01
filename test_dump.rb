
if new_ingredient.save
  @recipe.ingredients.push(new_ingredient)
elsif !ingredients.include?(new_ingredient)
  binding.pry
  new_ingredient = Ingredient.find_by({:ingredient => params['ingredient']})
  @recipe.ingredients.push(new_ingredient)
else
  @ingredient_error = "Ingredient already in recipe"
end
