include UsersHelper
class UsersController < ApplicationController
	before_action :set_user, only: %i[ fetch ]
	def fetch
      @status = false
      if @user
        @success = true
        @display_data = UsersHelper.process_user_fetch(@user)
        @user_email = params[:email]
      end
	end

  private
    def set_user
      @user = User.includes(:account_details, :loans).where("email = ?",params[:email]).first
    end

    def user_params
      params.require(:user).permit(:name, :email, :aadhar_number, :pan_number, :inflow, :outflow)
    end

end
