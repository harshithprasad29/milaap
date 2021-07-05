include LoansHelper
class LoansController < ApplicationController

	def index
		@loans = LoansHelper.loans_list
		render "loan_recommendation"
	end

	def loan_recommendation
		@loans = LoansHelper.create_loan(params)
	end


  private

    def user_params
      params.require(:loan).permit(:email, :pancard, :aadhar, :bank, :ifsc, :account_number, :inflow, :outflow)
    end




end
