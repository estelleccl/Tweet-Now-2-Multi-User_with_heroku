get '/' do
  erb :index
end

get '/home' do
  @user = TwitterUser.find_by(twitter_username: session[:username])
  @tweets = TwitterUser.fetch_tweets!(@user)
  erb :index
end

post '/tweet' do
  halt(401,'Not Authorized') unless admin?
  @user = TwitterUser.find_by(twitter_username: session[:username])
  TwitterUser.post_tweet!(@user, params[:tweet_msg])
  @tweets = TwitterUser.fetch_tweets!(@user)
  erb :show
end

get '/tweet' do
  halt(401,'Not Authorized') unless admin?
  @user = TwitterUser.find_by(twitter_username: session[:username])
  @tweets = TwitterUser.fetch_tweets!(@user)
  erb :show
end
 
get '/public' do
  "This is the public page - everybody is welcome!"
end
 
get '/private' do
  halt(401,'Not Authorized') unless admin?
  "This is the private page - members only"
end
