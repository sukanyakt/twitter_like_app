class UsersController < ApiController

  before_action :authorize_user

  def profile
    @followers = @current_user.try(:followers)
    @following = @current_user.try(:following)
    @tweets = @current_user.try(:tweets)
    render json: {data: {follower: @followers, following: @following, tweets: @tweets}}
  end

end
