get '/' do
	@user = TwitterUser.find_by_username(session[:username])

  erb :index
end

post '/' do
	@user = TwitterUser.find_by_username(session[:username])
	# TwitterUser.generateclient
	# byebug
	@user.postTweet(params["tweet"])
	# $client.update(params["tweet"])	
	if @user.tweets_stale?
		@user.fetch_tweets!
	else
		@user.fetch_tweets!	
	end
	@tweets = @user.tweets
	erb :"/tweets/show", layout: false
end

get '/login' do
	session[:admin] = true
	redirect to ("/auth/twitter")
end

get '/auth/twitter/callback' do
	#byebug
	env['omniauth.auth'] ? session[:admin] = true : halt(401,'Not Authorised')
	"Logged In"
	# byebug
	@user = TwitterUser.find_or_create_by(username: env['omniauth.auth']['info']['nickname'])
	@access_token = env['omniauth.auth']['credentials']['token']
	@access_secret = env['omniauth.auth']['credentials']['secret']
	@user.access_token = @access_token
	@user.access_token_secret = @access_secret
	@user.save
	
	session[:username] = @user.username
	redirect '/'
end

get '/auth/failure' do
	params[:message]
end

get '/logout' do
	session[:admin] = nil
	# session.destroy
	session[:username] = nil
	redirect '/'
end

# get '/:username' do
# 	@user = TwitterUser.find_by_username(params[:username])
# 	if @user.tweets_stale?
# 		@user.fetch_tweets!
# 	end
# 	@tweets = @user.tweets
# 	erb :"/tweets/show"
# end