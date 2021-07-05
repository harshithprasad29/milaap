module UsersHelper

	def self.process_user_fetch(user_obj)
		detail_hash = bank_details
		loan_array = Array.new
		user_obj.loans.each do |loan|
			loan_hash = Hash.new
			loan_hash[:name] = user_obj.name
			loan_hash[:email] = user_obj.email
			loan_hash[:loan_number] = loan.number
			loan_hash[:credit] = loan.credit_limit
			loan_hash[:emi] = loan.emi
			loan_hash[:term] = loan.term
			loan_hash[:status] = loan.status
			loan_hash[:account_number] = loan.account_detail.number
			loan_hash[:bank] = detail_hash[loan.account_detail.bank_detail_id][:bank_name]
			loan_hash[:ifsc] = detail_hash[loan.account_detail.bank_detail_id][:ifsc]
			loan_array << loan_hash
		end
		loan_array
	end


	def self.bank_details
		details = BankDetail.includes(:bank)
		detail_hash = Hash.new
		details.each do |detail|
			detail_hash[detail.id] ||= Hash.new
			detail_hash[detail.id] = {bank_name: detail.bank.name, ifsc: detail.ifsc}
		end
		detail_hash
	end

end
