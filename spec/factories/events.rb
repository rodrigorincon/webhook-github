FactoryBot.define do
	factory :event do
  		action Faker::Lorem.word
      	sender_id Faker::Number.number(digits: 7)
      	repository_id Faker::Number.number(digits: 7)
      	association :issue
  	end
end