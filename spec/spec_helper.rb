ENV['RACK_ENV'] = 'test'
require 'rspec' 
require 'pry'
require 'pg'
require 'Recipie'

RSpec.configure do |config|
  config.after(:each) do
    Recipie.all().each() do |recipie|
      recipie.destroy()
    end
  end
end
