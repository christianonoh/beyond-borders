class Comment < ApplicationRecord
  belongs_to :user, foreign_key: 'author_id'
  belongs_to :post

  after_create :increment_comment_count
  after_destroy :decrement_comment_count

  def increment_comment_count
    puts 'Incrementing comments count'
    post.increment!(:comments_counter)
  end

  def decrement_comment_count
    puts 'Decrementing comments count'
    post.decrement!(:comments_counter)
  end
end
