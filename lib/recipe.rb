#!/usr/bin/env ruby
class Recipe < ActiveRecord::Base
  validates(:recipe, {:presence => true})
  validates_uniqueness_of :ingredient
  has_and_belongs_to_many(:tags)
  has_many :amounts
  has_many :ingredients, through: :amounts
end
