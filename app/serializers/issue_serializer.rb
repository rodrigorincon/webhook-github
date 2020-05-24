class IssueSerializer < ActiveModel::Serializer
  attributes :id, :github_id, :number, :title, :url

end