# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

banks = Bank.create([{ name: 'State Bank of India' }, { name: 'HDFC'}, {name: 'ICICI', name: 'Bank of Baroda'}, {name: 'Axis Bank'}])


user = User.create([{ name: 'harshith', email: 'prasad.harshith@gmail.com', aadhar_number: 123456789012, pan_number: 'XXXXX1231D', inflow: 600000.0, outflow: 35000.0 }])


bank_details = BankDetail.create([{ifsc: "1233QER1", bank_id:1}, {ifsc: "1224QER1", bank_id:1}, {ifsc: "1463QER1", bank_id:1}, {ifsc: "1113POI1", bank_id:2}, {ifsc: "1213POI1", bank_id:2}])


account_details = AccountDetail.create([{user_id: 1, bank_detail_id: 1, number: "AASDAF112JHASD"}, {user_id: 1, bank_detail_id: 2, number: "AA232F112JHASD"}, {user_id: 1, bank_detail_id: 3, number: "AASDAF112JADD"}])


loans = Loan.create([{number: "A2KSJF11", account_detail_id: 3, credit_limit: 30000.0, emi: 2000.0, term: 10, user_id: 1, status: 1}, {number: "AKKS2F12", account_detail_id: 2, credit_limit: 50000.0, emi: 4420.0, term: 10, user_id: 1, status: 0},{number: "AKKSJF11", account_detail_id: 1, credit_limit: 25000.0, emi: 3410.0, term: 10, user_id: 1, status: 0}])
