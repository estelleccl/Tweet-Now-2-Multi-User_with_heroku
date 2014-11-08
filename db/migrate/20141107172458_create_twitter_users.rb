class CreateTwitterUsers < ActiveRecord::Migration
  def change
  	create_table :twitter_users do |t|
  		t.string :twitter_username
  		t.string :consumer_key
  		t.string :consumer_secret
  		t.string :access_token
  		t.string :access_token_secret

  		t.timestamps
  	end
  end
end
