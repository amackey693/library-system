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
    id = user.fetch("id").to_i
    Book.new({name: name, id: id})
  end

  def update(name)
    @name = name
    DB.exec("UPDATE albums SET name = '#{@name}' WHERE ID = #{@id};")
  end

end 