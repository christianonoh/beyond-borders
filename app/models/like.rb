class Like < ApplicationRecord
  belongs_to :user, foreign_key: 'author_id'
  belongs_to :post

  after_create :increment_like_count
  after_destroy :decrement_like_count

  def increment_like_count
    puts 'Incrementing likes count'
    post.increment!(:likes_counter)
  end

  def decrement_like_count
    puts 'Decrementing likes count'
    post.decrement!(:likes_counter)
  end
end
