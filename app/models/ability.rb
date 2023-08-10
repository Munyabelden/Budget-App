class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, all

    return unless user.present?

    can :manage, Category, user_id: user.id
    can :manage, Entity, user_id: user.id
  end
end
