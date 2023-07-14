require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create(name: 'John Doe') }
  let(:post) { Post.create(author_id: user.id, title: 'Test Post', text: 'Lorem ipsum') }
  let(:comment) { Comment.create(author_id: user.id, post_id: post.id) }

  describe 'callbacks' do
    describe 'after_create' do
      it 'increments the comments_counter of the associated post' do
        expect { comment }.to change { post.reload.comments_counter }.by(1)
      end
    end

    describe 'after_destroy' do
      it 'decrements the comments_counter of the associated post' do
        comment # Create the comment first
        expect { comment.destroy }.to change { post.reload.comments_counter }.by(-1)
      end
    end
  end
end
