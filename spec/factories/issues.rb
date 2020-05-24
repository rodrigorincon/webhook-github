FactoryBot.define do
	factory :issue do
  		github_id Faker::Number.number(digits: 9)
  		number Faker::Number.number(digits: 2)
  		url Faker::Lorem.word
  		title Faker::Lorem.word
  	end
end