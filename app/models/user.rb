require 'net/http'

class User < ApplicationRecord
  validates :name, presence: true
  validates :posts_counter, comparison: { greater_than_or_equal_to: 0 }

  has_many :posts, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  def likes?(post)
    likes.exists?(post_id: post.id)
  end

  def valid_image_url?(url)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.scheme == 'https'

    response = nil
    begin
      response = http.request_head(uri.path)
    rescue SocketError, Errno::ECONNREFUSED, Net::OpenTimeout, Net::ReadTimeout
      return '/images/default.jpg'
    end
    response.code.to_i == 200 ? url : '/images/default.jpg'
  end
end
