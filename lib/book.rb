require 'pry'

class Book 
  attr_accessor :name, :id

  def initialize(attributes) 
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def ==(book_to_compare)
    self.name == book_to_compare.name
  end

  def self.all
    # returned_books =
  end
end 