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
    returned_books = DB.exec("SELECT * FROM books;")
    books = []
    returned_books.each do |book|
      name = book.fetch("name")
      id = book.fetch('id')
      books.push(Book.new({name: name, id: id}))
    end
    books
  end

  def save
    result = DB.exec("INSERT INTO books (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  def self.clear
    DB.exec("DELETE FROM books *;")
  end

end 