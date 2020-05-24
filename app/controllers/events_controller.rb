class EventsController < ApplicationController

	def index
		events = Event.joins(:issue).where(issues: {number: params[:number]})
		events_render = ActiveModelSerializers::SerializableResource.new(events, each_serializer: EventSerializer).to_json
   		render json: events_render
	end

	def create

	end
end
