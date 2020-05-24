require 'rails_helper'

RSpec.describe "Events", type: :request do

  describe 'GET /issues/:issue_number/events ' do

    let!(:issue) {create(:issue)}
    let!(:event) {create(:event)}

    before(:each) do 
      get events_issue_path(issue.number), headers: { 'Accept': 'application/json' }
    end

    it 'respond 200 http code' do
      expect(response).to have_http_status(200)
    end

    it 'respond the right json' do
      json = JSON.parse(response.body)
      expect(json.size).to eq(1)
      expect(json.first["id"]).to eq(event.id)
      expect(json.first["issue"]["github_id"]).to eq(issue.github_id)
    end
  end

  describe 'POST /events' do

    let!(:params) do
      {
        issue: {
          id: Faker::Number.number(digits: 9),
          number: Faker::Number.number(digits: 2),
          title: Faker::Lorem.word,
          url: Faker::Lorem.word
        },
        event: {
          action: Faker::Lorem.word
        },
        sender: {
          id: Faker::Number.number(digits: 7)
        },
        repository: {
          id: Faker::Number.number(digits: 7)
        }
      }
    end

    before(:each) do
      @events_count = Event.count
      post events_path(params), headers: { 'Accept': 'application/json' }
    end

    it 'respond 201 http code' do
      expect(response).to have_http_status(201)
    end

    it 'A new event must be created' do
      expect(Event.count).to eq(@events_count + 1)
    end

  end

end