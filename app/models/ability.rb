class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, all
    
    return unless user.present?

      can :manage, Category, author_id: user.id
      can :manage, Entity, author_id: user.id
    end
  end
end
