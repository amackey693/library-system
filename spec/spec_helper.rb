require 'rspec'
require 'pg'
require 'book'
require 'user'
require 'author'
require 'pry'

DB = PG.connect({:dbname => 'library_system_test'}) 
RSpec.configure do |config|
  config.after(:each) do  
    DB.exec("DELETE FROM users *;")
    DB.exec("DELETE FROM books *;")
    DB.exec("DELETE FROM checkouts *;")
    DB.exec("DELETE FROM authors *;")
  end
end