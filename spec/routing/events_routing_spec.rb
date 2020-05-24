require "rails_helper"

RSpec.describe EventsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/issues/:issue_number/events").to route_to("events#index", "number"=>":issue_number")
    end

    it "routes to #create" do
      expect(:post => "/events").to route_to("events#create")
    end

  end
end