#!/usr/bin/env ruby
class Ingredient < ActiveRecord::Base
  validates(:ingredient, presence: true)
  validates_uniqueness_of :ingredient
  has_many :amounts
  has_many :recipes, through: :amounts
end
