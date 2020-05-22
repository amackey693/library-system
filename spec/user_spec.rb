require 'spec_helper'

describe '#User' do
  describe("#==")do
    it("is the same user if it has the same attributes as another user")do
      user1 = User.new({ name: "alMack", id: nil})
      user2 = User.new({ name: "alMack", id: nil})
      expect(user1).to(eq(user2))
    end
  end

  describe('.all') do
    it("returns and empty array if there are no users.") do
      expect(User.all).to(eq([]))
    end
  end

  describe('#save') do
    it('saves a user')do
      user1 = User.new({ name: "alMack", id: nil})
      user1.save
      user2 = User.new({ name: "Jhell", id: nil})
      user2.save
      expect(User.all).to(eq([user1, user2]))
    end
  end
  describe('.clear') do
    it('clears all users')do
      user1 = User.new({ name: "alMack", id: nil})
      user1.save
      user2 = User.new({ name: "Jhell", id: nil})
      user2.save
      user3 = User.new({ name: "jozyPants", id: nil})
      user3.save
      User.clear
     expect(User.all).to(eq([]))
   end
  end
  
  describe(".find") do 
    it("finds a user by id") do
      user1 = User.new({ name: "alMack", id: nil})
      user1.save
      user2 = User.new({ name: "Jhell", id: nil})
      user2.save
      user3 = User.new({ name: "jozyPants", id: nil})
      user3.save
      expect(User.find(user2.id)).to(eq(user2))
    end
  end

  describe('#update') do 
    it("updates a user by id") do 
      user3 = User.new({ name: "jozyPants", id: nil})
      user3.save
      user3.update("jPantz")
      expect(user3.name).to(eq("jPantz"))
    end
  end
  
  describe('#delete') do
    it('deletes a user by id')do
      user1 = User.new({ name: "alMack", id: nil})
      user1.save
      user2 = User.new({ name: "Jhell", id: nil})
      user2.save
      user3 = User.new({ name: "jozyPants", id: nil})
      user3.save
      user1.delete
      expect(User.all).to(eq([user2, user3]))
    end
  end
  describe('.search') do
    it('returns a list of users that match the search name')do
      user1 = User.new({name: "Allison", id: nil})
      user1.save
      user2 = User.new({name: "Josh", id: nil})
      user2.save
      expect(User.search("Josh")).to(eq([user2]))
    end
  end

  describe('.sort') do
      it('will sort all users alphabetically')do
        user3 = User.new({name: "Jozy", id: nil})
        user3.save
        user1 = User.new({ name: "Dracula", id: nil})
        user1.save
        user2 = User.new({ name: "Jhell", id: nil})
        user2.save
      expect(User.sort).to(eq([user1, user2, user3]))
    end
  end

  describe("#checkout")do
    it("allows a user to checkout a book")do  
      author = Author.new({name: "HP Lovecraft", id: nil})
      author.save
      book = Book.new({ name: "The Outsider", author_id: author.id, id: nil})
      book.save
      user3 = User.new({name: "Jozy", id: nil})
      user3.save
      user3.checkout(book)
      expect(book.is_available).to(eq(false))
    end
  end

  describe("#my_books")do
    it("allows a user to checkout a book")do  
      author = Author.new({name: "HP Lovecraft", id: nil})
      author.save
      book = Book.new({ name: "The Outsider", author_id: author.id, id: nil})
      book.save
      book1 = Book.new({ name: "TEST", author_id: author.id, id: nil})
      book1.save
      user3 = User.new({name: "Jozy", id: nil})
      user3.save 
      user3.checkout(book1)   
      expect(user3.my_books).to(eq(["TEST June/04/2020"]))
    end
  end

end
