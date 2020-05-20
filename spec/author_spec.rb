require 'spec_helper'

describe '#Author' do
  describe("#==")do
    it("is the same author if it has the same attributes as another author")do
      author = Author.new({ name: "Anne Rice", id: nil})
      author1 = Author.new({ name: "Anne Rice", id: nil})
      expect(author).to(eq(author1))
    end
  end

  describe('.all') do
    it("returns and empty array if there are no authors.") do
      expect(Author.all).to(eq([]))
    end
  end

  describe('#save') do
    it('saves a author')do
      author1 = Author.new({ name: "Stephen King", id: nil})
      author1.save
      author2 = Author.new({ name: "Anne Rice", id: nil})
      author2.save
      expect(Author.all).to(eq([author1, author2]))
    end
  end
  describe('.clear') do
    it('clears all authors')do
      author1 = Author.new({ name: "Stephen King", id: nil})
      author1.save
      author2 = Author.new({ name: "Anne Rice", id: nil})
      author2.save
      Author.clear
     expect(Author.all).to(eq([]))
   end
  end
  describe(".find") do 
    it("finds a author by id") do
      author = Author.new({name: "HP Lovecraft", id: nil})
      author.save
      author2 = Author.new({name: "Cormac MCCarthy", id: nil})
      author2.save
      expect(Author.find(author.id)).to(eq(author))
    end
  end

  describe('#update') do 
    it("updates a author by id") do 
      author = Author.new({name: 'Cormac McCarthy', id: nil})
      author.save
      author.update("It")
      expect(author.name).to(eq("It"))
    end
  end
  
  describe('#delete') do
    it('deletes a author by id')do
      author = Author.new({name: "HP Lovecraft", id: nil})
      author.save
      author2 = Author.new({name: "Cormac McCarthy", id: nil})
      author2.save
      author.delete
      expect(Author.all).to(eq([author2]))
    end
  end
  
  describe('.search') do
    it('returns a list of authors that match the search name')do
      author = Author.new({name: "HP Lovecraft", id: nil})
      author.save
      author2 = Author.new({name: "Edgar Allen Poe", id: nil})
      author2.save
      expect(Author.search("P")).to(eq([author, author2]))
    end
  end

  describe('.sort') do
      it('will sort all authors alphabetically')do
        author = Author.new({name: "Clive Barker", id: nil})
        author.save
        author1 = Author.new({ name: "Mary Shelley", id: nil})
        author1.save
        author2 = Author.new({name: "Christopher Paloni", id: nil})
        author2.save
      expect(Author.sort).to(eq([author2, author, author1]))
    end
  end
end




#   describe('') do
#     it('')do
#     expect().to(eq())
#   end
# end

