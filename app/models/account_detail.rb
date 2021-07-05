class AccountDetail < ApplicationRecord
  belongs_to :user
  has_many :loans
  belongs_to :bank_detail
end
