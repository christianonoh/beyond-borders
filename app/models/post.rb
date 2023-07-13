class Post < ApplicationRecord
  belongs_to :user, foreign_key: 'author_id'
  has_many :comments
  has_many :likes

  after_create :increment_post_count
  after_destroy :decrement_post_count

  def increment_post_count
    puts 'Incrementing post count'
    user.increment!(:posts_counter)
  end

  def decrement_post_count
    puts 'Decrementing post count'
    user.decrement!(:posts_counter)
  end
end
