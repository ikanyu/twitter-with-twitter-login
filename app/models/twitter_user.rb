class TwitterUser < ActiveRecord::Base
  # Remember to create a migration!
  has_many :tweets

  def fetch_tweets!
  	byebug
  	if !self.tweets.empty?
  		Tweet.destroy(self.tweets)
  	end	
  	$client.user_timeline(self.username).take(10).each do |tweet|
  		self.tweets.new(tweet: tweet.text)
  		self.save
  	end
  end

  def tweets_stale?
  	t = Time.now
  	byebug
  	if self.tweets.empty?
  		true
  	else
	  	if self.tweets.first.updated_at + 15.minutes < Time.now
	  		false
	  	end
	  end	
  end
end
