class ApiController < ActionController::API
	
  def authorize_user
    auth_token = request.headers['Authorization'].split(' ').last if request.headers['Authorization'].present?
    puts "================"+auth_token.inspect
    if auth_token.blank?
    	puts "blank.................................."
      render json: { status: 'error', message: 'not_authorized' }, status: :unauthorized
    else
    	puts "not blank..................................."
      @current_user = User.find_by(authentication_token: auth_token)
      puts "----------------------"+@current_user.inspect
    end
  end 

end
