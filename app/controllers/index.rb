get '/' do
  erb :index
end

post '/' do
	redirect to "/#{params[:username]}"
end

get '/:username' do
	@user = TwitterUser.find_by_username(params[:username])
	# if @user.tweets.empty?
	# 	@user.fetch_tweets
	# end

	if @user.tweets_stale?
	# 	@user = TwitterUser.new(username: params[:username])
	# 	@user.fetch_tweets!
	# else
	# 	if @user.tweets_stale?
				@user.fetch_tweets!
		# end	
	end
	@tweets = @user.tweets
	erb :"/tweets/show"
end