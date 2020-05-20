require 'pry'

require 'pry'

class User
  attr_accessor :name, :id

  def initialize(attributes) 
    @name = attributes.fetch(:name)
    @is_admin = false
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
      id = user.fetch('id')
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
    id = user.fetch('id')
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
    book_names = Book.all.map {|b| b.name}
    result = []
    names = book_names.grep(/#{name}/)
    names.each do |n|
      display_books = Book.all.select { |a| a.name == n }
      result.concat(display_books)
    end
    result
  end

  def self.sort
    Book.all.sort_by { |names| names.name }
  end
end 