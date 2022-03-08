class FollowController < ApiController

   before_action :authorize_user
  
   before_action :set_follow, :follow_params

  # To follow a user. user_id => follower, following_id => following_id
  # user with user_id follows user with following_id
  # follower is user and following is user with id following_id
  def create
    puts "DDDDDDDDDDDDDDDDDDDD>....."
    if @follow.present?
      render json: {message: 'Already following', status: :ok}, status: :ok
    else 
      @follow = Follow.new(follow_params)
      if @follow.save
        render json: {message: 'You followed the user', status: :ok}, status: :created
      else 
        render json: {message: 'Cannot follow'}, status: :conflict
      end  
    end  
  end

  def unfollow
    puts "LLLLLLLLLLLLLLLL..."+@follow.inspect
    if @follow.present?
      if @follow.destroy
        render json: {message: 'Unfollowed Successfully', status: :ok}, status: :ok
      else
        render json: {message: 'Cannot unfollow'}, status: :conflict
      end  
    else 
      render json: {message: 'follow not existing', status: :conflict}, status: :conflict
    end
  end

  private

  def set_follow
    puts "aaaaaaaaaa....."
    @follow = Follow.find_by(user_id: params[:follow][:user_id], following_id: params[:follow][:following_id])
  end  

  def follow_params
    puts "hhhhhhhhhhhh......."
    params.require(:follow).permit(:user_id, :following_id)
  end  

end
