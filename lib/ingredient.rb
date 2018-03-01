#!/usr/bin/env ruby
class Ingredient < ActiveRecord::Base
  validates(:ingredient, presence: true)
  validates :ingredient, uniqueness: true
  has_many :amounts
  has_many :recipes, through: :amounts
end
