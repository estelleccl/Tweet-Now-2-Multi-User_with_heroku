configure do
  enable :sessions
end

get '/login' do
  session[:admin] = true
  redirect to("/auth/twitter")
end
 
get '/logout' do
  session[:admin] = nil
  session[:username] = nil
  redirect '/'
end

get '/auth/twitter/callback' do
  env['omniauth.auth'] ? session[:admin] = true : halt(401,'Not Authorized')
  "You are now logged in"
  "<h1>Hi #{env['omniauth.auth']['info']['name']}!</h1><img src='#{env['omniauth.auth']['info']['image']}'>"
  @user = TwitterUser.find_by_username(env['omniauth.auth'])
  session[:username] = @user.twitter_username
  @tweets = TwitterUser.fetch_tweets!(@user)
  redirect '/home'
end

get '/auth/failure' do
  params[:message]
end