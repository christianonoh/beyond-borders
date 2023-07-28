class Ability
  include CanCan::Ability

  def initialize(user)
    if user.role == 'admin'
      can :manage, :all
    else
      can :read, :all
      can :create, Post, author_id: user.id
      can :create, Comment, author_id: user.id
      can :create, Like
      can :destroy, Post do |post|
        post.author_id == user.id
      end
      can :destroy, Comment do |comment|
        comment.author_id == user.id
      end
    end
  end
end
