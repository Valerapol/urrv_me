class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
  def index?
    @user.has_role?(:admin) || @user.has_role?(:staff) || @user.has_role?(:instructor) || @user.has_role?(:mentor)
  end

  def show?
    @user.has_role?(:admin) || @user.has_role?(:staff) || @user.has_role?(:instructor) || @user.has_role?(:mentor)
  end

  def edit?
    @user.has_role?(:admin) || @user.has_role?(:staff) || @user.has_role?(:instructor) || @user.has_role?(:mentor)
  end

  def update?
    @user.has_role?(:admin) || @user.has_role?(:staff) || @user.has_role?(:instructor) || @user.has_role?(:mentor)
  end
end
