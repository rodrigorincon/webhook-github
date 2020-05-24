require 'rails_helper'

RSpec.describe CreateEventService, type: :service do

  let!(:issue) do
    {
      id: Faker::Number.number(digits: 9),
      number: Faker::Number.number(digits: 2),
      url: Faker::Lorem.word,
      title: Faker::Lorem.word
    }
  end

  let!(:saved_issue) do
    {
      github_id: issue[:id],
      number: issue[:number],
      url: issue[:url],
      title: "ja existo"
    }
  end

  let!(:event) do
    {
      action: Faker::Lorem.word,
      sender_id: Faker::Number.number(digits: 7),
      repository_id: Faker::Number.number(digits: 7)
    }
  end


  describe "initialize method" do
    
    describe "without an saved issue" do
      before(:each) do
        @service = CreateEventService.new(issue, event)
      end
    
      it "create the both objects but not save in database" do
        expect(@service.issue.id).to be_nil
        expect(@service.event.id).to be_nil
      end

      it "already didnt have assosciation between the objects" do
        expect(@service.event.issue_id).to be_nil
      end
    end

    describe "with an saved issue" do
      before(:each) do
        Issue.create(saved_issue)
        @service = CreateEventService.new(issue, event)
      end

      it "if issue already exist, get it from database" do
        expect(@service.issue.id).to_not be_nil
        expect(@service.issue.title).to eq(saved_issue[:title])
      end
    end
  end

  describe "save method" do
    describe "if didnt exist the issue" do
      before(:each) do
        @service = CreateEventService.new(issue, event)
      end
    
      it "create a new issue and event" do
        total_events = Event.count
        total_issues = Issue.count
        @service.save
        
        expect(Issue.count).to_not eq(total_issues)
        expect(Event.count).to_not eq(total_events)

        expect(Issue.last.github_id).to eq(@service.issue.github_id)
      end
    end

    describe "if already exist the issue" do
      before(:each) do
        Issue.create(saved_issue)
        @service = CreateEventService.new(issue, event)
      end
    
      it "create only a new event" do
        total_events = Event.count
        total_issues = Issue.count
        @service.save
        
        expect(Issue.count).to eq(total_issues)
        expect(Event.count).to_not eq(total_events)
      end
    end
  end

end