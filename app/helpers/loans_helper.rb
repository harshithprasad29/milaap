require 'net/http'
require 'uri'
module LoansHelper


	def self.create_loan(loan)
		max_emi = (loan[:inflow].to_f/2-loan[:outflow].to_f)
		terms = calculate_terms(max_emi)
		credit_limit = max_emi * terms

		loan_user = User.where("email = ?", loan[:email]).first
		user = loan_user ? loan_user : User.create_object({email: loan[:email]})
		recommendation = credibility_score(loan[:email], user)
		[max_emi, terms, credit_limit, recommendation]
		loan_hash = {credit_limit: credit_limit, status: recommendation, account_detail_id: 1}
		new_loan = Loan.create_object(loan_hash)
		loans_list
	end

	def self.loans_list
		all_loans = Loan.includes(:user).all
		display_loans = display_data(all_loans)
	end


	def self.calculate_terms(max_emi)
		terms = 0
		case 
		when (0..5000).include?(max_emi)
		  terms = 6
		when (5001..10000).include?(max_emi)
		  terms = 12
		when (10001..20000).include?(max_emi)
		  terms = 18
		else
		  terms = 24
		end
	end

	# curl -H "X-FullContact-APIKey:uA6TuVzTHWADhBuZYaRND38YTsLgFihx" https://api.fullcontact.com/v2/person.json?email=<email address>


	def credibility_score(email, user)

		credit_score = 0
		recommendation = 1
		fullcontact_data = call_fullcontact(email)
		social_profiles = fullcontact_data[:socialProfiles]
		social_profiles = social_profiles.class == Array ? social_profiles : [social_profiles]

		social_profiles.each do |social|
			if ["linkedin","twitter","facebook"].include?(social[:type])
				credit_score += 1
			end
		end
		approved_loans = user ? user.approved_loans.count : 0 
		if approved_loans >= 1
			credit_score += 1
		end

		if credit_score > 2
			recommendation = 0
		end
		recommendation
	end

	def call_fullcontact(email)

		uri = URI.parse("https://api.fullcontact.com/v2/person.json?email=#{email}")
		request = Net::HTTP::Get.new(uri)
		request["X-Fullcontact-Apikey"] = "uA6TuVzTHWADhBuZYaRND38YTsLgFihx"

		req_options = {
		  use_ssl: uri.scheme == "https",
		}

		response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
			http.request(request)
		end

		data = response.body

		data = {
		   "status":200,
		   "requestId":"e158b690-4c96-4542-bd1a-f5a374580156",
		   "likelihood":0.95,
		   "contactInfo":{
		      "familyName":"Raphy",
		      "fullName":"Renil Raphy",
		      "givenName":"Renil"
		   },
		   "organizations":[
		      {
		         "isPrimary":false,
		         "name":"Skreem",
		         "startDate":"2016-03",
		         "title":"Software Developer",
		         "current":true
		      },
		      {
		         "isPrimary":false,
		         "name":"Carettech Cosultancy Ltd",
		         "startDate":"2013-10",
		         "title":"Junior Software Engineer",
		         "current":true
		      }
		   ],
		   "demographics":{
		      "locationDeduced":{
		         "deducedLocation":"Thrissur, Kerala, India",
		         "city":{
		            "deduced":false,
		            "name":"Thrissur"
		         },
		         "state":{
		            "deduced":false,
		            "name":"Kerala"
		         },
		         "country":{
		            "deduced":false,
		            "name":"India",
		            "code":"IN"
		         },
		         "continent":{
		            "deduced":true,
		            "name":"Asia"
		         },
		         "county":{
		            "deduced":true,
		            "name":"Thrissur District"
		         },
		         "likelihood":1.0
		      },
		      "gender":"Male",
		      "locationGeneral":"Thrissur, Kerala, India"
		   },
		   "socialProfiles":[
		      {
		         "bio":"I am working on Web applications mainly in 'Ruby on Rails', and have knowledge in 'Django' framework too.",
		         "followers":272,
		         "following":272,
		         "type":"linkedin",
		         "typeId":"linkedin",
		         "typeName":"LinkedIn",
		         "url":"https://www.linkedin.com/in/renil-raphy-16a35661",
		         "username":"renil-raphy-16a35661",
		         "id":"218837602"
		      },
		      {
		         "followers":28,
		         "following":34,
		         "type":"twitter",
		         "typeId":"twitter",
		         "typeName":"Twitter",
		         "url":"https://twitter.com/renilraphyp100",
		         "username":"renilraphyp100",
		         "id":"1269251400"
		      }
		   ]
		}
	end


	def display_data(loans)
		loans_list = []
		loans.each do |loan|
			loans_list << {email: loan.user.email, credit_limit: loan.credit_limit, status: loan.status}
		end
		loans_list
	end

end
