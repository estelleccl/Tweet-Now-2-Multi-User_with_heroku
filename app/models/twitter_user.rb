class TwitterUser < ActiveRecord::Base

   def fetch_tweets!
      client.user_timeline(self.twitter_username, count: 10)
   end

   def post_tweet!(tweet_msg)
      client.update(tweet_msg)
   end

   def self.find_by_username(user_info)
      # byebug
      if TwitterUser.exists?(twitter_username: user_info.info.nickname)
         user = TwitterUser.find_by(twitter_username: user_info.info.nickname)
         user.update(access_token: user_info.extra.access_token.token, access_token_secret: user_info.extra.access_token.secret)
         return user
      else
         TwitterUser.create(twitter_username: user_info.info.nickname, access_token: user_info.extra.access_token.token, access_token_secret: user_info.extra.access_token.secret)
      end
   end

   private
   def client
     Twitter::REST::Client.new do |config|
         config.consumer_key        = ENV['TWITTER_KEY']
         config.consumer_secret     = ENV['TWITTER_SECRET']
         config.access_token        = self.access_token
         config.access_token_secret = self.access_token_secret
     end
   end
end






# class TwitterUser < ActiveRecord::Base

# 	def self.fetch_tweets!(user)
# 		client = Twitter::REST::Client.new do |config|
#       config.consumer_key        = user.consumer_key
#       config.consumer_secret     = user.consumer_secret
#       config.access_token        = user.access_token
#       config.access_token_secret = user.access_token_secret
# 		end
# 	  client.user_timeline(user.twitter_username, count: 10)
# 	end

# 	def self.post_tweet!(user, tweet_msg)
# 		client = Twitter::REST::Client.new do |config|
#       config.consumer_key        = user.consumer_key
#       config.consumer_secret     = user.consumer_secret
#       config.access_token        = user.access_token
#       config.access_token_secret = user.access_token_secret
# 		end
# 		client.update(tweet_msg)
# 	end

# 	def self.find_by_username(user_info)
# 		# byebug
#    if TwitterUser.exists?(twitter_username: user_info.info.nickname)
#       user = TwitterUser.find_by(twitter_username: user_info.info.nickname)
#       user.update(consumer_key: user_info.extra.access_token.consumer.key, consumer_secret: user_info.extra.access_token.consumer.secret, access_token: user_info.extra.access_token.token, access_token_secret: user_info.extra.access_token.secret)
#       return user
#    else
#    	TwitterUser.create(twitter_username: user_info.info.nickname, consumer_key: user_info.extra.access_token.consumer.key, consumer_secret: user_info.extra.access_token.consumer.secret, access_token: user_info.extra.access_token.token, access_token_secret: user_info.extra.access_token.secret)
#    end
# 	end

# end