class TwitterUser < ActiveRecord::Base
  # Remember to create a migration!
  has_many :tweets

  def fetch_tweets!
  	# byebug
  	if !self.tweets.empty?
  		self.tweets.destroy_all
  	end	
  	client = generateClient(self)
    client.user_timeline(self.username).take(10).each do |tweet|
  		self.tweets.new(tweet: tweet.text)
  		self.save
  	end
  end

  def postTweet(tweet)
    client = generateClient(self)
    # byebug
    client.update(tweet)    
  end

  def tweets_stale?

  	t = Time.now
  	# byebug
  	if self.tweets.empty?
  		true
  	else
	  	if self.tweets.first.updated_at + 15.minutes < Time.now
	  		true
      else
        false  
	  	end
	  end	
  end
  private
    def generateClient(user)
      client = Twitter::REST::Client.new do |config|
        config.consumer_key        = API_KEYS["development"]["twitter_consumer_key_id"]
        config.consumer_secret     = API_KEYS["development"]["twitter_consumer_secret_key_id"]
        config.access_token        = user.access_token
        config.access_token_secret = user.access_token_secret
      end
    end
  
end
