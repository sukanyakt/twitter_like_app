class SessionsController < Devise::SessionsController
  
  before_action :sign_in_params, only: :create
  before_action :load_user, only: [:create]

  before_action :authenticate_user!, except: :create
  before_action :authorize_user, only: :logout

  # sign in
  def create
    puts "SSSSSSSSSSSSSSSSs"
    if @user.valid_password?(sign_in_params[:password])
      render json: {
        messages: "Signed In Successfully",
        is_success: true,
        data: {user: @user}
      }, status: :ok
    else
      render json: {
        messages: "Signed In Failed - Unauthorized",
        is_success: false,
        data: {}
      }, status: :unauthorized
    end
  end

  def authorize_user
    auth_token = request.headers['Authorization'].split(' ').last if request.headers['Authorization'].present?
    puts "ggggggggg....."+auth_token.inspect
    unless auth_token.present?
      render json: { status: 'error', message: 'not_authorized' }, status: :unauthorized
    else 
      @current_user = User.find_by(authentication_token: auth_token)  
    end
  end  

  def logout
    auth_token = nil
    @current_user = nil
    render json: { status: 'logout successfully', message: 'logout successfully' }, status: :ok
  end  

  private

  def sign_in_params
    params.require(:user).permit(:email, :password)
  end

  def load_user
    @user = User.find_for_database_authentication(email: sign_in_params[:email])
    puts "333333333...."+@user.inspect
    if @user
      return @user
    else
      render json: {
        messages: "Cannot get User",
        is_success: false,
        data: {}
      }, status: :failure
    end
  end

end
