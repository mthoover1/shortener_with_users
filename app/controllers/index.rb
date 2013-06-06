get '/' do
  # Look in app/views/index.erb
  erb :index
end

post '/urls' do
  url = Url.new(params[:url])
  if user = User.find(session[:user])
    url.user = user
  end
  if url.save
    @short = "#{request.env['HTTP_ORIGIN']}/#{url.short_url}"
    erb :index
  else
    @errors = url.errors
    erb :index
  end
end



get '/signup' do
  erb :signup
end

post '/signup' do
  @user = User.new(params[:user])
  if @user.save
    redirect '/login'
  else
    @errors = @user.errors
    puts @user.errors.keys
    erb :signup
  end
end

get '/login' do
  erb :login
end

post '/login' do
  if User.authenticate(params[:user][:name], params[:user][:password])
    @user = User.find_by_name(params[:user][:name])
    session[:user] = @user.id
    redirect '/'
  else
    @errors = {error: "Invalid name or password."}
    erb :login
  end
end

get '/logout' do
  session.clear
  redirect '/'
end

get '/users/:id' do
  @user = User.find(params[:id])
  erb :stats
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
