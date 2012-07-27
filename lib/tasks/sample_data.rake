namespace :db do 
	desc "fill database with sample data"
	task populate: :environment do
		admin = User.create!(name: "Kamaroon",email: "Kamaroon.m@hcl.com",password: "foobar",password_confirmation: "foobar")
		admin.toggle!(:admin)
		95.times do |n|
			name= Faker::Name.name
			email = "example-#{n-1}@gmail.com"
			password = "password"
			User.create!(name: name,email: email,password: password, password_confirmation: password)
		end
	end
end