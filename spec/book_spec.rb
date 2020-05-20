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
      expect(Book.all)to.(eq([]))
    end
  end

end