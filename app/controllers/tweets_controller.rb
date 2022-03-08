class TweetsController < ApiController
  
  before_action :authorize_user
  before_action :get_tweet, only: :get_tweet_owner

  def create
    @tweet = Tweet.new(tweet_params)
    if @tweet.save
      render json: @tweet, message: "Tweet created Successfully", status: :created
    else
      render json: @tweet.errors, message: "Cannot create tweet", status: :unprocessable_entity
    end
  end

  def get_tweets
    @user_tweets = Tweet.get_user_tweets(params[:user_id])
    if @user_tweets.blank?
      render json: {message: "No tweets for the user" }
    else 
      render json: @user_tweets.order("created_at desc"), message: "Tweets of the user"
    end  
  end  

  def get_tweet_owner
    if @tweet.present?
      @tweet_owner = @tweet.try(:user)
      render json: @tweet_owner, message: "Tweet Owner"
    else 
      render json: {message: "Cannot get the tweet owner" }
    end  
  end

  def followees_tweets 
    @followees_tweets = Tweet.tweets_of_followees(params[:user_id])
    if @followees_tweets.present?
      render json: @followees_tweets.order("created_at desc"), message: "Tweets of followees:"
    else 
      render json: {message: "No tweets for the followees" }
    end  
  end 

  private

  def tweet_params
    params.require(:tweet).permit(:user_id, :tweet_text)
  end  

  def get_tweet
    @tweet = Tweet.find_by(id: params[:tweet][:id])
  end  

end
