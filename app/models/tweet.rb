class Tweet < ApplicationRecord
	belongs_to :user

	scope :get_user_tweets, ->(user_id) {where(user_id: user_id)}

	scope :tweets_of_followees, ->(user_id) {where("user_id in (?)", User.get_followees_ids(user_id))}
end
