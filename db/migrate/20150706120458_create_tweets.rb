class CreateTweets < ActiveRecord::Migration
  def change
  	create_table :tweets do |t|
  		t.string :tweet
  		t.integer :twitter_user_id

  		t.timestamps null: false
  	end  	
  	create_table :twitter_users do |t|
  		t.string :username

  		t.timestamps null: false
  	end
  end
end
