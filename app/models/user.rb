require 'net/http'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

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
    return '/images/default.jpg' if url.nil?

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
