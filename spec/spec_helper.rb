require 'rspec'
require 'pg'
require 'book'
require 'author'
require 'pry'

DB = PG.connect({:dbname => ' '}) 
RSpec.configure do |config|
  config.after(:each) do  
    # DB.exec("DELETE FROM albums *;")
    # DB.exec("DELETE FROM songs *;")
    # DB.exec("DELETE FROM artists *;")
    # DB.exec("DELETE FROM album_artists *;")
  end
end