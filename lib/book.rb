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
      id = book.fetch('id').to_i
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

  def self.find(id)
    book = DB.exec("SELECT * FROM books WHERE id = #{id};").first
    name = book.fetch("name")
    id = book.fetch("id").to_i
    Book.new({name: name, id: id})
  end

  def update(name)
    @name = name
    DB.exec("UPDATE books SET name = '#{@name}' WHERE ID = #{@id};")
  end

  def delete()
    DB.exec("DELETE FROM books WHERE id = #{@id};")
  end

  def self.search(name)
    name = name.downcase
    book_names = Book.all.map {|b| b.name.downcase}
    result = []
    names = book_names.grep(/#{name}/)
    names.each do |n|
      display_books = Book.all.select { |a| a.name.downcase == n }
      result.concat(display_books)
    end
    result
  end
  
  def self.sort()
    Book.all.sort_by {|book| book.name}
  end

end 