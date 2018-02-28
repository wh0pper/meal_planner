#!/usr/bin/env ruby
class Recipe < ActiveRecord::Base
  has_and_belongs_to_many(:tags)
  has_many :ingredients_recipes
  has_many :ingredients, through: :ingredients_recipes
end
