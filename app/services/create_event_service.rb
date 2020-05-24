class CreateEventService

	attr_reader :issue, :event
	
	def initialize(issue_prm, event_prm)
    	@issue = Issue.find_by(github_id: issue_prm[:id])
		if @issue.nil?
			@issue = Issue.new({
				github_id: issue_prm[:id],
				number: issue_prm[:number],
      			title: issue_prm[:title],
      			url: issue_prm[:url]
			})
		end

    	@event = Event.new(event_prm)
  	end

  	def save
  		ActiveRecord::Base.transaction do
			@issue.save!
			@event.issue_id = @issue.id
			@event.save!
			true
  		rescue  ActiveRecord::RecordInvalid => e
  			false
  		end
  	end

end