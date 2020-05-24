class EventsController < ApplicationController

	def index
		events = Event.joins(:issue).where(issues: {number: params[:number]})
		events_render = ActiveModelSerializers::SerializableResource.new(events, each_serializer: EventSerializer).to_json
   		render json: events_render
	end

	def create
		issue_prm = params[:issue]
		event_prm = {
			action: params[:event][:action],
			sender_id: params[:sender][:id],
			repository_id: params[:repository][:id]
		}

		event_service = CreateEventService.new(issue_prm, event_prm)

		if event_service.save
			render json: {}, status: :created
		else
			render json: {}, status: :unprocessable_entity
		end
	end
end
