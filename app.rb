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
  erb(:library) #erb file name
end

post('/authors') do ## Adds album to list of albums, cannot access in URL bar
  name = params[:album_name]
  author = Author.new(name, nil, artist, genre, year)
  author.save()
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