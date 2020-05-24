class Issue < ApplicationRecord
	has_many :events
	validates_presence_of :github_id, :number, :title, :url
end
