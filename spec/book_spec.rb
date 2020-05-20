require 'spec_helper'

describe '#Book' do
  describe("#==")do
    it("is the same book if it has the same attributes as another book")do
      book = Book.new({ name: "Call of the Wild", id: nil})
      book1 = Book.new({ name: "Call of the Wild", id: nil})
      expect(book).to(eq(book1))
    end
  end

  describe('.all') do
    it("returns and empty array if  there are no books.") do
      expect(Book.all).to(eq([]))
    end
  end

  describe('#save') do
    it('saves a book')do
      book1 = Book.new({ name: "Dracula", id: nil})
      book1.save
      book2 = Book.new({ name: "Call of the Wild", id: nil})
      book2.save
      expect(Book.all).to(eq([book1, book2]))
    end
  end
  describe('.clear') do
    it('clears all books')do
      book1 = Book.new({ name: "Dracula", id: nil})
      book1.save
      book2 = Book.new({ name: "Call of the Wild", id: nil})
      book2.save
      Book.clear
     expect(Book.all).to(eq([]))
   end
  end
  describe(".find") do 
    it("finds a book by id") do
      book = Book.new({name: "where the sidewalk ends", id: nil})
      book.save
      book2 = Book.new({name: "It", id: nil})
      book.save
      expect(Book.find(book.id)).to(eq(book))
    end
  end

  describe('#update') do 
    it("updates a book by id") do 
      book = Book.new({name: 'The Shinning', id: nil})
      book.save
      book.update("It")
      expect(book.name).to(eq("It"))
    end
  end
end

  describe('#delete') do
    it('deletes a book by id')do
      book = Book.new({name: "where the sidewalk ends", id: nil})
      book.save
      book2 = Book.new({name: "It", id: nil})
      book.save
      book.delete
    expect(Book.all).to(eq([book2]))
  end
end

#   describe('') do
#     it('')do
#     expect().to(eq())
#   end
# end

#   describe('') do
#     it('')do
#     expect().to(eq())
#   end
# end

