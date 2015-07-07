get '/' do
	@user = TwitterUser.find_by_username("wwy93")
  erb :index
end

post '/' do
	@user = TwitterUser.find_by_username("wwy93")
	$client.update(params["tweet"])	
	if @user.tweets_stale?
		@user.fetch_tweets!
	else
		@user.fetch_tweets!	
	end
	@tweets = @user.tweets
	erb :"/tweets/show", layout: false
end

# get '/:username' do
# 	@user = TwitterUser.find_by_username(params[:username])
# 	if @user.tweets_stale?
# 		@user.fetch_tweets!
# 	end
# 	@tweets = @user.tweets
# 	erb :"/tweets/show"
# end