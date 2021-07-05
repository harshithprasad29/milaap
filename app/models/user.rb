class User < ApplicationRecord
  has_many :account_details
  has_many :loans, through: :account_details
  has_many :approved_loans, -> { where status: 0 },
    class_name: "Loan"



  def self.list_loans(email)
  	user = User.includes(:loans).where("email= ?",email).first
  	loans = user.loans
  end

  def self.create_object(user)
  	new_loan = User.create(user)
  end


end