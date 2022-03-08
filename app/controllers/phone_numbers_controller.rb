class PhoneNumbersController < ApiController

	before_action :authorize_user

	def create
	  @phone_number = PhoneNumber.find_by_phonenumber(params[:phone_number][:phonenumber])
	  if (@phone_number.try(:phonenumber) == params[:phone_number][:phonenumber].to_i) && (@phone_number.try(:user_id) == params[:phone_number][:user_id].to_i) 
	  	render json: {message: 'Already saved'}, status: :conflict
	  else	
		  if @phone_number.present?
		  	 generate_and_assign_phone_number
	       render json: {message: 'This Phone number is taken,so generated and assigned a new number', status: :ok}, status: :ok
		  else
		  	@phone_number = PhoneNumber.new(phone_number_params)
		  	if @phone_number.save
		  	  render json: {message: 'Assigned the phone number', status: :ok}, status: :ok
		  	else 
		  	  render json: {message: @phone_number.errors}, status: :conflict
		  	end	
		  end	
		end  
	end


	private

	def phone_number_params
	  params.require(:phone_number).permit(:user_id, :phonenumber)
	end

	def generate_and_assign_phone_number
      random_number = rand(1111111111..9999999999)
      if random_number.present?
        PhoneNumber.create(user_id: params[:phone_number][:user_id], phonenumber: random_number)
      else 
      	render json: {message: 'Cannot generate phone number'}, status: :conflict
      end
	end	


end
