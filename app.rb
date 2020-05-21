require('sinatra')
require('sinatra/reloader')
require('./lib/user')
require('./lib/book')
require('./lib/author')
require('pry')
require("pg")
DB = PG.connect({:dbname => "library_system"})
also_reload('lib/**/*.rb')


# EXAMPLES FOR GET, POST, PATCH & DELETE
get('/') do
  @authors = Author.sort
  @books = Book.sort
  erb(:library) #erb file name
end

get('/library')do
  @books = Book.sort
  # @authors = Authors.sort
  erb(:library)
end

post('/library') do ## Adds , cannot access in URL bar
  name = params[:author_name]
  author = Author.new({name: name, id: nil}) 
  author.save
  title = params[:book_name]
  book = Book.new({name: title, id: nil, author_id: author.id})
  book.save()
  redirect to('/library')
end

patch('/authors/:id') do
  @author = Author.find(params[:id].to_i())
  @authors = Author.all
  if params[:buy]
    @author.sold()
  else  
    @author.update(params[:name])
  end
  erb(:library)
end

delete('/authors/:id') do
  @author = Author.find(params[:id].to_i())
  @author.delete()
  redirect to('/library')
end

get('/library/admin')do
  erb(:admin)
end

# get('edit/book/:id')do
#   erb(:edit)
# end

# get('edit/author/:id')do
#   erb(:edit)
# end

# get('edit/user/:id')do
#   erb(:edit)
# end