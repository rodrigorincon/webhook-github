class EventSerializer < ActiveModel::Serializer
  attributes :id, :action, :sender_id, :repository_id

  belongs_to :issue

end