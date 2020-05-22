require 'pry'
require 'Date'

class User
  attr_accessor :name, :id, :is_admin

  def initialize(attributes) 
    @name = attributes.fetch(:name)
    @is_admin = attributes.fetch(:is_admin, false)
    @id = attributes.fetch(:id)
  end

  def ==(user_to_compare)
    self.name == user_to_compare.name
  end

  def self.all
    returned_users = DB.exec("SELECT * FROM users;")
    users = []
    returned_users.each do |user|
      name = user.fetch("name")
      is_admin = user.fetch("is_admin")
      id = user.fetch('id').to_i
      users.push(User.new({name: name, is_admin: is_admin, id: id}))
    end
    users
  end

  def save
    result = DB.exec("INSERT INTO users (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  def self.clear
    DB.exec("DELETE FROM users *;")
  end

  def self.find(id)
    user = DB.exec("SELECT * FROM users WHERE id = #{id};").first
    name = user.fetch("name")
    is_admin = user.fetch("is_admin")
    id = user.fetch('id').to_i
    User.new({name: name, is_admin: is_admin, id: id})
  end

  def update(name)
    @name = name
    DB.exec("UPDATE users SET name = '#{@name}' WHERE ID = #{@id};")
  end

  ##only allow to delete if user.is_admin == true, set up in the app.rb? or implement in delete method?
  def delete
    DB.exec("DELETE FROM users WHERE id = #{@id};")
    # DB.exec("DELETE FROM checkouts WHERE user_id = #{@id};") --> delete books from users checkout history, but does not delete the books from the database??
  end

  ## admin function 
  def self.search(name)
    name = name.downcase
    user_names = User.all.map {|u| u.name.downcase}
    result = []
    names = user_names.grep(/#{name}/)
    names.each do |n|
      display_users = User.all.select { |a| a.name.downcase == n }
      result.concat(display_users)
    end
    result
  end

  def self.sort
    User.all.sort_by { |user| user.name.downcase }
  end

  def checkout(book)
    book.check_out
    # binding.pry
    date = Date.today
    due_date = (Date.today + 14).strftime("%B/%d/%Y")
    DB.exec("INSERT INTO checkouts (book_id, user_id, checkout_date, due_date) VALUES (#{book.id}, #{@id}, '#{date}', '#{due_date}') RETURNING id;")
    # @transaction = result.first.fetch("id").to_i
  end

  def my_books()
    books_out = DB.exec("SELECT * FROM checkouts WHERE user_id = #{@id};")
    booklist = []
    books_out.each do |b|
      # binding.pry
      book = b.fetch("book_id").to_i
      due_date = b.fetch("due_date")
      book_title = (Book.find(book)).name
      results = (book_title + " " + due_date)
      booklist.push(results)
    end
    booklist
  end

  # checked_books.push(due_date)
  # due_date = Date.today + 14 
  # date = Date.today
  
  # def my_books
  #   my_books = []
    
  #   books = DB.exec("SELECT * FROM checkouts WHERE user_id = ")
  #   books.each() do |book|

  #   end
  
end 

# should we be returning/saving something when we run the checkout method?
# can we create a "timestamp" & an array of books "checked out" within the checkout method? 

# timestamp "update" attributes in the checkout method could we create that attribute in "book" under our check_out method? ==> Time.new() 
# checkin method reverse of checkout --> DELETE checkouts id WHERE id = #{id};