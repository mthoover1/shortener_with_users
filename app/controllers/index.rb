get '/' do
  # Look in app/views/index.erb
  erb :index
end


post '/urls' do
  puts request.inspect
  url = Url.new(params[:url])
  if url.save
    @short = "#{request.env['HTTP_ORIGIN']}/#{url.short_url}"
    erb :index
  else
    @errors = url.errors
    erb :index
  end
end


get '/:short' do
  if @url = Url.find_by_short_url(params[:short])
    @url.clicked
    erb :short_url
  else
    @errors = { error: "No url found"}
    erb :index
  end
end
