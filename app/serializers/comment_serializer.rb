class CommentSerializer < ActiveModel::Serializer
  attributes :user_id, :text
end
