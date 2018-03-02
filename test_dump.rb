
if new_ingredient.save
  @recipe.ingredients.push(new_ingredient)
elsif !ingredients.include?(new_ingredient)
  binding.pry
  new_ingredient = Ingredient.find_by({:ingredient => params['ingredient']})
  @recipe.ingredients.push(new_ingredient)
else
  @ingredient_error = "Ingredient already in recipe"
end


http://platform.fatsecret.com/rest/server.api?food_id=cheese&method=food.get&oauth_consumer_key=0ca42aaaf0fd44ff92d6767aa20d214f&oauth_nonce=1234&oauth_signature=sAyYTJiIxOGkvFpBcH8L%2BlFQRCQ%3D&oauth_signature_method=HMAC-SHA1&oauth_timestamp=1245126631&oauth_version=1.0
