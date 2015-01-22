class Ability
    include CanCan::Ability

    def initialize(user)
      user ||= User.new 
        if user.role?('admin')
            can :manage, :all
        elsif user.role?('user')
            can :read, :all
            can :update, User, id: user.id 
            can :destroy, User, id: user.id
            can :create, Dog, user_id: user.id
            can :edit, Dog, user_id: user.id 
            can :update, Dog, user_id: user.id 
            can :destroy, Dog, user_id: user.id 
            can :like, Dog 
            can :unlike, Dog
        else user.persisted?
            can :read, :all
        end
    end

end
