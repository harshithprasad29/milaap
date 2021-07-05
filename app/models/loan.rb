class Loan < ApplicationRecord
  enum status: [:approved, :rejected]
  belongs_to :account_detail
  has_one :user, through: :account_detail


  def self.create_object(loan)
  	new_user = Loan.create(loan)
  end

end
