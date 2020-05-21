require 'spec_helper'

describe '#Book' do
  before (:each) do
    Book.clear
    @author = Author.new({name: "HP Lovecraft", id: nil})
    @author.save

    @book = Book.new({ name: "Call of the Wild", author_id: @author.id, id: nil})
    @book.save

    @book1 = Book.new({ name: "Call of the Wild", author_id: @author.id,id: nil})
    @book1.save
    
    @book2 = Book.new({ name: "Dracula", author_id: @author.id, id: nil})
    @book2.save
  end

  describe("#==")do
    it("is the same book if it has the same attributes as another book")do
      expect(@book).to(eq(@book1))
    end
  end

  describe('.all') do
    it("returns and empty array if  there are no books.") do
      Book.clear
      expect(Book.all).to(eq([]))
    end
  end

  describe('#save') do
    it('saves a book')do
      expect(Book.all).to(eq([@book, @book1,@book2]))
    end
  end
  describe('.clear') do
    it('clears all books')do
      Book.clear
     expect(Book.all).to(eq([]))
   end
  end
  describe(".find") do 
    it("finds a book by id") do
      expect(Book.find(@book.id)).to(eq(@book))
    end
  end

  describe('#update') do 
    it("updates a book by id") do 
      book = Book.new({name: 'The Shinning', id: nil, author_id: @author.id})
      book.save
      book.update("It")
      expect(book.name).to(eq("It"))
    end
  end
  
  describe('#delete') do
    it('deletes a book by id')do
      @book.delete
      expect(Book.all).to(eq([@book1, @book2]))
    end
  end

  describe('.search') do
    it('returns a list of books that match the search name')do
      expect(Book.search("Dracula")).to(eq([@book2]))
    end
  end

  describe('.sort') do
      it('will sort all books alphabetically')do
      expect(Book.sort).to(eq([ @book, @book1, @book2]))
    end
  end

  describe('#author') do
    it('find an Author by id')do
    expect(@book.author).to(eq(@author))
    end
  end

  describe(".find_by_author")do
    it("finds books by a specific author")do
      expect(Book.find_by_author(@author.id)).to(eq([@book, @book1, @book2]))
    end
  end

  describe("#is_available") do
    it("marks a book as checked out") do 
      expect(@book.is_available).to(eq("t"))
    end
  end

end




#   describe('') do
#     it('')do
#     expect().to(eq())
#   end
# end

