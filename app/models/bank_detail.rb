class BankDetail < ApplicationRecord
	belongs_to :bank
	has_many :account_details
end
