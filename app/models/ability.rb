class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, all
    
    return unless user.present?
      
    end
  end
end
