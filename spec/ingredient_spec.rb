require 'spec_helper'

describe(Ingredient) do
  it { should validate_uniqueness_of(:ingredient) }
end
