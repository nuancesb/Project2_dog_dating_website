class Ability
    include CanCan::Ability

    def initialize(user)
      user ||= User.new 
        if user.role?('admin')
            can :manage, :all
        elsif user.role?('user')
            can :read, :all
            can :edit, User, id: user.id 
            can :destroy, User, id: user.id
            can :manage, Dog, user_id: user.id 
        else user.persisted?
            can :read, :all
        end
    end

end
