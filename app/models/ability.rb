class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    if user.is_a?(EventOrganizer)
      can :manage, Event, event_organizer_id: user.id
    elsif user.is_a?(Customer)
      can :read, Event
      can :create, Booking
    end
  end
end