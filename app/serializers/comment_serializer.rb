class CommentSerializer < ActiveModel::Serializer
  attributes :author_id, :text
end
